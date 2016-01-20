//
//  HomeViewController.m
//  GITestDemo
//
//  Created by wudi on 15/07/15.
//  Copyright (c) 2015年 Yogia. All rights reserved.
//

#import "HomeViewController.h"
#import "SwipingCardViewController.h"
#import "CustomAlertView.h"
#import "AFNetworking.h"
#import "ConnectDeviceViewController.h"
#include "des.h"
#import "UIUtils.h"
@interface HomeViewController ()
{
    NSTimer *timer;
    NSString *sendValue;

}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];
    
    
    
    //商户信息   保存本地
    NSString *shangHuName  = [[NSUserDefaults standardUserDefaults] objectForKey:kShangHuName];
    NSString *host = [[NSUserDefaults standardUserDefaults] stringForKey:kHostEditor];
    NSString *port = [[NSUserDefaults standardUserDefaults] stringForKey:kPortEditor];
    
    
    if (!host) {
        [[NSUserDefaults standardUserDefaults] setObject:kPosIP forKey:kHostEditor];
    }
    if (!port) {
        
        [[NSUserDefaults standardUserDefaults] setObject:kPosPort forKey:kPortEditor];
    }
    if (!shangHuName) {
        [[NSUserDefaults standardUserDefaults] setObject:@"周黑鸭" forKey:kShangHuName];
    }
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSLog(@"init  root start ...");
    
    
    MiniPosSDKInit();
    MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());

    
    
}





-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    
    MiniPosSDKInit();
    

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    UIViewController *send=segue.destinationViewController;
    if ([send respondsToSelector:@selector(setType:)]) {
        [send setValue:sendValue forKey:@"type"];
    }
    
    NSLog(@"prepareForSegue");
    
}


//签到
- (IBAction)siginAction:(UIButton *)sender {
    

    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }else{
    
        
        if(MiniPosSDKPosLogin()>=0)
        {
            
            [self showHUD:@"正在签到"];
            
        }
        
    }
    
    
}

//消费
- (IBAction)consumeAction:(UIButton *)sender {
 
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }else{
        
        if (MiniPosSDKGetCurrentSessionType()== SESSION_POS_UNKNOWN) {
            
            [self performSegueWithIdentifier:@"xiaofei" sender:self];
            
        }else{
            [self showTipView:@"设备繁忙，稍后再试"];
        }
        
    }
    
}
//撤销
- (IBAction)unconsumeAction:(UIButton *)sender {
    
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }else {
        
        NSString *pingZhengHao = [[NSUserDefaults standardUserDefaults] objectForKey:KLastPingZhengHao];
        
        if (!pingZhengHao || [pingZhengHao isEqualToString:@""]) {
            [self showTipView:@"没有可以撤销的交易"];
            
            return ;
        }
        
        if (MiniPosSDKGetCurrentSessionType()== SESSION_POS_UNKNOWN) {
            
            [self performSegueWithIdentifier:@"chexiao" sender:self];
        }else {
            [self showTipView:@"设备繁忙，稍后再试"];
        }
        
    }
    
    
}
//查询余额
- (IBAction)checkAccountAction:(id)sender {
    sendValue = @"查询余额";
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }else {
        
        
        if (MiniPosSDKGetCurrentSessionType()== SESSION_POS_UNKNOWN) {
            
            [self performSegueWithIdentifier:@"chaxun" sender:self];
            
        }
        
        if(MiniPosSDKQuery()>=0)
        {
            NSLog(@"正在查询余额...");
        }

        
    }
    

    
}
//签退
- (IBAction)sginOutAction:(UIButton *)sender {
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }else {

        
        if(MiniPosSDKPosLogout()>=0)
        {
            [self showHUD:@"正在签退..."];
        }
    }
    
    

}
//结算
- (IBAction)payoffAction:(UIButton *)sender {
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        [self showConnectionAlert];
        return;
    }else {

        if(MiniPosSDKSettleTradeCMD(NULL)>=0)
        {
            [self showHUD:@"正在结算..."];
        }
        
    }
    
    

}
//更新参数
- (IBAction)updataKeyAction:(UIButton *)sender {
    
    if(MiniPosSDKDeviceState()<0){
        [self showConnectionAlert];
        return;
    }

        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *sn = @"G1020150811";
        NSString *phoneNo = @"13202264038";
        NSString *merchantNo  = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1MerchantNo];
        NSString *terminalNo  = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo];
        NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/keyIssued.action?sn=%@&user=%@&mid=%@&tid=%@&flag=0800364",kServerIP,kServerPort,sn,phoneNo,merchantNo,terminalNo];
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
                
                [self setPosWithParams:dictionary success:nil];
                
                [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
            }else{
                
                [self showTipView:responseObject[@"resultMap"][@"msg"]];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self hideHUD];
            NSLog(@"failure");
            [self showTipView:@"网络异常"];
        }];

    
}



