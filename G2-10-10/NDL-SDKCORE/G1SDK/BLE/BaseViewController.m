                                                                                                                   //
//  BaseViewController.m
//  MovePower
//
//  Created by wudi on 15-8-5.
//  Copyright (c) 2015年 NDL. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "UIUtils.h"
#import "LPPopup.h"
#import "ConnectDeviceViewController.h"
#import "AFNetworking.h"
#include "des.h"
#import "KVNProgress.h"
#import "CustomAlertView.h"
#import "BluetoothConnectionViewController.h"

@interface BaseViewController ()
{
    NSTimer *timer;
    BOOL hasSettedParam;
    BOOL hasDone;
    
    NSString *web_kernel;
    NSString *web_task;
    NSString *pos_kernel;
    NSString *pos_task;
    NSMutableArray *updateFiles;
    CustomAlertView *cav;
    
    UINavigationController *_nc;
}
@end

@implementation BaseViewController


static void HexString2Bytes(unsigned char *hexstr,unsigned char *str) {
    int no = strlen(hexstr)/2;
		  for (int i = 0; i < no; i++) {
              unsigned char c0 = *hexstr++;
              unsigned char c1 = *hexstr++;
              str[i] = (unsigned char) ((parse(c0) << 4) | parse(c1));
              //printf("%x\n",str[i]);
          }
    
}

static char parse(char c) {
    if (c >= 'a')
        return (c - 'a' + 10) & 0x0f;
    if (c >= 'A')
        return (c - 'A' + 10) & 0x0f;
    return (c - '0') & 0x0f;
}

//解密从服务器获取的主密钥
-(NSString *)decryptMainKey:(NSString *)mainKey{
    
    NSMutableString *des = [[NSMutableString alloc]initWithString:@""];
    
    NSString *src1 = [mainKey substringToIndex:16];
    NSString *src2 = [mainKey substringFromIndex:16];
    
    
    unsigned char *lpIn = [src1 cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char *key = kDecryptKey;
    unsigned char key1[16];
    HexString2Bytes(key, key1);
    
    unsigned char lpIn1[8];
    HexString2Bytes(lpIn, lpIn1);
    
    unsigned char lpOut[8];
    
    
    des3_decrypt(lpIn1, lpOut, key1);
    
    
    unsigned char d[17];
    d[16] = '\0';
    for (int i = 0; i<8; i++) {
        sprintf(&d[i * 2],"%.2X",lpOut[i]);
    }
    
    [des appendString:[NSString stringWithCString:d encoding:NSUTF8StringEncoding]];
    
    lpIn = [src2 cStringUsingEncoding:NSUTF8StringEncoding];
    HexString2Bytes(lpIn, lpIn1);
    des3_decrypt(lpIn1, lpOut, key1);
    
    for (int i = 0; i<8; i++) {
        sprintf(&d[i * 2],"%.2X",lpOut[i]);
    }
    
    [des appendString:[NSString stringWithCString:d encoding:NSUTF8StringEncoding]];
    
    
    return des;
}

- (void)setPosWithParams:(NSDictionary *)dictionary success:(void (^)())success{
    
    
    dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.downloadParam", DISPATCH_QUEUE_SERIAL);
    
    
    NSArray *array = [dictionary allKeys];
    
    for (NSString *key in array) {
        
        dispatch_async(serial_queue, ^{
            hasSettedParam = false;
            MiniPosSDKSetParam("000000000", [UIUtils UTF8_To_GB2312:key], [[dictionary objectForKey:key]UTF8String]);
            while (hasSettedParam ==false) {
                NSLog(@"MiniPosSDKSetParam----while");
                [NSThread sleepForTimeInterval:0.125];
            }
            
            NSLog(@"MiniPosSDKSetParam----done");
            
        });
        
    }
    
    dispatch_async(serial_queue, ^{
        hasSettedParam = false;
        MiniPosSDKSetParam("000000000", "", "");
        while (hasSettedParam ==false) {
            //NSLog(@"MiniPosSDKSetParam----while");
            [NSThread sleepForTimeInterval:0.125];
        }
        
        [self hideHUD];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            if(success){
                success();
            }
            
        });
        
    });
    
    
}


