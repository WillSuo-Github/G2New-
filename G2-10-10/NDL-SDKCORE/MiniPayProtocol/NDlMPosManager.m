//
//  NDlMPosManager.m
//  GITestDemo
//
//  Created by NDlan on 12/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "NDlMPosManager.h"
#import "UIUtils.h"
#import "des.h"
#import "AFNetworking.h"
#import "NDlMPosManagerDelegate.h"
#import "NDlMPosModel.h"
#import "PromptInfo.h"
#import "CustomAlertView.h"
#import "NDlMPosCoreSDK.h"
#import "NDlMPosPay.h"
#import "NDlPrint.h"

@interface NDlMPosManager ()
{
    //NSTimer *timer;
    BOOL hasSettedParam;
    BOOL hasDone;
    
    NSString *web_kernel;
    NSString *web_task;
    NSString *pos_kernel;
    NSString *pos_task;
    NSMutableArray *updateFiles;
    CustomAlertView *cav;
    NSDictionary *sessionCodeDic;
    NSDictionary *responseCodeDic;
    
    
    
}
@end
@implementation NDlMPosManager
@synthesize sessionCodeResult=_sessionCodeResult;
@synthesize displayString=_displayString;

//接口单例
static NDlMPosManager *miniPos;
+ (NDlMPosManager *)shardNDlMPosManager{
    static dispatch_once_t oncePredicate;
    if (miniPos==nil) {
        dispatch_once(&oncePredicate, ^{
            miniPos=[[self alloc] init];
            
            miniPos.sessionCodeResult=[[SessionCodeResult alloc]init];
            MiniPosSDKInit();//MiniPosSDK的方法,设置Session状态为SESSION_POS_UNKNOWN
            MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
        });
        
    }
    return miniPos;
}

//初始化时执行报文提交功能
-(instancetype)initWithMPosSDK{
    if ((self = [super init]) != nil) {
        //实例化数据
        self.sessionCodeResult=[[SessionCodeResult alloc]init];
        MiniPosSDKInit();//MiniPosSDK的方法,设置Session状态为SESSION_POS_UNKNOWN
        DeviceDriverInterface *deviceDrivewInferface=GetBLEDeviceInterface();
        MiniPosSDKRegisterDeviceInterface(deviceDrivewInferface);

    }
    return self;
}
- (instancetype)init {
    if ((self = [super init]) != nil) {
        //实例化数据
    }
    return self;
}

//
- (void) initMiniPosSDKAddDelegate{
    //注册回调方法
    MiniPosSDKAddDelegate((__bridge void*)self, MiniPosSDKResponce);
    
}

//由BLE调用
void MiniPosSDKResponce(void *userData,
                               MiniPosSDKSessionType sessionType,
                               MiniPosSDKSessionError responceCode,
                                const char *deviceResponceCode,
                               const char *displayInfo)
{
    //BaseViewController *self = (__bridge BaseViewController*)userData;
    NDlMPosManager *self = (__bridge NDlMPosManager*)userData;
    SessionCodeResult *sessionCodeResult=[SessionCodeResult new];
    sessionCodeResult=[SessionCodeResult new];
    sessionCodeResult.sessionType=sessionType;
    sessionCodeResult.responceCode=responceCode;
    self.sessionCodeResult=sessionCodeResult;//[SessionCodeResult new];
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
    
    self.sessionCodeResult.displayInfo=self.displayString;
    //-(void)payStatus:(MiniPosSDKSessionType)sessionType responceCode:(MiniPosSDKSessionError)responceCode
    [[NDlMPosCoreSDK shardNDlMPosCoreSDK] payStatus:sessionType responceCode:responceCode];
    [self deviceStatus];
}

