//
//  NDlMPosPay.m
//  GITestDemo
//
//  Created by NDlan on 17/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "NDlMPosPay.h"
#import "AFNetworking.h"
#import "Common.h"
#import "NDlMPosManager.h"
#import "NDlPrint.h"
#import "UserManager.h"
#import "UserSession.h"

extern int _quanjuQianDaoType;
@implementation NDlMPosPay

static NDlMPosPay *miniPoss;

+ (NDlMPosPay *)shardNDlMPosPay{
    static dispatch_once_t oncePredicate;
    if (miniPoss==nil) {
        dispatch_once(&oncePredicate, ^{
            miniPoss=[[self alloc] init];
            miniPoss.sessionCodeResult=[SessionCodeResult new];
            MiniPosSDKInit();
            MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
            //[[NDlMPosManager shardNDlMPosManager] initMiniPosSDKAddDelegate];
            //MiniPosSDKAddDelegate((__bridge void*)self, MiniPosSDKResponce);

        });
        
    }
    return miniPoss;
}



- (instancetype)init {
    if ((self = [super init]) != nil) {
        //实例化数据
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    // Immutable object: 'copy' by reusing the same instance.
    return self;
}

/*
static void MiniPosSDKResponce(void *userData,
                               MiniPosSDKSessionType sessionType,
                               MiniPosSDKSessionError responceCode,
                               const char *deviceResponceCode,
                               const char *displayInfo)
{
    NDlMPosPay *self = (__bridge NDlMPosPay*)userData;
    
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
    
    [self deviceStatus];
}
*/

-(void) didMiniPosSDKDownPro{
    MiniPosSDKDownPro();
}

-(void) didProjFileDownThread:(NSArray*) updateFiles{
    DownThread(nil,updateFiles);
}

- (void)siginAction:(NSString*)phoneNo password:(NSString*)password  {
    //[[NDlPrint initNDlPrint ] demo];
    //[self initMiniPosSDKAddDelegate];
    //登陆到服务器
    //[self didLoginToServer:phoneNo password:password];
    //首先检查设备情况
    [self didConnectPosDevice:phoneNo password:password];
    
}



-(void)loginActionWithPhoneNo:(NSString *)phoneNo andPassword:(NSString *)password{
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/login.action?phone=%@&passwd=%@",kServerIP,kServerPort,phoneNo,password];
    NSLog(@"url:%@",url);
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"code:%@,responseObject:%@",responseObject[@"resultMap"][@"code"],responseObject[@"resultMap"][@"msg"]);
        
        
        int code = [responseObject[@"resultMap"][@"code"]intValue];
        
        if(code == 0){
            
            [[NDlMPosManager shardNDlMPosManager] login:phoneNo
                                               password:password bSignedIn:false];
            //登陆逻辑
            //[UserManager checkSession];
            UserSession *userSession=[UserSession new];
            userSession.status=@"0";
            [UserManager registSession:userSession];
     
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needLoginAction:errorType:)]){
                [self.miniPosManagerDelegate needLoginAction:@"登录成功" errorType:NDLMPOSK_PAY_LOGIN_OK];
            }
        }else{
            
            NSString *msg=responseObject[@"resultMap"][@"msg"];
            if ( [msg isEqualToString:@"登录失败，手机号或密码错误！"]) {
                
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needLoginAction:errorType:)]){
                    [self.miniPosManagerDelegate needLoginAction:msg errorType:NDLMPOSK_PAY_LOGIN_USER_OR_PASSWORD_ERROR];
                }
            }else{
                
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needLoginAction:errorType:)]){
                    [self.miniPosManagerDelegate needLoginAction:msg errorType:NDLMPOSK_PAY_LOGIN_OTHER_ERROR];
                }
            }
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needLoginAction:errorType:)]) {
            [self.miniPosManagerDelegate needLoginAction:@"网络协议异常" errorType:NDLMPOSK_PAY_LOGIN_NETWORK_ERROR];
        }
        
    }];
    
    
}