- (void)activateG2{
    
    
    NSString *G2NDLId = [[NSUserDefaults standardUserDefaults] stringForKey:kG2NDLId];
    NSString *G2TencrwinId = [[NSUserDefaults standardUserDefaults] stringForKey:kG2TencrwinId];
    NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1SN];
    //mposIP
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/activateG2.action?mid=%@&ndlMid=%@&sn=%@&flagCode=0800362",kServerIP,kServerPort,G2TencrwinId,G2NDLId,sn];
    NSLog(@"激活url:%@",url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        NSLog(@"msg:%@",responseObject[@"resultMap"][@"msg"]);
        
        int code = [responseObject[@"resultMap"][@"code"]intValue];

        if (code == 0 ){ //激活成功
            
            NSLog(@"激活成功");
            [[NSUserDefaults standardUserDefaults]setBool:false forKey:kMposG2IsNewDevice];
            [self downloadParamsTransferToPos];
            
        }else{
            
            [self showTipView:responseObject[@"resultMap"][@"msg"]];
            //[self downloadParamsTransferToPos];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

//验证pos端的参数，成功后执行block
- (void) verifyParamsSuccess:(void (^)())success{
    {
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1SN];
        NSString *merchantNo  = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1MerchantNo];
        NSString *terminalNo  = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo];
        NSString *phoneNo = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginPhoneNo];
        
        //terminalNo = @"111";
        
        NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/keyIssued.action?sn=%@&user=%@&mid=%@&tid=%@&flag=0800003",kServerIP,kServerPort,sn,phoneNo,merchantNo,terminalNo];
        NSLog(@"url:%@",url);
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"responseObject:%@",responseObject);
            NSLog(@"msg:%@",responseObject[@"resultMap"][@"msg"]);
            
            int code = [responseObject[@"resultMap"][@"code"]intValue];
            
            if (code == 3 ) {
                
                [self showHUD:@"正在写入参数"];
                
                
                NSString *mainKey  = [self decryptMainKey:responseObject[@"resultMap"][@"tmk"]];
                NSString *tid = responseObject[@"resultMap"][@"tid"];
                NSString *mid = responseObject[@"resultMap"][@"mid"];
                NSLog(@"mainKey:%@",mainKey);
                
                NSDictionary *dictionary = @{@"商户号":mid,@"终端号":tid,@"主密钥1":mainKey};
                
                [self setPosWithParams:dictionary success:^{
//                    if(MiniPosSDKPosLogin()>=0)
//                    {
//                        
//                        [self showHUD:@"正在签到"];
//
//                    }
                    
                    [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                    [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                    [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.SDK", DISPATCH_QUEUE_SERIAL);
                    
                    
                    BOOL hasSignedIn = [[NSUserDefaults standardUserDefaults] boolForKey:kHasSignedIn];
                    
                    
                    if (!hasSignedIn) {
                        dispatch_async(serial_queue, ^{
                            hasDone = false;
                            
                            if(MiniPosSDKPosLogin()>=0)
                            {
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //                                [self showHUD:@"正在签到"];
                                    [self showTipView:@"正在签到"];
                                });
                                
                                
                            }
                            
                            while (hasDone ==false) {
                                [NSThread sleepForTimeInterval:0.125];
                                NSLog(@"wwwwwwww");
                            }
                            
                            [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
                            NSLog(@"hasDone");
                        });
                    }
                    
                    dispatch_async(serial_queue, ^{
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            success();
                            NSLog(@".......");
                        });
                        
                    });
                }];
                

                
                
                
            }else  if (code == 0 ) {  //参数已是最新，可以触发签到;
                
                dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.SDK", DISPATCH_QUEUE_SERIAL);
                
                
                BOOL hasSignedIn = [[NSUserDefaults standardUserDefaults] boolForKey:kHasSignedIn];
                

                if (!hasSignedIn) {
                    dispatch_async(serial_queue, ^{
                        hasDone = false;
                        
                        if(MiniPosSDKPosLogin()>=0)
                        {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
//                                [self showHUD:@"正在签到"];
                                [self showTipView:@"正在签到"];
                            });
                            
                            
                        }
                        
                        while (hasDone ==false) {
                            [NSThread sleepForTimeInterval:0.125];
                            NSLog(@"wwwwwwww");
                        }
                        
                        [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
                        NSLog(@"hasDone");
                    });
                }
                
                dispatch_async(serial_queue, ^{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success();
                        NSLog(@".......");
                    });
                    
                });
                
                               
                
                
            }else if(code == 4){  //参数更新失败，MPOS机身码、用户名、商户号、终端号四个字段信息不匹配
                
                
                AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                
                NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1SN];
                NSString *merchantNo  = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1MerchantNo];
                NSString *terminalNo  = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo];
                NSString *phoneNo = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginPhoneNo];
                
                
                
                NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/keyIssued.action?sn=%@&user=%@&mid=%@&tid=%@&flag=0800364",kServerIP,kServerPort,sn,phoneNo,merchantNo,terminalNo];
                NSLog(@"url:%@",url);
                
                [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSLog(@"responseObject:%@",responseObject);
                    NSLog(@"msg:%@",responseObject[@"resultMap"][@"msg"]);
                    
                    int code = [responseObject[@"resultMap"][@"code"]intValue];
                    
                    if (code == 3 ) {   //正在更新参数，请耐心等待...
                        
                        [self showHUD:@"正在写入参数"];
                        
                        
                        NSString *mainKey  = [self decryptMainKey:responseObject[@"resultMap"][@"tmk"]];
                        NSString *tid = responseObject[@"resultMap"][@"tid"];
                        NSString *mid = responseObject[@"resultMap"][@"mid"];
                        NSLog(@"mainKey:%@",mainKey);
                        
                        NSDictionary *dictionary = @{@"商户号":mid,@"终端号":tid,@"主密钥1":mainKey};
                        
                        [self setPosWithParams:dictionary success:^{
//                            if(MiniPosSDKPosLogin()>=0)
//                            {
//                                
//                                [self showTipView:@"正在签到"];
//                            
//                            }
                            
                            [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                            [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                            [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            
                            dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.SDK", DISPATCH_QUEUE_SERIAL);
                            
                            
                            BOOL hasSignedIn = [[NSUserDefaults standardUserDefaults] boolForKey:kHasSignedIn];
                            
                            
                            if (!hasSignedIn) {
                                dispatch_async(serial_queue, ^{
                                    hasDone = false;
                                    
                                    if(MiniPosSDKPosLogin()>=0)
                                    {
                                        
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            //                                [self showHUD:@"正在签到"];
                                            [self showTipView:@"正在签到"];
                                        });
                                        
                                        
                                    }
                                    
                                    while (hasDone ==false) {
                                        [NSThread sleepForTimeInterval:0.125];
                                        NSLog(@"wwwwwwww");
                                    }
                                    
                                    [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
                                    NSLog(@"hasDone");
                                });
                            }
                            
                            dispatch_async(serial_queue, ^{
                                
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    success();
                                    NSLog(@".......");
                                });
                                
                            });

                        }];
                        
      
                        
                        
                        
                    }else{
                        
                        [self showTipView:responseObject[@"resultMap"][@"msg"]];
                    }
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                    [self hideHUD];
                    NSLog(@"failure");
                    [self showTipView:@"网络异常"];
                }];
                
            }else{
                
                [self showTipView:responseObject[@"resultMap"][@"msg"]];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self hideHUD];
            NSLog(@"failure");
            [self showTipView:@"网络异常"];
        }];
    }
}