/*
SESSION_POS_LOGIN,                      //POS机签到
SESSION_POS_GET_DEVICE_INFO,            //获取设备信息
SESSION_POS_SALE_TRADE,                 //消费
SESSION_POS_VOIDSALE_TRADE,             //撤销消费
SESSION_POS_QUERY,                      //查磁条卡余额
SESSION_POS_SETTLE,                     //结算
SESSION_POS_DOWNLOAD_KEY,               //公钥下载
SESSION_POS_DOWNLOAD_AID_PARAM,         //AID参数下载
SESSION_POS_DOWNLOAD_PARAM,             //参数下载
SESSION_POS_PRINT,                      //打印
SESSION_POS_GET_DEVICE_ID,              //获取设备序列号
SESSION_POS_CANCEL_READ_CARD,           //取消刷卡
SESSION_POS_READ_CARD_INFO,             //读取磁道信息
SESSION_POS_READ_PIN_CARD_INFO,         //输密并读取磁道信息
SESSION_POS_READ_IC_INFO,         		//读取IC卡信息
SESSION_POS_UPDATE_KEY,         		//更新工作密钥
SESSION_POS_LOGOUT,	         			//签退
SESSION_POS_CANCEL,						//取消操作
SESSION_POS_DOWN_PRO,					//下载程序
SESSION_POS_UPLOAD_PARAM				//上传参数
 */
-(NSDictionary*)sessionCodeDic{
    if (!sessionCodeDic) {
        sessionCodeDic=[NSDictionary dictionaryWithObjectsAndKeys:
                        @"未知",[NSString stringWithFormat:@"%d",SESSION_POS_UNKNOWN] ,
                        @"POS机签到",[NSString stringWithFormat:@"%d",SESSION_POS_LOGIN],
                        @"获取设备信息",[NSString stringWithFormat:@"%d",SESSION_POS_GET_DEVICE_INFO],
                        @"消费",[NSString stringWithFormat:@"%d",SESSION_POS_SALE_TRADE],
                        @"撤销消费",[NSString stringWithFormat:@"%d",SESSION_POS_VOIDSALE_TRADE],
                        @"查磁条卡余额",[NSString stringWithFormat:@"%d",SESSION_POS_QUERY],
                        @"结算",[NSString stringWithFormat:@"%d",SESSION_POS_SETTLE],
                        @"公钥下载",[NSString stringWithFormat:@"%d",SESSION_POS_DOWNLOAD_KEY],
                        @"AID参数下载",[NSString stringWithFormat:@"%d",SESSION_POS_DOWNLOAD_AID_PARAM],
                        @"参数下载",[NSString stringWithFormat:@"%d",SESSION_POS_DOWNLOAD_PARAM],
                        @"打印",[NSString stringWithFormat:@"%d",SESSION_POS_PRINT],
                        @"获取设备序列号",[NSString stringWithFormat:@"%d",SESSION_POS_GET_DEVICE_ID],
                        @"取消刷卡",[NSString stringWithFormat:@"%d",SESSION_POS_CANCEL_READ_CARD],
                        @"读取磁道信息",[NSString stringWithFormat:@"%d",SESSION_POS_READ_CARD_INFO],
                        @"输密并读取磁道信息",[NSString stringWithFormat:@"%d",SESSION_POS_READ_PIN_CARD_INFO],
                        @"读取IC卡信息",[NSString stringWithFormat:@"%d",SESSION_POS_READ_IC_INFO],
                        @"更新工作密钥",[NSString stringWithFormat:@"%d",SESSION_POS_UPDATE_KEY],
                        @"签退",[NSString stringWithFormat:@"%d",SESSION_POS_LOGOUT],
                        @"取消操作",[NSString stringWithFormat:@"%d",SESSION_POS_CANCEL],
                        @"下载程序",[NSString stringWithFormat:@"%d",SESSION_POS_DOWN_PRO],
                        @"上传参数",[NSString stringWithFormat:@"%d",SESSION_POS_UPLOAD_PARAM],
                        nil];
    }
    return sessionCodeDic;
}