-(void)didConnectPosDevice:(NSString*)phoneNo password:(NSString*)password{
    if(MiniPosSDKDeviceState()==0)
    {
        //设备连接
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self didPosDeviceParams];
            
        });
        //登陆到服务器
        [self didLoginToServer:phoneNo password:password];
        
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
             [self.miniPosManagerDelegate needSiginAction:@"设备已连接" errorType:NDMPOSK_PAY_LOGIN_SIGN_DIVICE_CONNECTED sessionCodeResult:self.sessionCodeResult];
        }
        
    }
    else
    {
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
            [self.miniPosManagerDelegate needSiginAction:@"设备未连接" errorType:NDMPOSK_PAY_LOGIN_SIGN_DIVICE_NOCONNECTED sessionCodeResult:self.sessionCodeResult];
        }
        
    }
   
}

-(void)didLoginToServer:(NSString*)phoneNo password:(NSString*)password {
    NSString *shanghuName = [[NSUserDefaults standardUserDefaults] objectForKey:kShangHuName];
    NSString *ip = [[NSUserDefaults standardUserDefaults]objectForKey:kHostEditor];
    NSString *port = [[NSUserDefaults standardUserDefaults]objectForKey:kPortEditor];
    
    if (shanghuName ==nil || ip ==nil || port == nil) {
        //[self showTipView:@"请先进入系统设置完成参数设置。"];
        return;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/login.action?phone=%@&passwd=%@",kServerIP,kServerPort,phoneNo,password];
    NSLog(@"url:%@",url);
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject:%@",responseObject[@"resultMap"][@"msg"]);
        
        
        int code = [responseObject[@"resultMap"][@"code"]intValue];
        
        if(code == 0){
            [[NDlMPosManager shardNDlMPosManager] login:phoneNo
                                               password:password bSignedIn:false];
            //登陆逻辑
            //[UserManager checkSession];
            UserSession *userSession=[UserSession new];
            userSession.status=@"0";
            [UserManager registSession:userSession];
            //签到
            [self siginToMPos];
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
                [self.miniPosManagerDelegate needSiginAction:@"登陆成功" errorType:NDMPOSK_PAY_LOGIN_SIGN_LOGIN_OK sessionCodeResult:self.sessionCodeResult];
            }
        }else{
            NSString *msg=responseObject[@"resultMap"][@"msg"];
            if ( [msg isEqualToString:@"登录失败，手机号或密码错误！"]) {
                
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
                    [self.miniPosManagerDelegate needSiginAction:msg errorType:NDMPOSK_PAY_LOGIN_SIGN_LOGIN_MOBLEORPASS_ERROR sessionCodeResult:self.sessionCodeResult];
                }
            }else{
                
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
                    [self.miniPosManagerDelegate needSiginAction:msg errorType:NDMPOSK_PAY_LOGIN_SIGN_LOGIN_MOBLEORPASS_OTHERERROR sessionCodeResult:self.sessionCodeResult];
                }
            }
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
            [self.miniPosManagerDelegate needSiginAction:@"网络协议异常" errorType:NDMPOSK_PAY_LOGIN_SIGN_LOGIN_NETERROR sessionCodeResult:self.sessionCodeResult];
        }
        
    }];

}


//应当把此逻辑转移到登陆的实现中NDlMPosPay的siginAction
- (void)siginToMPos
{
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到成功"]]) {
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
            [self.miniPosManagerDelegate needSiginAction:self.statusStr errorType:NDMPOSK_PAY_LOGIN_SIGN_OK sessionCodeResult:self.sessionCodeResult];
        }
    }else if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到失败"]]) {
        
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
            [self.miniPosManagerDelegate needSiginAction:self.statusStr errorType:NDMPOSK_PAY_LOGIN_SIGN_ERROR sessionCodeResult:self.sessionCodeResult];
        }
        
    }else if ([self.statusStr isEqualToString:@"签到响应超时"]) {
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSiginAction:errorType:sessionCodeResult:)]){
            [self.miniPosManagerDelegate needSiginAction:@"签到响应超时" errorType:NDMPOSK_PAY_LOGIN_SIGN_TIMEOUT sessionCodeResult:self.sessionCodeResult];
        }
    }else if([self.statusStr isEqualToString:@"签到响应超时"]){
        [self.miniPosManagerDelegate needSiginAction:@"获取参数成功" errorType:NDMPOSK_PAY_LOGIN_SIGN_TIMEOUT sessionCodeResult:self.sessionCodeResult];
    }

 
}