-(void)downloadParamsTransferToPos{
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1SN];
    NSString *merchantNo  = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1MerchantNo];
    NSString *terminalNo  = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo];
    NSString *phoneNo = [[NSUserDefaults standardUserDefaults] stringForKey:kG2PhoneNo];
    
//    phoneNo=@"18012345678";
//    sn = @"YG200000012";
    
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/keyIssued.action?sn=%@&user=%@&mid=%@&tid=%@&flag=0800364",kServerIP,kServerPort,sn,phoneNo,merchantNo,terminalNo];
    NSLog(@"获取秘钥url:%@",url);
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        NSLog(@"msg:%@",responseObject[@"resultMap"][@"msg"]);
        
        int code = [responseObject[@"resultMap"][@"code"]intValue];
        
        if (code == 3 ) {   //正在更新参数，请耐心等待...
            
            [self showHUD:@"正在写入参数"];
            
            
            NSString *mainKey  = [self decryptMainKey:responseObject[@"resultMap"][@"tmk"]];
            NSString *tid = responseObject[@"resultMap"][@"tid"];
            NSString *mid = responseObject[@"resultMap"][@"mid"];
            NSLog(@"mainKey:%@",mainKey);
            
            NSDictionary *dictionary = @{@"商户号":mid,@"终端号":tid,@"主密钥1":mainKey};
            
            [self setPosWithParams:dictionary success:^{
                
                [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.SDK", DISPATCH_QUEUE_SERIAL);
                
                
                BOOL hasSignedIn = [[NSUserDefaults standardUserDefaults] boolForKey:kHasSignedIn];
                
                
                if (!hasSignedIn) {
                    dispatch_async(serial_queue, ^{
                        hasDone = false;
                        
                        if(MiniPosSDKPosLogin()>=0)
                        {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [self showTipView:@"正在签到"];
                            });
                            
                            
                        }
                        
                        while (hasDone ==false) {
                            [NSThread sleepForTimeInterval:0.125];
                            NSLog(@"wwwwwwww");
                        }
                        
                        [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
                        NSLog(@"hasDone");
                    });
                }
            
            }];
            
            
        }else{
            
            [self showTipView:responseObject[@"resultMap"][@"msg"]];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self hideHUD];
        NSLog(@"failure");
        [self showTipView:@"网络异常"];
    }];
    
}

- (void)showConnectionAlert{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"设备未连接" message:@"点击跳转设备连接界面" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    alertView.tag = 44;
    [alertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"sssssssssuper");
    
    if (alertView.tag == 44) {
        if (buttonIndex == 0) {
            UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ConnectDeviceViewController *cdvc = [mainStory instantiateViewControllerWithIdentifier:@"CD"];
            [self.navigationController pushViewController:cdvc animated:YES];
            //[self presentViewController:cdvc animated:YES completion:nil];
        }
    }
    
    if (alertView.tag == 22) {
        if (alertView.tag == 44) {
            if (buttonIndex == 0) {
                ConnectDeviceViewController *cdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CD"];
                [self.navigationController pushViewController:cdvc animated:YES];
                //[self presentViewController:cdvc animated:YES completion:nil];
            }
        }else{
            if (buttonIndex ==1) {
                [self downloadFromWebAndTransmitToPos ];
            }
        }
    }
    
}


#pragma mark - HUB
//显示加载
- (void)showHUD:(NSString *)title {
//    if (_hud) {
//        
//        self.hud.labelText = title;
//        [self.hud show:YES];
//        
//    }else{
//        
//        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        self.hud.labelText = title;
//    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;

}
-(void)showHUD:(NSString *)title afterTime:(double)seconds failStr:(NSString *)str{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (_hud) {
            [_hud hide:YES];
            _hud = nil;
            [self showTipView:str];
        }
        
        
    });
    
    
}

- (void)showHUDDelayHid:(NSString *)title {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = title;
    
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1];
}

//隐藏加载
- (void)hideHUD {
    if (_hud) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_hud hide:YES];
            _hud = nil;
        });
    }
    
    //[self.hud hide:YES];
    
}

//隐藏加载显示加载完成提示
- (void)hideHUDWithTitle:(NSString *)title
{
    self.hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    self.hud.mode = MBProgressHUDModeCustomView;
    
    self.hud.labelText = title;
    [self.hud hide:YES afterDelay:1];
    
}