-(NSString*)sessionCodeInfo:(MiniPosSDKSessionType)code{
    NSString* d=[NSString stringWithFormat:@"%d",code];
    return (NSString*)[[self sessionCodeDic] objectForKey:d];
}
/*
SESSION_ERROR_ACK,                      //设备成功处理会话请求,并返回成功
SESSION_ERROR_NAK,                      //设备拒绝会话请求，或处理请求出错
SESSION_ERROR_NO_REGISTE_INTERFACE,     //没有注册设备与手机之间的通讯驱动
SESSION_ERROR_NO_DEVICE,                //没有检测到设备
SESSION_ERROR_DEVICE_PLUG_IN,           //设备已经插入
SESSION_ERROR_DEVICE_PLUG_OUT,          //设备已经拔出
SESSION_ERROR_DEVICE_NO_RESPONCE,       //设备对请求没有响应
SESSION_ERROR_DEVICE_RESPONCE_TIMEOUT,  //设备对请求响应超时
SESSION_ERROR_SEND_8583_ERROR,          //发往POS中心的8583包没有发送成功，请检查网络和服务器IP和端口是否正确
SESSION_ERROR_RECIVE_8583_ERROR,        //接收POS中心回的8583包出错，请检查网络是否正常
SESSION_ERROR_NO_SET_PARAM,             //没有设置公共参数或没有设置POS中心IP端口
SESSION_ERROR_DEVICE_BUSY,              //设备繁忙，请稍后再试
SESSION_ERROR_DEVICE_SEND,              //发送失败
SESSION_ERROR_SHAKE_PACK                //收到握手包
*/
-(NSDictionary*)responseCodeDic{
    if (!responseCodeDic) {
        responseCodeDic=[NSDictionary  dictionaryWithObjectsAndKeys:
                         @"设备成功处理会话请求,并返回成功",[NSString stringWithFormat:@"%d",SESSION_ERROR_ACK ],
                         @"设备拒绝会话请求，或处理请求出错",[NSString stringWithFormat:@"%d",SESSION_ERROR_NAK],
                         @"没有注册设备与手机之间的通讯驱动",[NSString stringWithFormat:@"%d",SESSION_ERROR_NO_REGISTE_INTERFACE],
                         @"没有检测到设备",[NSString stringWithFormat:@"%d",SESSION_ERROR_NO_DEVICE],
                         @"设备已经插入",[NSString stringWithFormat:@"%d",SESSION_ERROR_DEVICE_PLUG_IN],
                         @"设备已经拔出",[NSString stringWithFormat:@"%d",SESSION_ERROR_DEVICE_PLUG_OUT],
                         @"设备对请求没有响应",[NSString stringWithFormat:@"%d",SESSION_ERROR_DEVICE_NO_RESPONCE],
                         @"设备对请求响应超时",[NSString stringWithFormat:@"%d",SESSION_ERROR_DEVICE_RESPONCE_TIMEOUT],
                         @"发往POS中心的8583包没有发送成功，请检查网络和服务器IP和端口是否正确",[NSString stringWithFormat:@"%d",SESSION_ERROR_SEND_8583_ERROR],
                         @"接收POS中心回的8583包出错，请检查网络是否正常",[NSString stringWithFormat:@"%d",SESSION_ERROR_RECIVE_8583_ERROR],
                         @"没有设置公共参数或没有设置POS中心IP端口",[NSString stringWithFormat:@"%d",SESSION_ERROR_NO_SET_PARAM],
                         @"设备繁忙，请稍后再试",[NSString stringWithFormat:@"%d",SESSION_ERROR_DEVICE_BUSY],
                         @"发送失败",[NSString stringWithFormat:@"%d",SESSION_ERROR_DEVICE_SEND],
                         @"收到握手包",[NSString stringWithFormat:@"%d",SESSION_ERROR_SHAKE_PACK],
                         nil];
        
    }
    
    
    
    return responseCodeDic;
}

-(NSString*)responseCodeDicInfo:(MiniPosSDKSessionError)code{
    NSString* d=[NSString stringWithFormat:@"%d",code];
    return (NSString*)[[self responseCodeDic] objectForKey:d];
}

- (id)copyWithZone:(NSZone *)zone {
    // Immutable object: 'copy' by reusing the same instance.
    return self;
}