- (IBAction)getDeviceMsgAction:(UIButton *)sender {
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        
        [self showConnectionAlert];
        return;
    }else {
        
        if(MiniPosSDKGetDeviceInfoCMD()>=0)
        {
            [self showHUD:@"正在获取设备信息"];
        }
    }
    

}


//打印指令
- (IBAction)printAction:(UIButton *)sender {
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        
        [self showConnectionAlert];
        return;
    }else {
        
        
        MiniPosSDKPrinter(0,50,"",0);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"商户号       898100012340004"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"时间         14:00:01"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"商户号       898100012340004"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"时间         14:00:01"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"商户号       898100012340004"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"时间         14:00:01"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"商户号       898100012340004"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"时间         14:00:01"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:@"金额         1000"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],1);
        MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],2);
        
        
//        if(MiniPosSDKPrint()>=0)
//        {
//            //[self showHUD:@"正在获取设备信息"];
//        }
    }
    
}


//显示指令
- (IBAction)showAction:(UIButton *)sender {
    
    //char chs[] = "\x02\x00";
//    char chs[] = {0x02,0x00};
//    printf("len:%d\n",sizeof(chs));
//    
    unsigned char data[] = {0x55, 0x55, 0x55, 0x55, 0x00, 0x18, 0xE8, 0xAE, 0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x04, 0x01, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0xD8, 0xFF, 0xE0, 0x00, 0x10, 0x4A, 0x46, 0x49, 0x46, 0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0xFF, 0xDB, 0x00, 0x43, 0x00, 0x06, 0x04, 0x05, 0x06, 0x05, 0x04, 0x06, 0x06, 0x05, 0x06, 0x07, 0x07, 0x06, 0x08, 0x0A, 0x10, 0x0A, 0x0A, 0x09, 0x09, 0x0A, 0x14, 0x0E, 0x0F, 0x0C, 0x10, 0x17, 0x14, 0x18, 0x18, 0x17, 0x14, 0x16, 0x16, 0x1A, 0x1D, 0x25, 0x1F, 0x1A, 0x1B, 0x23, 0x1C, 0x16, 0x16, 0x20, 0x2C, 0x20, 0x23, 0x26, 0x27, 0x29, 0x2A, 0x29, 0x19, 0x1F, 0x2D, 0x30, 0x2D, 0x28, 0x30, 0x25, 0x28, 0x29, 0x28, 0xFF, 0xDB, 0x00, 0x43, 0x01, 0x07, 0x07, 0x07, 0x0A, 0x08, 0x0A, 0x13, 0x0A, 0x0A, 0x13, 0x28, 0x1A, 0x16, 0x1A, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0x28, 0xFF, 0xC0, 0x00, 0x11, 0x08, 0x00, 0x5E, 0x00, 0xF2, 0x03, 0x01, 0x22, 0x00, 0x02, 0x11, 0x01, 0x03, 0x11, 0x01, 0xFF, 0xC4, 0x00, 0x1F, 0x00, 0x00, 0x01, 0x05, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0xFF, 0xC4, 0x00, 0xB5, 0x10, 0x00, 0x02, 0x01, 0x03, 0x03, 0x02, 0x04, 0x03, 0x05, 0x05, 0x04, 0x04, 0x00, 0x00, 0x01, 0x7D, 0x01, 0x02, 0x03, 0x00, 0x04, 0x11, 0x05, 0x12, 0x21, 0x31, 0x41, 0x06, 0x13, 0x51, 0x61, 0x07, 0x22, 0x71, 0x14, 0x32, 0x81, 0x91, 0xA1, 0x08, 0x23, 0x42, 0xB1, 0xC1, 0x15, 0x52, 0xD1, 0xF0, 0x24, 0x33, 0x62, 0x72, 0x82, 0x09, 0x0A, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFF, 0xC4, 0x00, 0x1F, 0x01, 0x00, 0x03, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0xFF, 0xC4, 0x00, 0xB5, 0x11, 0x00, 0x02, 0x01, 0x02, 0x04, 0x04, 0x03, 0x04, 0x07, 0x05, 0x04, 0x04, 0x00, 0x01, 0x02, 0x77, 0x00, 0x01, 0x02, 0x03, 0x11, 0x04, 0x05, 0x21, 0x31, 0x06, 0x12, 0x41, 0x51, 0x07, 0x61, 0x71, 0x13, 0x22, 0x32, 0x81, 0x08, 0x14, 0x42, 0x91, 0xA1, 0xB1, 0xC1, 0x09, 0x23, 0x33, 0x52, 0xF0, 0x15, 0x62, 0x72, 0xD1, 0x0A, 0x16, 0x24, 0x34, 0xE1, 0x25, 0xF1, 0x17, 0x18, 0x19, 0x1A, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x82, 0x83, 0x84, 0x85, 0x86, 0x87, 0x88, 0x89, 0x8A, 0x92, 0x93, 0x94, 0x95, 0x96, 0x97, 0x98, 0x99, 0x9A, 0xA2, 0xA3, 0xA4, 0xA5, 0xA6, 0xA7, 0xA8, 0xA9, 0xAA, 0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0xB8, 0xB9, 0xBA, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFF, 0xDA, 0x00, 0x0C, 0x03, 0x01, 0x00, 0x02, 0x11, 0x03, 0x11, 0x00, 0x3F, 0x00, 0xFA, 0xA6, 0x8A, 0x28, 0xA0, 0x02, 0x8A, 0x28, 0xA0, 0x02, 0x8A, 0x28, 0xA0, 0x02, 0xA9, 0xE9, 0xBA, 0xAE, 0x9F, 0xAA, 0x46, 0xCF, 0xA6, 0x5F, 0xDA, 0x5E, 0x22, 0x9C, 0x16, 0xB7, 0x99, 0x64, 0x00, 0xFB, 0x95, 0x26, 0xB3, 0x3C, 0x7D, 0xA4, 0x5E, 0x6B, 0xDE, 0x0D, 0xD5, 0xF4, 0xCD, 0x2E, 0xED, 0xAD, 0x2F, 0x6E, 0x60, 0x29, 0x14, 0x81, 0x8A, 0xE4, 0xF5, 0xDA, 0x48, 0xE4, 0x2B, 0x63, 0x69, 0x23, 0x90, 0x18, 0xE3, 0x9A, 0xE0, 0x3C, 0x9F, 0x86, 0xB7, 0x7E, 0x0E, 0xB0, 0xD6, 0xF5, 0x5D, 0x07, 0x4F, 0xD3, 0x66, 0x1F, 0xE8, 0x82, 0xDE, 0x08, 0x7C, 0xBB, 0xD8, 0xEE, 0x13, 0xE4, 0x6B, 0x64, 0xF2, 0xB1, 0x23, 0x3A, 0xB0, 0x23, 0x03, 0xEB, 0xD3, 0x9A, 0x00, 0xF5, 0xEA, 0x2B, 0xCE, 0xFE, 0x19, 0x69, 0x1E, 0x23, 0xB4, 0xBF, 0xBB, 0xBD, 0xBC, 0xB9, 0xBE, 0xB2, 0xF0, 0xF4, 0xC8, 0x05, 0x9E, 0x8F, 0xA9, 0x5C, 0x1B, 0xCB, 0x98, 0xBF, 0xDB, 0x69, 0x98, 0x96, 0x4C, 0x8C, 0x7E, 0xEF, 0x73, 0xE3, 0xD4, 0x1E, 0x2B, 0xD1, 0x28, 0x00, 0xA2, 0x8A, 0x28, 0x00, 0xA2, 0xB9, 0xBF, 0x18, 0xF8, 0xD3, 0x46, 0xF0, 0x8F, 0xD8, 0x86, 0xB3, 0x3B, 0xA3, 0x5D, 0x3E, 0xD5, 0x58, 0xD0, 0xB9, 0x44, 0x1F, 0x7E, 0x57, 0x03, 0xEE, 0xC6, 0xB9, 0x1B, 0x98, 0xF0, 0x32, 0x2B, 0xA3, 0x46, 0x57, 0x45, 0x74, 0x60, 0xCA, 0xC3, 0x20, 0x83, 0x90, 0x45, 0x00, 0x2D, 0x14, 0x51, 0x40, 0x05, 0x62, 0xF8, 0xB3, 0xC5, 0x1A, 0x4F, 0x85, 0x34, 0xD5, 0xBE, 0xD7, 0x2E, 0xD6, 0xDE, 0x27, 0x91, 0x61, 0x89, 0x7A, 0xBC, 0xB2, 0x31, 0xC0, 0x55, 0x1D, 0xCF, 0xF2, 0x19, 0x27, 0x00, 0x53, 0x3C, 0x5D, 0xE2, 0x6B, 0x4F, 0x0D, 0x58, 0xC5, 0x24, 0xE9, 0x2D, 0xD5, 0xED, 0xCB, 0xF9, 0x36, 0x76, 0x30, 0x0D, 0xD3, 0x5D, 0x4B, 0xD9, 0x10, 0x7E, 0xA5, 0x8F, 0x0A, 0x39, 0x24, 0x0A, 0xF3, 0x7F, 0x1F, 0xF8, 0x66, 0xEC, 0x7C, 0x3D, 0xF1, 0x3F, 0x89, 0xBC, 0x58, 0xF1, 0x5C, 0xF8, 0x8B, 0xEC, 0x2E, 0xD1, 0x47, 0x19, 0xCC, 0x1A, 0x74, 0x60, 0x86, 0xF2, 0xA1, 0xCF, 0x53, 0xC0, 0xDD, 0x27, 0x56, 0x23, 0xB0, 0xC0, 0xA0, 0x0F, 0x65, 0xA2, 0x8A, 0xE1, 0xB5, 0x0D, 0x4F, 0xC4, 0x7A, 0xE7, 0x8A, 0x75, 0x7D, 0x0F, 0xC3, 0xD7, 0x36, 0x1A, 0x4D, 0xA6, 0x9A, 0x21, 0x17, 0x17, 0xF2, 0xC4, 0x6E, 0x27, 0x66, 0x91, 0x37, 0xE2, 0x38, 0xCE, 0x11, 0x70, 0x31, 0xCB, 0x16, 0xEB, 0xD2, 0x80, 0x3B, 0x1B, 0xFB, 0xDB, 0x5D, 0x3A, 0xD2, 0x4B, 0xAD, 0x42, 0xE6, 0x0B, 0x5B, 0x68, 0xC6, 0x5E, 0x69, 0xE4, 0x08, 0x8A, 0x3D, 0x4B, 0x1E, 0x05, 0x72, 0xBF, 0xF0, 0xB4, 0xBC, 0x09, 0xFF, 0x00, 0x43, 0x86, 0x83, 0xFF, 0x00, 0x81, 0xD1, 0xFF, 0x00, 0x8D, 0x2D, 0x87, 0xC3, 0xBD, 0x15, 0x2E, 0xAA, 0xAA, 0xAA, 0xAA};
    
    
    
    int len = sizeof(data);
    

    
//    NSLog(@"NSThread:%@",[NSThread currentThread]);
//
//    
//    [NSThread detachNewThreadSelector:@selector(doSomething) toTarget:self withObject:nil];
//    
//    [self performSelectorInBackground:@selector(doSomething) withObject:nil];
//    
//    [self performSelectorOnMainThread:@selector(doSomething)withObject:nil waitUntilDone:NO ];
//    
//
//    dispatch_queue_t queue = dispatch_get_main_queue();
//    dispatch_queue_t queue1 = dispatch_queue_create("tk", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t queue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    int sum =0;
//    int i=0;
//    for (i=1; sum+i<len; i++) {
//        
//        ReadPosData(&data[sum], i);
//        sum +=i;
//        }
//    ReadPosData(&data[sum], len-sum);
    
    
    //ReadPosData(data, len);
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        
        [self showConnectionAlert];
        return;
    }else {
//        gInterface->WritePosData(data,len);
//        return;
        MiniPosSDKShow(0, 1, 0, "", 0);
        MiniPosSDKShow(1, 1, 0, [UIUtils UTF8_To_GB2312:@"1111111"], 1);
        MiniPosSDKShow(2, 1, 0, [UIUtils UTF8_To_GB2312:@"2222222222"], 1);
        MiniPosSDKShow(3, 1, 0, [UIUtils UTF8_To_GB2312:@"3333333333333"], 1);
        MiniPosSDKShow(3, 1, 0, [UIUtils UTF8_To_GB2312:@""], 2);
        
//        if(MiniPosSDKShow()>=0)
//        {
//            //[self showHUD:@"正在获取设备信息"];
//        }
    }

    
    
}