- (void)initBLESDK{
    
    NSString *shangHuName  = [[NSUserDefaults standardUserDefaults] objectForKey:kShangHuName];
    NSString *shangHu = [[NSUserDefaults standardUserDefaults] stringForKey:kShangHuEditor];
    NSString *zhongDuan = [[NSUserDefaults standardUserDefaults] stringForKey:kZhongDuanEditor];
    NSString *caoZhuoYuan = [[NSUserDefaults standardUserDefaults] stringForKey:kCaoZhuoYuanEditor];
    NSString *host = [[NSUserDefaults standardUserDefaults] stringForKey:kHostEditor];
    NSString *port = [[NSUserDefaults standardUserDefaults] stringForKey:kPortEditor];
    
    
    if (!shangHu) {
        shangHu  = @"898100012340003";
    }
    if (!zhongDuan) {
        zhongDuan = @"10700028";
    }
    if (!caoZhuoYuan) {
        caoZhuoYuan = @"01";
    }
    if (!host) {
        //host = @"122.112.12.25";
        [[NSUserDefaults standardUserDefaults] setObject:kPosIP forKey:kHostEditor];
    }
    if (!port) {
        
        [[NSUserDefaults standardUserDefaults] setObject:kPosPort forKey:kPortEditor];
    }
    if (!shangHuName) {
        [[NSUserDefaults standardUserDefaults] setObject:@"腾势众赢" forKey:kShangHuName];
    }
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    MiniPosSDKInit();
    NSLog(@"LoginViewController-host:%s,port:%d",host.UTF8String,port.intValue);
    //MiniPosSDKSetPublicParam(shangHu.UTF8String, zhongDuan.UTF8String, caoZhuoYuan.UTF8String);
   // MiniPosSDKSetPostCenterParam(host.UTF8String, port.intValue, 0);
    
    MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
}

#pragma mark -
#pragma mark - show tip
- (void)showTipView:(NSString *)tip
{
    LPPopup *popup = [LPPopup popupWithText:tip];
    popup.popupColor = [UIColor blackColor];
    popup.textColor = [UIColor whiteColor];
    
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
}

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showProgressWithStatus:(NSString *)status{
    [KVNProgress showWithStatus:status];
}
-(void)hideProgressAfterDelaysInSeconds:(float)seconds{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KVNProgress dismiss];
    });
}
-(void)hideProgressAfterDelaysInSeconds:(float)seconds withCompletion:(void (^)())completion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [KVNProgress dismiss];
        completion();
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.view.backgroundColor =rgb(229, 229, 229, 1);
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.frame = CGRectMake(0, 0, 20, 20);
        leftButton.backgroundColor = [UIColor clearColor];
        [leftButton setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    KVNProgressConfiguration *basicConfiguration = [KVNProgressConfiguration defaultConfiguration];
    basicConfiguration.fullScreen = YES;
    [KVNProgress setConfiguration:basicConfiguration];

}

- (void)backAction:(UIButton *)button
{

        if ([self.navigationController.viewControllers count] > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(run) userInfo:NULL repeats:YES];
    
    MiniPosSDKAddDelegate((__bridge void*)self, MiniPosSDKResponce);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentBluetoothConnectionVC)  name:kBluetoothIsPoweredOn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentBluetoothConnectionVC)  name:kBluetoothIsDisconnected object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissBluetoothConnectionVC)  name:kBluetoothIsPoweredOff object:nil];
}

-(void)run{
    MiniPosSDKRunThread();
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [timer invalidate];
    
    MiniPosSDKRemoveDelegate((__bridge void*)self);
    //Modified By LiuJQ for 通知取消问题
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBluetoothIsPoweredOn object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBluetoothIsDisconnected object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kBluetoothIsPoweredOff object:nil];
    
}