- (void)initConfigureForBLESDK{
    
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
    //结构调整 LiuJQ
    //MiniPosSDKInit();
    NSLog(@"LoginViewController-host:%s,port:%d",host.UTF8String,port.intValue);
    //MiniPosSDKSetPublicParam(shangHu.UTF8String, zhongDuan.UTF8String, caoZhuoYuan.UTF8String);
    // MiniPosSDKSetPostCenterParam(host.UTF8String, port.intValue, 0);
    //结构调整 LiuJQ
    //MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
}



-(void)run{
    //MiniPosSDKRunThread();
    //MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
    [self deviceStatus];
    //if ([self.miniPosManagerDelegate respondsToSelector:@selector(needInitMiniPosSDKAddDelegate:)]){
    //    [self.miniPosManagerDelegate needInitMiniPosSDKAddDelegate:YES];
    //}
}

- (void) removeMiniPosSDKDelegate{
     //MiniPosSDKRemoveDelegate((__bridge void*)self);
}

-(void)praseMiniPosSDKResponse:(void *)userData
                   sessionType:(MiniPosSDKSessionType)sessionType
                  responseCode:(MiniPosSDKSessionError)responceCode deviceResponceCode:(const char *)deviceResponceCode displayInfo:(const char *)displayInfo{
    MiniPosSDKResponce(userData,
                       sessionType,
                       responceCode,
                       deviceResponceCode,
                       displayInfo);
}


-(void)setSessionCodeResultInfo{
    if (self.sessionCodeResult==nil) {
        self.sessionCodeResult=[[SessionCodeResult alloc]init];
    }
    self.sessionCodeResult.msg=self.statusStr;
    self.sessionCodeResult.sessionType=self.sessionType;
    self.sessionCodeResult.responceCode=self.responceCode;
    self.sessionCodeResult.sessionTypeText=[self sessionCodeInfo:self.sessionType];
    self.sessionCodeResult.responceCodeText=[self responseCodeDicInfo:self.responceCode];
}

- (void) deviceStatus
{
    if ((int)(self.responceCode) < 0 ) {
        NSLog(@"deviceStatus responceCode :%ul",self.responceCode);
        return;
    }
    
    
    
    if(self.responceCode==SESSION_ERROR_ACK)
    {
        if(self.sessionType==SESSION_POS_UNKNOWN)
        {
            self.statusStr=@"未知";
        }
        else if(self.sessionType==SESSION_POS_LOGIN)
        {
            self.statusStr=@"签到成功";

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
            
        }else if(self.sessionType == SESSION_POS_DOWN_PRO)
        {
            self.statusStr=@"开始下载";
            
        }
        else if(self.sessionType==SESSION_POS_GET_DEVICE_ID)
        {
            //回调
            self.statusStr=@"获取设备序列号成功";
            [self setSessionCodeResultInfo];
            //- (void)needMiniPosSDKResponse:(SessionCodeResult *)result;
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
                [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
            }
            return;
        }
        else if(self.sessionType==SESSION_POS_READ_CARD_INFO)
        {
            [self setSessionCodeResultInfo];
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
                [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
            }
            return;
        }
        else if(self.sessionType==SESSION_POS_READ_PIN_CARD_INFO)
        {
            self.statusStr=@"获取磁道和密码信息成功";
            [self setSessionCodeResultInfo];
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
                [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
            }
            return;
        }
        else if(self.sessionType== SESSION_POS_DOWNLOAD_PARAM)
        {
            self.statusStr = @"获取参数成功";
            [self setSessionCodeResultInfo];
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
                [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
            }
            return;
        }
        else if(self.sessionType== SESSION_POS_UPLOAD_PARAM)
        {
            self.statusStr = @"上传参数成功";
            [self setSessionCodeResultInfo];
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
                [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
            }
            return;
        }
    }
    else if(self.responceCode==SESSION_ERROR_NAK)
    {
        if(self.sessionType==SESSION_POS_LOGIN)
        {
            self.statusStr=@"签到失败";
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
        }
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
            //self.statusStr=@"下载公钥响应超时";
            self.sessionCodeResult.msg=@"下载公钥响应超时";
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
        }
        
    }
    else if(self.responceCode==SESSION_ERROR_NO_REGISTE_INTERFACE)
    {
        self.statusStr=@"没有注册驱动";
        self.sessionCodeResult.msg=@"没有注册驱动";
    }
    else if(self.responceCode==SESSION_ERROR_NO_SET_PARAM)
    {
        self.statusStr=@"没有设置参数";
    }
    else if(self.responceCode==SESSION_ERROR_DEVICE_BUSY)
    {
        self.statusStr=@"设备繁忙，稍后再试";
 
    }
    [self setSessionCodeResultInfo];
    //此处回调
    [self recvMiniPosSDKStatus];
    
}