-(void)doSomething{
    
    NSLog(@"NSThread:%@",[NSThread currentThread]);

}

//签名指令
- (IBAction)sign:(UIButton *)sender {
    

    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        
        [self showConnectionAlert];
        return;
    }else {
        
        if(MiniPosSDKSign()>=0)
        {
            //[self showHUD:@"正在获取设备信息"];
        }
    }
    
}

//扫描枪指令
- (IBAction)scaner:(UIButton *)sender {
    
    
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        
        [self showConnectionAlert];
        return;
    }else {
        
        if(MiniPosSDKScanner()>=0)
        {
            //[self showHUD:@"正在获取设备信息"];
        }
    }
    
}
//下载指令
- (IBAction)downPro:(UIButton *)sender {
    
    
    
    if(MiniPosSDKDeviceState()<0){
        //[self showTipView:@"设备未连接"];
        
        [self showConnectionAlert];
        return;
    }else {
        
        if(MiniPosSDKDownPro()>=0)
        {
            //[self showHUD:@"正在获取设备信息"];
        }
    }
    
}



-(void) showResultWithString:(NSString *)str{
    [self hideHUD];
    [self showTipView:str];
}






#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
     NSLog(@"Hooooooooooooooom");
    
    if (alertView.tag == 44) {
        if (buttonIndex == 0) {
            ConnectDeviceViewController *cdvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CD"];
            [self.navigationController pushViewController:cdvc animated:YES];
            //[self presentViewController:cdvc animated:YES completion:nil];
        }
    }
    
}