-(void)presentBluetoothConnectionVC{
    
    NSLog(@"presentBluetoothConnectionVC---%@",NSStringFromClass([self class]));
    
    if (MiniPosSDKDeviceState() < 0) {
        
        BluetoothConnectionViewController *bcVC = [[BluetoothConnectionViewController alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:bcVC];
        nc.modalPresentationStyle = UIModalPresentationFormSheet;
        [kKeyWindow.rootViewController presentViewController:nc animated:YES completion:^{
            _nc = nc;
        }];
    }
    
}

-(void)dismissBluetoothConnectionVC{

    NSLog(@"dismissBluetoothConnectionVC---%@",NSStringFromClass([self class]));
    
    if (_nc) {
        [_nc dismissViewControllerAnimated:YES completion:nil];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


static void MiniPosSDKResponce(void *userData,
                               MiniPosSDKSessionType sessionType,
                               MiniPosSDKSessionError responceCode,
                               const char *deviceResponceCode,
                               const char *displayInfo)
{
    //if(NULL==userData)  return;
    BaseViewController *self = (__bridge BaseViewController*)userData;
    
    self.sessionType=sessionType;
    self.responceCode=responceCode;
    
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    if(deviceResponceCode)
        self.codeString=[NSMutableString stringWithCString:deviceResponceCode encoding:encode];
    else
        self.codeString=[[NSMutableString alloc] init];
    
    if(displayInfo)
        self.displayString=[NSMutableString stringWithCString:displayInfo encoding:encode];
    else
        self.displayString=[[NSMutableString alloc] init];
    
    
    
    //NSLog(@"MiniPosSDKResponce sessionType: %d responceCode: %d",self.sessionType,self.responceCode);
    
    //[self performSelectorOnMainThread:@selector(deviceStatus) withObject:nil waitUntilDone:NO];
    
    
    [self deviceStatus];
}


- (void) deviceStatus
{

    if ((int)(self.responceCode) < 0 ) {
        
        return;
    }
    
    NSLog(@"MiniPosSDKResponce sessionType: %d(%@) responceCode: %d(%@)",self.sessionType,[self getSesstionTypeString:self.sessionType],self.responceCode,[self getResponceCodeString:self.responceCode]);
    
    if(self.responceCode==SESSION_ERROR_NEXT){
        
        if(self.sessionType==SESSION_POS_SALE_TRADE)
        {
            self.statusStr=@"消费下一步";
        }
    }
    else if(self.responceCode==SESSION_ERROR_ACK)
    {
        if(self.sessionType==SESSION_POS_UNKNOWN)
        {
            //self.statusStr=@"未知";
        }
        else if(self.sessionType==SESSION_POS_LOGIN)
        {
            self.statusStr=@"签到成功";
        
            NSLog(@"deviceStatus ------签到成功");
        }
        else if(self.sessionType==SESSION_POS_LOGOUT)
        {
            self.statusStr=@"签退成功";
        
        }
        else if(self.sessionType==SESSION_POS_SALE_TRADE)
        {
            self.statusStr=@"消费成功";
        }
        else if(self.sessionType==SESSION_POS_VOIDSALE_TRADE)
        {
            self.statusStr=@"撤销消费成功";
            NSLog(@"deviceStatus ------撤销消费成功");
        }
        else if(self.sessionType==SESSION_POS_QUERY)
        {
            self.statusStr=@"查询余额成功";
        }
        else if(self.sessionType==SESSION_POS_SETTLE)
        {
            self.statusStr=@"结算成功";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_KEY)
        {
            self.statusStr=@"下载公钥成功";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_AID_PARAM)
        {
            self.statusStr=@"下载AID参数成功";
        }
        else if(self.sessionType==SESSION_POS_CANCEL_READ_CARD)
        {
            self.statusStr=@"中断刷卡成功";
        }
        else if(self.sessionType==SESSION_POS_READ_IC_INFO)
        {
            self.statusStr=@"读取IC卡成功";
        }
        else if(self.sessionType==SESSION_POS_UPDATE_KEY)
        {
            self.statusStr=@"更新密钥成功";
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_INFO)
        {
            self.statusStr=@"获取设备信息成功";

            
            //[self performSelectorOnMainThread:@selector(recvMiniPosSDKStatus) withObject:nil waitUntilDone:NO];
            
            //[self recvMiniPosSDKStatus];
            
            //return;
            
        }else if(self.sessionType == SESSION_POS_DOWN_PRO)
        {
            self.statusStr=@"开始下载";
            
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_ID)
        {
            self.statusStr=@"获取设备序列号成功";
            NSString *info = [NSString stringWithFormat:@"设备ID:%s",MiniPosSDKGetDeviceID()];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else if(self.sessionType==SESSION_POS_READ_CARD_INFO)
        {
//            self.statusStr=@"获取磁道信息成功";
//            NSString *info = [NSString stringWithFormat:@"磁道二: %s\n磁道三:%s\n磁道一：%s",MiniPosSDKGetTrack2(),MiniPosSDKGetTrack3(),MiniPosSDKGetTrack1()];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
            return;
        }
        else if(self.sessionType==SESSION_POS_READ_PIN_CARD_INFO)
        {
            self.statusStr=@"获取磁道和密码信息成功";
            return;
        }
        else if(self.sessionType== SESSION_POS_DOWNLOAD_PARAM)
        {
            
            self.statusStr = @"获取参数成功";
            //self.statusStr=[NSString stringWithFormat:@"获取%@成功",[UIUtils GB2312_To_UTF8:MiniPosSDKGetParamName()]];
            
            //return;
        }
        else if(self.sessionType== SESSION_POS_UPLOAD_PARAM)
        {
            
            self.statusStr = @"上传参数成功";
    
        }else if(self.sessionType== SESSION_POS_RECEIVE_IMAGE)
        {
            
            self.statusStr = @"收取图片成功";
            
        }else if(self.sessionType== SESSION_POS_BLE_MATCH)
        {
            
            self.statusStr = @"蓝牙配对成功";
        }else if(self.sessionType== SESSION_POS_PRINT)
        {
            
            self.statusStr = @"打印成功";
        }else if(self.sessionType== SESSION_POS_GET_G2_DEVICE_INFO)
        {
            
            self.statusStr = @"获取G2信息成功";
        }else if(self.sessionType == SESSION_POS_SHOW)
        {
            
            self.statusStr = @"显示成功";
        }

        
       // self.statusStr = [NSString stringWithFormat:@"%@ [%@ %@]",self.statusStr,self.codeString,self.displayString];
    }
    else if(self.responceCode==SESSION_ERROR_NAK)
    {
        if(self.sessionType==SESSION_POS_LOGIN)
        {
            self.statusStr=@"签到失败";
            NSLog(@"deviceStatus ------签到失败");
        }
        else if(self.sessionType==SESSION_POS_LOGOUT)
        {
            self.statusStr=@"签退失败";
        }
        else if(self.sessionType==SESSION_POS_SALE_TRADE)
        {
            self.statusStr=@"消费失败";
        }
        else if(self.sessionType==SESSION_POS_VOIDSALE_TRADE)
        {
            self.statusStr=@"撤销消费失败";
        }
        else if(self.sessionType==SESSION_POS_QUERY)
        {
            self.statusStr=@"查询余额失败";
        }
        else if(self.sessionType==SESSION_POS_SETTLE)
        {
            self.statusStr=@"结算失败";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_KEY)
        {
            self.statusStr=@"下载公钥失败";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_AID_PARAM)
        {
            self.statusStr=@"下载AID参数失败";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_PARAM)
        {
            self.statusStr=@"下载参数失败";
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_INFO)
        {
            self.statusStr=@"获取设备信息失败";
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_ID)
        {
            self.statusStr=@"获取设备序列号失败";
        }
        else if(self.sessionType==SESSION_POS_READ_CARD_INFO)
        {
            self.statusStr=@"获取磁道信息失败";
        }
        else if(self.sessionType==SESSION_POS_READ_PIN_CARD_INFO)
        {
            self.statusStr=@"获取磁道密码失败";
        }
        else if(self.sessionType==SESSION_POS_READ_IC_INFO)
        {
            self.statusStr=@"读取IC卡失败";
        }
        else if(self.sessionType==SESSION_POS_UPDATE_KEY)
        {
            self.statusStr=@"更新密钥失败";
        }
        else if(self.sessionType==SESSION_POS_CANCEL_READ_CARD)
        {
            self.statusStr=@"中断刷卡失败";
        }else if(self.sessionType== SESSION_POS_BLE_MATCH)
        {
            
            self.statusStr = @"蓝牙配对失败";
        }
        
        //self.statusStr = [NSString stringWithFormat:@"%@ [%@ %@]",self.statusStr,self.codeString,self.displayString];
    }
    else if(self.responceCode==SESSION_ERROR_DEVICE_PLUG_IN)
    {
        NSLog(@"deviceStatus:设备已插入");
        self.statusStr=@"设备已插入";
    }
    else if(self.responceCode==SESSION_ERROR_DEVICE_PLUG_OUT)
    {
        self.statusStr=@"设备已拔出";
    }
    else if(self.responceCode==SESSION_ERROR_NO_DEVICE)
    {
        self.statusStr=@"未找到设备";
    }
    else if(self.responceCode==SESSION_ERROR_DEVICE_NO_RESPONCE)
    {
        self.statusStr=@"设备没有响应";
    }
    else if(self.responceCode==SESSION_ERROR_NAK)
    {
        self.statusStr=@"设备拒绝会话";
    }
    else if(self.responceCode==SESSION_ERROR_SEND_8583_ERROR)
    {
        self.statusStr=@"发送8583包错误";
    }
    else if(self.responceCode==SESSION_ERROR_RECIVE_8583_ERROR)
    {
        self.statusStr=@"接收8583包错误";
    }
    else if(self.responceCode==SESSION_ERROR_DEVICE_RESPONCE_TIMEOUT)
    {
        if(self.sessionType==SESSION_POS_LOGIN)
        {
            self.statusStr=@"签到响应超时";
        }
        else if(self.sessionType==SESSION_POS_LOGOUT)
        {
            self.statusStr=@"签退响应超时";
        }
        else if(self.sessionType==SESSION_POS_SALE_TRADE)
        {
            self.statusStr=@"消费响应超时";
        }
        else if(self.sessionType==SESSION_POS_VOIDSALE_TRADE)
        {
            self.statusStr=@"撤销响应超时";
        }
        else if(self.sessionType==SESSION_POS_QUERY)
        {
            self.statusStr=@"查询余额响应超时";
        }
        else if(self.sessionType==SESSION_POS_SETTLE)
        {
            self.statusStr=@"结算响应超时";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_KEY)
        {
            self.statusStr=@"下载公钥响应超时";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_AID_PARAM)
        {
            self.statusStr=@"下载AID参数响应超时";
        }
        else if(self.sessionType==SESSION_POS_DOWNLOAD_PARAM)
        {
            self.statusStr=@"下载参数响应超时";
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_INFO)
        {
            self.statusStr=@"获取设备信息响应超时";
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_ID)
        {
            self.statusStr=@"获取设备序列号响应超时";
        }
        else if(self.sessionType==SESSION_POS_READ_CARD_INFO)
        {
            self.statusStr=@"获取磁道信息响应超时";
        }
        else if(self.sessionType==SESSION_POS_READ_PIN_CARD_INFO)
        {
            self.statusStr=@"获取磁道密码响应超时";
        }
        else if(self.sessionType==SESSION_POS_READ_IC_INFO)
        {
            self.statusStr=@"读取IC卡响应超时";
        }
        else if(self.sessionType==SESSION_POS_UPDATE_KEY)
        {
            self.statusStr=@"更新密钥响应超时";
        }
        else if(self.sessionType==SESSION_POS_CANCEL_READ_CARD)
        {
            self.statusStr=@"中断刷卡响应超时";
        }else if(self.sessionType== SESSION_POS_BLE_MATCH)
        {
            
            self.statusStr = @"蓝牙配对超时";
        }
        
    }
    else if(self.responceCode==SESSION_ERROR_NO_REGISTE_INTERFACE)
    {
        self.statusStr=@"没有注册驱动";
    }
    else if(self.responceCode==SESSION_ERROR_NO_SET_PARAM)
    {
        self.statusStr=@"没有设置参数";
    }
    else if(self.responceCode==SESSION_ERROR_DEVICE_BUSY)
    {
        self.statusStr=@"设备繁忙，稍后再试";
    }
    else if(self.responceCode==SESSION_ERROR_CARD_ERROR)
    {
        self.statusStr=@"刷卡操作错误";   
    }
    else if(self.responceCode==SESSION_ERROR_CANCEL_TRADE)
    {
        self.statusStr=@"取消刷卡交易";
    }
    else if(self.responceCode==SESSION_ERROR_GET_CARD_NO)
    {
        self.statusStr=@"获取卡号";
    }
    else if(self.responceCode==SESSION_ERROR_GET_CARD_PASSWORD)
    {
        self.statusStr=@"获取密码";
    }
    
    //[self performSelectorOnMainThread:@selector(startTimer) withObject:nil waitUntilDone:NO];
    
    //[self performSelectorOnMainThread:@selector(recvMiniPosSDKStatus) withObject:nil waitUntilDone:NO];

    [self recvMiniPosSDKStatus];

}




-(NSString *)getSesstionTypeString:(MiniPosSDKSessionType)type{
    switch (type) {
        case SESSION_POS_UNKNOWN:
            return @"SESSION_POS_UNKNOWN";
            break;
        case SESSION_POS_LOGIN:
            return @"SESSION_POS_LOGIN";
            break;
        case SESSION_POS_GET_DEVICE_INFO:
            return @"SESSION_POS_GET_DEVICE_INFO";
            break;
        case SESSION_POS_SALE_TRADE:
            return @"SESSION_POS_SALE_TRADE";
            break;
        case SESSION_POS_VOIDSALE_TRADE:
            return @"SESSION_POS_VOIDSALE_TRADE";
            break;
        case SESSION_POS_QUERY:
            return @"SESSION_POS_QUERY";
            break;
        case SESSION_POS_SETTLE:
            return @"SESSION_POS_SETTLE";
            break;
        case SESSION_POS_DOWNLOAD_KEY:
            return @"SESSION_POS_DOWNLOAD_KEY";
            break;
        case SESSION_POS_DOWNLOAD_AID_PARAM:
            return @"SESSION_POS_DOWNLOAD_AID_PARAM";
            break;
        case SESSION_POS_DOWNLOAD_PARAM:
            return @"SESSION_POS_DOWNLOAD_PARAM";
        case SESSION_POS_PRINT:
            return @"SESSION_POS_PRINT";
            break;
        case SESSION_POS_GET_DEVICE_ID:
            return @"SESSION_POS_GET_DEVICE_ID";
            break;
        case SESSION_POS_CANCEL_READ_CARD:
            return @"SESSION_POS_CANCEL_READ_CARD";
            break;
        case SESSION_POS_READ_CARD_INFO:
            return @"SESSION_POS_READ_CARD_INFO";
            break;
        case SESSION_POS_READ_PIN_CARD_INFO:
            return @"SESSION_POS_READ_PIN_CARD_INFO";
            break;
        case SESSION_POS_READ_IC_INFO:
            return @"SESSION_POS_READ_IC_INFO";
            break;
        case SESSION_POS_UPDATE_KEY:
            return @"SESSION_POS_UPDATE_KEY";
            break;
        case SESSION_POS_LOGOUT:
            return @"SESSION_POS_LOGOUT";
            break;
        case SESSION_POS_UPLOAD_PARAM:
            return @"SESSION_POS_UPLOAD_PARAM";
            break;
        case SESSION_POS_SHOW:
            return @"SESSION_POS_SHOW";
            break;
        case SESSION_POS_SIGN:
            return @"SESSION_POS_SIGN";
            break;
        case SESSION_POS_RECEIVE_IMAGE:
            return @"SESSION_POS_RECEIVE_IMAGE";
            break;
        case SESSION_POS_BLE_MATCH:
            return @"SESSION_POS_BLE_MATCH";
            break;
        case SESSION_POS_CREATE_WINDOW:
            return @"SESSION_POS_CREATE_WINDOW";
            break;
        case SESSION_POS_GET_G2_DEVICE_INFO:
            return @"SESSION_POS_GET_G2_DEVICE_INFO";
            break;
        default:
            return @"";
            break;
    }
}

-(NSString *)getResponceCodeString:(int)type{
    switch (type) {
        case SESSION_ERROR_ACK:
            return @"SESSION_ERROR_ACK";
            break;
        case SESSION_ERROR_NAK:
            return @"SESSION_ERROR_NAK";
            break;
        case SESSION_ERROR_NO_REGISTE_INTERFACE:
            return @"SESSION_ERROR_NO_REGISTE_INTERFACE";
            break;
        case SESSION_ERROR_NO_DEVICE:
            return @"SESSION_ERROR_NO_DEVICE";
            break;
        case SESSION_ERROR_DEVICE_PLUG_IN:
            return @"SESSION_ERROR_DEVICE_PLUG_IN";
            break;
        case SESSION_ERROR_DEVICE_PLUG_OUT:
            return @"SESSION_ERROR_DEVICE_PLUG_OUT";
            break;
        case SESSION_ERROR_DEVICE_NO_RESPONCE:
            return @"SESSION_ERROR_DEVICE_NO_RESPONCE";
            break;
        case SESSION_ERROR_DEVICE_RESPONCE_TIMEOUT:
            return @"SESSION_ERROR_DEVICE_RESPONCE_TIMEOUT";
            break;
        case SESSION_ERROR_SEND_8583_ERROR:
            return @"SESSION_ERROR_SEND_8583_ERROR";
            break;
        case SESSION_ERROR_RECIVE_8583_ERROR:
            return @"SESSION_ERROR_RECIVE_8583_ERROR";
            break;
        case SESSION_ERROR_NO_SET_PARAM:
            return @"SESSION_ERROR_NO_SET_PARAM";
            break;
        case SESSION_ERROR_DEVICE_BUSY:
            return @"SESSION_ERROR_DEVICE_BUSY";
            break;
        case SESSION_ERROR_DEVICE_SEND:
            return @"SESSION_ERROR_DEVICE_SEND";
            break;
        case SESSION_ERROR_SHAKE_PACK:
            return @"SESSION_ERROR_SHAKE_PACK";
            break;
        case SESSION_ERROR_NEXT:
            return @"SESSION_ERROR_NEXT";
        case SESSION_ERROR_CARD_ERROR:
            return @"SESSION_ERROR_CARD_ERROR";
            break;
        case SESSION_ERROR_CANCEL_TRADE:
            return @"SESSION_ERROR_CANCEL_TRADE";
            break;
        case SESSION_ERROR_GET_CARD_NO:
            return @"SESSION_ERROR_GET_CARD_NO";
            break;
        case SESSION_ERROR_GET_CARD_PASSWORD:
            return @"SESSION_ERROR_GET_CARD_PASSWORD";
            break;
        default:
            return @"";
            break;
    }
}


- (void)recvMiniPosSDKStatus
{
    //NSLog(@"self.statusStr = %@",self.statusStr);
    //self.statusStr=@"设备繁忙，稍后再试";
    if ([self.statusStr isEqualToString:@"设备繁忙，稍后再试"]) {
        [self hideHUD];
        //[self showTipView:self.statusStr];
    }
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"上传参数成功"]]) {
        
        hasSettedParam = true;
    }
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到成功"]]) {
        
        hasDone = true;
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
    }
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到失败"]]) {
        
        static int count = 0;
        
        if (count == 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                 count++;
                [self downloadParamsTransferToPos];
                
            });
            
           
        }
        

        
    }
    
    if ([self.statusStr isEqualToString:@"获取设备信息成功"] ) {
        
        
        if (_isFirstGetVersionInfo){
            
            pos_kernel = [NSString stringWithCString:MiniPosSDKGetCoreVersion() encoding:NSASCIIStringEncoding];
            pos_task = [NSString stringWithCString:MiniPosSDKGetAppVersion() encoding:NSASCIIStringEncoding];
            
            NSString *message = [NSString stringWithFormat:@"pos_kernel:%@\npos_task:%@",pos_kernel,pos_task];
            
            
            NSLog(@"message:%@",message);
            
            [self downloadWebVersionFile];
            
        }
    }

}