- (void)recvMiniPosSDKStatus
{
    //NSLog(@"self.statusStr = %@",self.statusStr);
    //self.statusStr=@"设备繁忙，稍后再试";
    
    if ([self.statusStr isEqualToString:@"设备繁忙，稍后再试"]) {
        
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
            [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
        }
    }
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"上传参数成功"]]) {
        
        hasSettedParam = true;
    }
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"签到成功"]]) {
        
        hasDone = true;
        [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
    }
    
    if ([self.statusStr isEqualToString:@"获取设备信息成功"] ) {
        
        if (_isFirstGetVersionInfo){
            
            pos_kernel = [NSString stringWithCString:MiniPosSDKGetCoreVersion() encoding:NSASCIIStringEncoding];
            pos_task = [NSString stringWithCString:MiniPosSDKGetAppVersion() encoding:NSASCIIStringEncoding];
            
            NSString *message = [NSString stringWithFormat:@"pos_kernel:%@\npos_task:%@",pos_kernel,pos_task];
            
            
            NSLog(@"message:%@",message);
            
            [self downloadWebVersionFile];
            
        }
    }else{
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needMiniPosSDKResponse:)]){
            
            [self.miniPosManagerDelegate needMiniPosSDKResponse:self.sessionCodeResult];
        }
    }
}

//私有方法，目前在recvMiniPosSDKStatus中当是第一次使用时调用。从服务器下载版本文件
- (void)downloadWebVersionFile{
    
    //    if(isFirstGetVersionInfo==false){
    //        [self showHUD:@"正在从服务器获取版本信息"];
    //    }
    
    // 1
    NSString *baseURLString = @"http://120.24.213.123/app/version.json";
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
        
        //[self hideHUD];

        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadWebVersionFile:)]){
            [self.miniPosManagerDelegate needDownloadWebVersionFile:YES];
        }
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithContentsOfFile:str] options:kNilOptions error:NULL];
        
        NSLog(@"%@",dictionary);
        
        NSDictionary *g1 = dictionary[@"G1"];
        
        web_kernel = g1[@"kernel"];
        web_task = g1[@"task"];
        
        NSString *message = [NSString stringWithFormat:@"web_kernel:%@\nweb_task:%@",web_kernel,web_task];
        
        NSLog(@"message:%@",message);
        
        
        //成功就获取本地版本号
        [self getPosVersionInfo];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadWebVersionFile:)]){
            [self.miniPosManagerDelegate needDownloadWebVersionFile:FALSE];
        }
        
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
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定更新", nil];
        //alert.tag = 22;
        //[alert show];
        //-(void)needDownloadWebVersionInfo:( NSString*)result;
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadWebVersionInfo:bNewVersion:)]){
            [self.miniPosManagerDelegate needDownloadWebVersionInfo:info bNewVersion:YES];
        }
        
    }else if(_isFirstGetVersionInfo==false){
        
        NSString *info = [NSString stringWithFormat:@"您的软件是最新版本"];
        //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        //[alert show];
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadWebVersionInfo:bNewVersion:)]){
            [self.miniPosManagerDelegate needDownloadWebVersionInfo:info bNewVersion:NO];
        }
        
    }
    
    _isFirstGetVersionInfo = false;
    
    
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
    
    //加解密
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

static void HexString2Bytes(unsigned char *hexstr,unsigned char *str) {
    int no = strlen(hexstr)/2;
		  for (int i = 0; i < no; i++) {
              unsigned char c0 = *hexstr++;
              unsigned char c1 = *hexstr++;
              str[i] = (unsigned char) ((parse(c0) << 4) | parse(c1));
          }
    
}