#pragma mark - 复写接受方法
- (void)recvMiniPosSDKStatus
{
    
    [super recvMiniPosSDKStatus];
    
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到成功"]]) {
        [self hideHUD];
        NSLog(@"LoginViewController ----签到成功");
        
        [self showTipView:self.statusStr];
    }
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到失败"]]) {
        [self hideHUD];
        NSLog(@"LoginViewController ----签到失败");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"签到失败！" message:self.displayString delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        
    }
    
    
    if ([self.statusStr isEqualToString:@"签退成功"]){
        
        [self hideHUD];
        
        [self showTipView:self.statusStr];
        
        [self performSelector:@selector(backToLogin) withObject:nil afterDelay:1.0];
        

    }
    
    if ([self.statusStr isEqualToString:@"获取设备信息成功"] ) {
        
        
        
            
            [self hideHUD];
            
            NSString *info = [NSString stringWithFormat:@"机身号:%s\n内核版本：%s\n应用版本：%s\nApp版本：%@",MiniPosSDKGetDeviceID(),MiniPosSDKGetCoreVersion(),MiniPosSDKGetAppVersion(),@"iOS20150604003"];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alert show];
            
            SIAlertView *salertView = [[SIAlertView alloc] initWithTitle:NULL andMessage:info];
            [salertView addButtonWithTitle:@"确定"
                                      type:SIAlertViewButtonTypeDefault
                                   handler:^(SIAlertView *alertView) {
                                       
                                   }];
            salertView.cornerRadius = 10;
            salertView.buttonFont = [UIFont boldSystemFontOfSize:15];
            salertView.transitionStyle = SIAlertViewTransitionStyleSlideFromTop;
            [salertView show];
            

    }
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"开始下载"]]) {
        
        
    }
    
    
    if ([self.statusStr isEqualToString:@"结算成功"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }

    
    if ([self.statusStr isEqualToString:@"设备未连接"]) {
       
    }
    
    if ([self.statusStr isEqualToString:@"获取参数成功"]) {
        //NSLog(@"SnNo:%s,TerminalNo:%s,MerchantNo:%s",MiniPosSDKGetParam("SnNo"), MiniPosSDKGetParam("TerminalNo"), MiniPosSDKGetParam("MerchantNo"));
    }
    
    if ([self.statusStr isEqualToString:@"消费响应超时"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }
    
    if ([self.statusStr isEqualToString:@"撤销响应超时"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }
    
    if ([self.statusStr isEqualToString:@"查询余额响应超时"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }
    
    if ([self.statusStr isEqualToString:@"签退响应超时"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }
    
    if ([self.statusStr isEqualToString:@"结算响应超时"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }
    
    if ([self.statusStr isEqualToString:@"获取设备信息响应超时"] ) {
        [self hideHUD];
        [self showTipView:self.statusStr];
    }
    
    
    if ([self.statusStr isEqualToString:@"收取图片成功"] ) {
    
        
        [self showTipView:self.statusStr];
        
        [self.signBt setBackgroundImage:[UIImage imageWithData:[NSData dataWithBytes:imageData length:imageLen]] forState:UIControlStateNormal];
        
        
    
        
        
        NSString *str = [[NSString alloc]initWithFormat:@"tmp/image.jpg"];
        
        NSString *jpgPath = [NSHomeDirectory() stringByAppendingPathComponent:str];
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithBytes:imageData length:imageLen]];
        
        NSData *data = UIImageJPEGRepresentation(image,0.4);
        
        [data writeToFile:jpgPath atomically:YES];
        
        //self.signBt.imageView.image = [UIImage imageWithContentsOfFile:str];
        //self.view
    }
    
    
    self.statusStr=@"";
    
    
}


-(void)backToLogin{
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
