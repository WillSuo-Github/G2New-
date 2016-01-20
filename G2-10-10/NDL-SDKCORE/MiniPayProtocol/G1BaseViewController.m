                                                                                                                   //
//  BaseViewController.m
//  MovePower
//
//  Created by Femto03 on 14-6-5.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "G1BaseViewController.h"
#import "MBProgressHUD.h"
#import "UIUtils.h"
#import "LPPopup.h"
#import "ConnectDeviceViewController.h"
#import "AFNetworking.h"

#import "KVNProgress.h"
#import "CustomAlertView.h"
#import "PromptInfo.h"
@interface G1BaseViewController ()
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
}


@end

@implementation G1BaseViewController




//解密从服务器获取的主密钥
-(NSString *)decryptMainKey:(NSString *)mainKey{
    
    NSString *des =[[NDlMPosManager shardNDlMPosManager]decryptMainKey:mainKey];
    return des;
}

- (void)setPosWithParams:(NSDictionary *)dictionary success:(void (^)())success{
    
   //[NDlMPosManager shardNDlMPosManager].miniPosManagerDelegate=self;

   [[NDlMPosManager shardNDlMPosManager]setPosWithParams:dictionary success:success];
    
}

- (void)needSetPosWithParams:(NSDictionary *)result{
    [self hideHUD];
}
//验证pos端的参数，成功后执行block
- (void) verifyParamsSuccess:(void (^)())success{
    [[NDlMPosManager shardNDlMPosManager]verifyParamsSuccess:success];
    
}
- (void)needVerifyParamsSuccess:(VerifyParamsSuccessResult *)result{
    if (result) {
        if(result.step==NDMPOSK_MANAGER_VERIFYPARAM_CODE3_WRITING){
            [self showHUD:@"正在写入参数"];
        }else if(result.step==NDMPOSK_MANAGER_VERIFYPARAM_CODE3_SIGN){
             [self showHUD:@"正在签到"];
        }else if(result.step==NDMPOSK_MANAGER_VERIFYPARAM_CODE0_SIGN){
            [self showHUD:@"正在签到"];
        }else if(result.step==NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_WRITING){
            [self showHUD:@"正在写入参数"];
        }else if(result.step==NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_SIGNED){
            [self showHUD:@"正在写入参数"];
        }else if(result.step==NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_SIGNED){
            [self showHUD:result.msg];
        }else if(result.step==NDMPOSK_MANAGER_NETWOKR_ERROR){
            //[self showHUD:result.msg];
            [self hideHUD];
        }
        
        //
    }else{
        NSLog(@"设置参数回调异常");
    }
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
    [[NDlMPosManager shardNDlMPosManager]initConfigureForBLESDK];
    
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
    //结构调整
    [NDlMPosManager shardNDlMPosManager].miniPosManagerDelegate=self;


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
    
    [[NDlMPosManager shardNDlMPosManager] initMiniPosSDKAddDelegate];
    
}


- (void)needInitMiniPosSDKAddDelegate:( BOOL)result{

    NSLog(@"needInitMiniPosSDKAddDelegate");
    [PromptInfo showText:@"needInitMiniPosSDKAddDelegate"];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NDlMPosManager shardNDlMPosManager] removeMiniPosSDKDelegate];
    
}


- (void)recvMiniPosSDKStatus{
    
}
- (void)needMiniPosSDKResponse:(SessionCodeResult *)result{
    //
    //NSLog(@"BaseViewController,mPos状态码\n%@",result.description);
    
    NSString *info=[NSString stringWithFormat:@"BaseViewController,mPos状态码\n%@",result.description];
    //[PromptInfo showText:info];
    self.statusStr=result.msg;
    self.sessionType=result.sessionType;
    self.responceCode=result.responceCode;
    if (result.responceCode==SESSION_POS_GET_DEVICE_ID) {
        NSString *info = [NSString stringWithFormat:@"设备ID:%s",MiniPosSDKGetDeviceID()];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }else if(result.responceCode==SESSION_ERROR_DEVICE_BUSY){
        [self hideHUD];
        [self showTipView:result.msg];
    }else if([self.statusStr isEqualToString:@"签到成功" ]){
        [self hideHUD];
        [self showTipView:result.msg];
    }
    //LiuJQ Bug info
    [self recvMiniPosSDKStatus];

}

-(void)needDownloadWebVersionInfo:( NSString*)result bNewVersion:(BOOL)bVersion{
    if (bVersion==YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:result delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定更新", nil];
        alert.tag = 22;
        [alert show];
    }else{
   
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:result
                delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
        [alert show];
    }
    
}

//下载文件版本回调
-(void)needDownloadWebVersionFile:(BOOL) result{
    if (result==YES) {
        [self hideHUD];
    }else{
        [self hideHUD];
        [self showTipView:@"获取失败,请检查网络"];

    }
}

-(void)downloadFromWebAndTransmitToPos{
    [[NDlMPosManager shardNDlMPosManager] downloadFromWebAndTransmitToPos];
}

-(void)needDownloadFromWebAndTransmitToPos:( NSString*)result
                                 errorType:(VerisonUpdatedFromWebAndTransmitToPos)errorType{
    if (errorType==NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_ISNew) {
        [self showTipView:result];
    }else if(errorType==NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_ERROR){
        [self showTipView:result];
    }
    
}


@end