//获取终端信息
-(NSString*)didObtainSnNo{
    return [NSString stringWithCString:MiniPosSDKGetParam("SnNo") encoding:NSUTF8StringEncoding];
}

-(NSString*)didObtainTerminalNo{
    return [NSString stringWithCString:MiniPosSDKGetParam("TerminalNo") encoding:NSUTF8StringEncoding];
}

-(NSString*)didObtainMerchantNo{
     return [NSString stringWithCString:MiniPosSDKGetParam("MerchantNo") encoding:NSUTF8StringEncoding];
}

-(void)didPosDeviceParams{
    
    NSLog(@"didConnectDevice");
    
    char paramname[100];
    
    memset(paramname, 0x00, sizeof(paramname));
    strcat(paramname, "TerminalNo");//10
    strcat(paramname, "\x1C");//1
    strcat(paramname, "MerchantNo");//10
    strcat(paramname, "\x1C");//1
    strcat(paramname, "SnNo");//4
    //获取设备参数
    MiniPosSDKGetParams("88888888", paramname);
}


//普通刷卡,回调函数
-(void)payWithCreditCard:(NSString*)cashText{
    
    if (cashText.floatValue < 1 || cashText.floatValue > 50000) {
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needPayWithCreditCard:errorType:)]){
            [self.miniPosManagerDelegate needPayWithCreditCard:@"常规消费区间是1~50000" errorType:NDMPOSK_PAY_CARD_CASH_RANGE_ERROR];
        }
        return;
    }
    BOOL ready=[[NDlMPosCoreSDK shardNDlMPosCoreSDK] deviceIsConnected];
    //确认蓝牙是否连接
    if(!ready){
        //无设备连接
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needPayWithCreditCard:errorType:)]){
            //[self.miniPosManagerDelegate needPayWithCreditCard:@"无设备连接" errorType:NDMPOSK_PAY_CARD_CASH_DEVICE_ERROR];
        }
        return;
    }else{
        _quanjuQianDaoType = 0;
        [self verifyParamsSuccess:^{
            //刷卡消费
            if (MiniPosSDKGetCurrentSessionType()== SESSION_POS_UNKNOWN) {
                //[self swipeWithCreditCard:cashText type:nil success:nil fail:nil];
                [[NDlMPosCoreSDK shardNDlMPosCoreSDK] swipeWithCreditCard:cashText
                    type:@"1" success:^(NSDictionary *dict){
                        //刷卡开始
                        NSLog(@"刷卡开始");
                    }fail:^(NSString *failMs){
                        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needPayWithCreditCard:errorType:)]){
                            [self.miniPosManagerDelegate needPayWithCreditCard:@"请确定交易金额！" errorType:NDMPOSK_PAY_CARD_CASH_ACK];
                        }
                    }];
                /*
                int amount  = [cashText doubleValue]*100;
                
                if (amount > 0) {
                    
                    char buf[20];
                    
                    sprintf(buf,"%012d",amount);
                    
                    NSLog(@"amount: %s",buf);
                    _type = 1;
                    //sdk的消费方法，刷卡数据
                    MiniPosSDKSaleTradeCMD(buf, NULL,"1");
                    if ([self.miniPosManagerDelegate respondsToSelector:@selector(needPayWithCreditCard:errorType:)]){
                        [self.miniPosManagerDelegate needPayWithCreditCard:@"常规消费" errorType:NDMPOSK_PAY_CARD_CASH_OK];
                    }
               } else {
                    if ([self.miniPosManagerDelegate respondsToSelector:@selector(needPayWithCreditCard:errorType:)]){
                        [self.miniPosManagerDelegate needPayWithCreditCard:@"请确定交易金额！" errorType:NDMPOSK_PAY_CARD_CASH_ACK];
                    }
                }
                */
            }else{
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needPayWithCreditCard:errorType:)]){
                    [self.miniPosManagerDelegate needPayWithCreditCard:@"设备繁忙，稍后再试" errorType:NDMPOSK_PAY_CARD_CASH_DEVICE_BUSING];
                }
            }
            
        }];
    }
}


@end