//从服务器下载版本文件
- (void)downloadWebVersionFile{
    
    //    if(isFirstGetVersionInfo==false){
    //        [self showHUD:@"正在从服务器获取版本信息"];
    //    }
    
    // 1
    NSString *baseURLString = @"http://120.24.213.123/app/G2test/version.json";
    //    NSString *baseURLString = @"http://120.24.213.123/app/magtest/version.json";
    NSURL *url = [NSURL URLWithString:baseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    //operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/version.json"];
    
    operation.inputStream = [NSInputStream inputStreamWithURL:url];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:str append:NO];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self hideHUD];
        
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:str] options:kNilOptions error:NULL];
        
        NSLog(@"%@",dictionary);
        
        NSDictionary *g1 = dictionary[@"G2"];
        
        web_kernel = g1[@"kernel"];
        web_task = g1[@"task"];
        
        NSString *message = [NSString stringWithFormat:@"web_kernel:%@web_task:%@",web_kernel,web_task];
        
        NSLog(@"message:%@",message);
        
        
        //成功就获取本地版本号
        [self getPosVersionInfo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        [self hideHUD];
        [self showTipView:@"获取失败,请检查网络"];
        
    }];
    
    // 5
    [operation start];
    
    
}

//从POS机获取版本信息
- (void)getPosVersionInfo{
    
    if(pos_kernel && pos_task){
        [self compareVersionInfo];
    }
}