static char parse(char c) {
    if (c >= 'a')
        return (c - 'a' + 10) & 0x0f;
    if (c >= 'A')
        return (c - 'A' + 10) & 0x0f;
    return (c - '0') & 0x0f;
}

- (void)setPosWithParams:(NSDictionary *)dictionary success:(void (^)())success{
    
    
    dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.downloadParam", DISPATCH_QUEUE_SERIAL);
    
    
    NSArray *array = [dictionary allKeys];
    
    for (NSString *key in array) {
        
        dispatch_async(serial_queue, ^{
            hasSettedParam = false;
            [[NDlMPosCoreSDK shardNDlMPosCoreSDK] mPosSDKPram:@"000000000" paramname:key paramvalue:[dictionary objectForKey:key]];
            /*
            MiniPosSDKSetParam("000000000",
                               [UIUtils UTF8_To_GB2312:key],
                               [[dictionary objectForKey:key]UTF8String]);
             */
            while (hasSettedParam ==false) {
                [NSThread sleepForTimeInterval:0.125];
            }
            
            NSLog(@"MiniPosSDKSetParam----done");
            
        });
        
    }
    
    dispatch_async(serial_queue, ^{
        hasSettedParam = false;
        //MiniPosSDKSetParam("000000000", "", "");
        [[NDlMPosCoreSDK shardNDlMPosCoreSDK] mPosSDKPram:@"000000000" paramname:@"" paramvalue:@""];
        while (hasSettedParam ==false) {
            [NSThread sleepForTimeInterval:0.125];
        }
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needSetPosWithParams:)]){
            [self.miniPosManagerDelegate needSetPosWithParams:nil];
        }
        //处理接口
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(success){
                success();
            }
            
        });
        
    });
    
    
}