//比较版本信息
- (void)compareVersionInfo{
    
    updateFiles = [[NSMutableArray alloc]init];
    
    
    if ([pos_kernel compare:web_kernel options:NSNumericSearch] == NSOrderedAscending) {
        [updateFiles addObject:@"kernel"];
    }
    
    if ([pos_task compare:web_task options:NSNumericSearch] == NSOrderedAscending)
    {
        [updateFiles addObject:@"task"];
    }
    
    
    if([updateFiles count]>0){
        
        NSString *info = [NSString stringWithFormat:@"有%lu个文件需要更新，预计耗时%lu分钟",(unsigned long)[updateFiles count],[updateFiles count]*5];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定更新", nil];
        alert.tag = 22;
        [alert show];
        
    }else if(_isFirstGetVersionInfo==false){
        
        NSString *info = [NSString stringWithFormat:@"您的软件是最新版本"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        
    }
    
    _isFirstGetVersionInfo = false;
    
    
}

- (void)download:(NSString *)fileName CompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success{
    
    if (fileName ==nil) {
        return;
    }
    
    NSString *baseURLString = [NSString stringWithFormat:@"http://120.24.213.123/app/G2test/%@",fileName];
    //    NSString *baseURLString = [NSString stringWithFormat:@"http://120.24.213.123/app/magtest/%@",fileName];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:baseURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/%@",fileName]];
    NSLog(@"%@",baseURLString);
    NSLog(@"%@",str);
    
    operation.inputStream = [NSInputStream inputStreamWithURL:baseURL];
    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:str append:NO];
    
    
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"%@ is download：%f",fileName, (float)totalBytesRead/totalBytesExpectedToRead);
        //self.progressView set
        float progress = (float)totalBytesRead/totalBytesExpectedToRead;
        
        
        [cav updateProgress:progress];
        [cav updateTitle:[NSString stringWithFormat:@"正在下载%@",fileName]];
        
        
    }];
    
    //NSString *filePath = [NSString alloc]in
    
    [operation setCompletionBlockWithSuccess:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
    }];
    
    [operation start];
    
    
    NSLog(@"download,%@",fileName);
    
    
}

//
- (void)downloadFromWebAndTransmitToPos{
    
    
    
    if ([updateFiles count]>0) {
        
        cav = [[CustomAlertView alloc]init];
        
        //[self.view addSubview:cav];
        [cav show];
        
        [self download:updateFiles[0] CompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"download %@ success",updateFiles[0]);
            if ([updateFiles count] >1) {
                [self download:updateFiles[1] CompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    //MiniPosSDKDownPro();
                    
                    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        DownThread1((__bridge void*)cav,updateFiles);
                        
                        [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
                        
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [cav dismiss];
                        });
                        
                    });
                    
                    
                    
                }];
            }else{
                
               // MiniPosSDKDownPro();
                
                [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    DownThread1((__bridge void*)cav,updateFiles);
                    
                    [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [cav dismiss];
                    });
                    
                });
                
                
            }
            
        }];
    }else{
        
        [self showTipView:@"您的软件是最新版本"];
    }
    
}




@end