//验证pos端的参数，成功后执行block
- (void) verifyParamsSuccess:(void (^)())success{
    {
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1SN];
        NSString *merchantNo  = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1MerchantNo];
        NSString *terminalNo  = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo];
        NSString *phoneNo = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginPhoneNo];
        
        
        
        NSString *url = [NSString stringWithFormat:@"http://%@:%@/MposApp/keyIssued.action?sn=%@&user=%@&mid=%@&tid=%@&flag=0800003",kServerIP,kServerPort,sn,phoneNo,merchantNo,terminalNo];
        NSLog(@"url:%@",url);
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"responseObject:%@",responseObject);
            NSLog(@"msg:%@",responseObject[@"resultMap"][@"msg"]);
            
            int code = [responseObject[@"resultMap"][@"code"]intValue];
            
            if (code == 3 ) {
                //结构调整 修改为回调方式实现 LiuJQ
                VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE3_WRITING;
                result.msg=@"正在写入参数";
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                    [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                }
                //[self showHUD:@"正在写入参数"];
                
                
                NSString *mainKey  = [self decryptMainKey:responseObject[@"resultMap"][@"tmk"]];
                NSString *tid = responseObject[@"resultMap"][@"tid"];
                NSString *mid = responseObject[@"resultMap"][@"mid"];
                NSLog(@"mainKey:%@",mainKey);
                
                NSDictionary *dictionary = @{@"商户号":mid,@"终端号":tid,@"主密钥1":mainKey};
                
                [self setPosWithParams:dictionary success:^{
                   BOOL isLogin= [[NDlMPosCoreSDK shardNDlMPosCoreSDK] loginInMiniPos:nil success:^(SessionCodeResult *result) {
                        NSLog(@"OK");
                    } fail:^(NSString *failMs) {
                        NSLog(@"Error");
                    }];
                    
                    if(isLogin)
                    {
                        //
                        //结构调整 修改为回调方式实现 LiuJQ
                        VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                        result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE3_SIGN;
                        result.msg=@"正在签到";
                        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                            [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                        }
                        //[self showHUD:@"正在签到"];
                        
                    }
                }];
                
                [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                
                
            }else  if (code == 0 ) {
                
                dispatch_queue_t serial_queue =  dispatch_queue_create("cn.yogia.SDK", DISPATCH_QUEUE_SERIAL);
                
                
                BOOL hasSignedIn = [[NSUserDefaults standardUserDefaults] boolForKey:kHasSignedIn];
                
                
                if (!hasSignedIn) {
                    //dispatch_async(serial_queue
                    dispatch_async(serial_queue, ^{
                        hasDone = false;
                        //是否登陆到Pos
                        BOOL isLogin= [[NDlMPosCoreSDK shardNDlMPosCoreSDK] loginInMiniPos:nil success:^(SessionCodeResult *result) {
                            NSLog(@"OK");
                        } fail:^(NSString *failMs) {
                            NSLog(@"Error");
                        }];
                        
                        if(isLogin)
                        {
                            //dispatch_sync(dispatch_queue_t queue, <#^(void)block#>) LiuJQ
                            dispatch_sync(dispatch_get_main_queue(),
                                           ^{
                                //                                [self showHUD:@"正在签到"];
                                VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                                result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE0_SIGN;
                                result.msg=@"正在签到";
                                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                                    [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                                }
                                //[self showTipView:@"正在签到"];
                            });
                         }
                        
                        while (hasDone ==false) {
                            [NSThread sleepForTimeInterval:0.125];
                        }
                        
                        [[NSUserDefaults standardUserDefaults]setBool:true forKey:kHasSignedIn];
                        NSLog(@"hasDone");
                    });
                }
                
                dispatch_async(serial_queue, ^{
                    //LiuJQ 内部队列任务由异步修改为同步执行
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        success();
                    });
                    
                });
                
                
                
                
            }else if(code == 4){
                
                
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
                    
                    if (code == 3 ) {
                        //
                        //                                [self showHUD:@"正在签到"];
                        VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                        result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_WRITING;
                        result.msg=@"正在写入参数";
                        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                            [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                        }
                        //[self showHUD:@"正在写入参数"];
                        
                        
                        NSString *mainKey  = [self decryptMainKey:responseObject[@"resultMap"][@"tmk"]];
                        NSString *tid = responseObject[@"resultMap"][@"tid"];
                        NSString *mid = responseObject[@"resultMap"][@"mid"];
                        NSLog(@"mainKey:%@",mainKey);
                        
                        NSDictionary *dictionary = @{@"商户号":mid,@"终端号":tid,@"主密钥1":mainKey};
                        
                        [self setPosWithParams:dictionary success:^{
                            BOOL isLogin= [[NDlMPosCoreSDK shardNDlMPosCoreSDK] loginInMiniPos:nil success:^(SessionCodeResult *result) {
                                NSLog(@"OK");
                            } fail:^(NSString *failMs) {
                                NSLog(@"Error");
                            }];
                           
                            if(isLogin)
                            {
                                
                                //                                [self showHUD:@"正在签到"];
                                VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                                result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_SIGN;
                                result.msg=@"正在签到";
                                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                                    [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                                }
                                //[self showTipView:@"正在签到"];
                                
                            }
                            
                        }];
                        
                        [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                        [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                        [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        
                        
                        
                    }else{
                        //                                [self showHUD:@"正在签到"];
                        VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                        result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE3IN4_SIGNED;
                        result.msg=responseObject[@"resultMap"][@"msg"];
                        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                            [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                        }
                        //[self showTipView:responseObject[@"resultMap"][@"msg"]];
                    }
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                    result.step=NDMPOSK_MANAGER_NETWOKR_ERROR;
                    result.msg=@"网络异常";
                    if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                        [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                    }
                    //[self hideHUD];
                    // NSLog(@"failure");
                    //[self showTipView:@"网络异常"];
                    
                }];
                
            }else{
                VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
                result.step=NDMPOSK_MANAGER_VERIFYPARAM_CODE_SIGNED;
                result.msg=responseObject[@"resultMap"][@"msg"];
                if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                    [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
                }
                //[self showTipView:responseObject[@"resultMap"][@"msg"]];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            VerifyParamsSuccessResult *result=[VerifyParamsSuccessResult new];
            result.step=NDMPOSK_MANAGER_NETWOKR_ERROR;
            result.msg=@"网络异常";
            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needVerifyParamsSuccess:)]){
                [self.miniPosManagerDelegate needVerifyParamsSuccess:result];
            }
            //[self hideHUD];
            //NSLog(@"failure");
            //[self showTipView:@"网络异常"];
            
        }];
    }
}



- (void)downloadFromWebAndTransmitToPos{
    
    
    
    if ([updateFiles count]>0) {
        //进度
        cav = [[CustomAlertView alloc]init];
        
        //[self.view addSubview:cav];
        [cav show];
        
        [self download:updateFiles[0] CompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"download %@ success",updateFiles[0]);
            if ([updateFiles count] >1) {
                [self download:updateFiles[1] CompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    //
                    //MiniPosSDKDownPro();
                    [[NDlMPosPay shardNDlMPosPay] didMiniPosSDKDownPro];
                    [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                        //
                        //DownThread((__bridge void*)cav,updateFiles);
                        [[NDlMPosPay shardNDlMPosPay] didProjFileDownThread:updateFiles ];
                        //[[NDlMPosPay shardNDlMPosPay] didMiniPosSDKDownPro];
                        [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
                        
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [cav dismiss];
                            if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadFromWebAndTransmitToPos:errorType:)]){
                                [self.miniPosManagerDelegate needDownloadFromWebAndTransmitToPos:@"更新完成"
                                                                                       errorType:NDMPOSK_MANAGER_VERSIONUPDATED_TO_POS_OK];
                            }
                        });
                        
                    });
                    
                    
                    
                }];
                
            }else{
                //
                //MiniPosSDKDownPro();
                [[NDlMPosPay shardNDlMPosPay] didMiniPosSDKDownPro];
                [ [ UIApplication sharedApplication] setIdleTimerDisabled:YES ] ;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                    //DownThread((__bridge void*)cav,updateFiles);
                    [[NDlMPosPay shardNDlMPosPay] didProjFileDownThread:updateFiles ];
                    [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [cav dismiss];
                    });
                    
                });
                
                [self.miniPosManagerDelegate needDownloadFromWebAndTransmitToPos:@"更新完成"
                    errorType:NDMPOSK_MANAGER_VERSIONUPDATED_TO_POS_OK];
            }
            
        }];
        
    }else{
        
        //[self showTipView:@"您的软件是最新版本"];
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadFromWebAndTransmitToPos:errorType:)]){
            [self.miniPosManagerDelegate needDownloadFromWebAndTransmitToPos:@"您的软件是最新版本"
                 errorType:NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_ISNew];
        }
    }
    
}

- (void)download:(NSString *)fileName CompletionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success{
    
    if (fileName ==nil) {
        return;
    }
    
    NSString *baseURLString = [NSString stringWithFormat:@"http://120.24.213.123/app/%@",fileName];
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
        //需要处理,LiuJQ
        [cav updateProgress:progress];
        [cav updateTitle:[NSString stringWithFormat:@"正在下载%@",fileName]];
        
        
    }];
    
    [operation setCompletionBlockWithSuccess:success failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //-(void)needDownloadFromWebAndTransmitToPos:( NSString*)result
    //errorType:(VerisonUpdatedFromWebAndTransmitToPos)errorType;
        //
        if ([self.miniPosManagerDelegate respondsToSelector:@selector(needDownloadFromWebAndTransmitToPos:errorType:)]){
            [self.miniPosManagerDelegate needDownloadFromWebAndTransmitToPos:@"failure"
                         errorType:NDMPOSK_MANAGER_VERSIONUPDATED_DOWN_ERROR];
        }
        NSLog(@"failure");
    }];
    
    [operation start];
    NSLog(@"download,%@",fileName);
    
}

-(void)login:(NSString*)phoneNo password:(NSString*)password bSignedIn:(BOOL)bSignedIn{
    [[NSUserDefaults standardUserDefaults] setObject:phoneNo forKey:kLoginPhoneNo];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:KPassword];
    [[NSUserDefaults standardUserDefaults] setBool:bSignedIn forKey:kHasSignedIn];
    [[NSUserDefaults standardUserDefaults] synchronize];

}





@end

