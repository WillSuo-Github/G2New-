//
//  NDlMPosCoreSDK.m
//  GITestDemo
//
//  Created by NDlan on 18/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "NDlMPosCoreSDK.h"
#import "MiniPosSDK.h"
#import "UIUtils.h"
#import "Common.h"
#import "BleManager.h"
#include "NDlPrint.h"

int _type;

@interface NDlMPosCoreSDK (){
    
    //刷卡回调
    void (^startSwipeSuccess)(NSDictionary *dict);
    void(^startSwipeFail)(NSString *failMs);
    
    //签到回调
    void (^logInMPosSuceess)();
    void (^logInMPosFail)(SessionCodeResult *result);
    
    
    void (^loginInMPosSuccess)(SessionCodeResult *result);
    void (^loginInMPosFail)(NSString *failMs);
    
    void (^ConnectSuccess)();
    void (^ConnectFail)(NSString *failMs);
    
    void (^GetSnSuccess)(NSString *sn);
    void(^GetSnFail)(NSString *failMs);
    
    void(^tmkSuccess)(NSString *successMs);
    void(^tmkFail)(NSString *failMs);
    
    void(^tdkSuccess)(NSString *successMs);
    void(^tdkFail)(NSString *failMs);
    
    
    
    void(^startInputSuccess)(NSString *successMs);
    void(^startInputFail)(NSString *failMs);
    
    void(^startPBOCSuccess)(NSString *successMs);
    void(^startPBOCFail)(NSString *failMs);
    
    void(^calMacSuccess)(NSString *successMs);
    void(^calMacFail)(NSString *failMs);
    
    void(^endPBOCSuccess)(NSString *successMs);
    void(^endPBOCFail)(NSString *failMs);
    
    void(^displayTerSuccess)(NSString *successMs);
    void(^displayTerFail)(NSString *failMs);
    
    void(^resetSuccess)(NSString *successMs);
    void(^resetFail)(NSString *failMs);
    
    void(^stopBluthSuccess)(NSString *successMs);
    void(^stopBluthFail)(NSString *failMs);
    
    //    void(^startGetSuccess)(NSString *successMs);
    //    void(^startGetFail)(NSString *failMs);
    
    void(^startICGetSuccess)(NSString *successMs);
    void(^startICGetFail)(NSString *failMs);
    
    void(^ECLoadSuccess)(NSString *successMs);
    void(^ECLoadFail)(NSString *failMs);
    
    void(^caSuccess)(NSString *successMs);
    void(^caFail)(NSString *failMs);
    
    
    void(^cancleSwip)(NSString *successMs);
    //SDKResponceFunc* superResponce;
    
}
@end

@implementation NDlMPosCoreSDK

static BleManager *bleManager;
static NDlMPosCoreSDK *mPosCoreSDK;

+ (NDlMPosCoreSDK *)shardNDlMPosCoreSDK{
    
    if (mPosCoreSDK==nil) {
        mPosCoreSDK=[[self alloc] init];
  
    }
    return mPosCoreSDK;
}



-(NSInteger)mPosSDKPram:(NSString *)syscode paramname:(NSString *)paramname paramvalue:(NSString *)paramvalue{
    //int success=MiniPosSDKSetParam(const char* syscode, const char* paramname, const char* paramvalue);
    int  suceess= MiniPosSDKSetParam([syscode UTF8String],
                       [UIUtils UTF8_To_GB2312:paramname],
                       [paramvalue UTF8String]);
    return (NSInteger)suceess;
}

-(void)payStatus:(MiniPosSDKSessionType)sessionType responceCode:(MiniPosSDKSessionError)responceCode{
    
    
    if ((int)(self.responceCode) < 0 ) {
        
        return;
    }
    
    NSLog(@"MiniPosSDKResponce sessionType: %d(%@) responceCode: %d(%@)",self.sessionType,[self getSesstionTypeString:self.sessionType],self.responceCode,[self getResponceCodeString:self.responceCode]);
    
    
    SessionCodeResult *result=[SessionCodeResult new];
    result.sessionType=sessionType;
    result.responceCode=responceCode;
    
    if(loginInMPosSuccess){
        if(sessionType==SESSION_POS_LOGIN &&
           responceCode==SESSION_ERROR_ACK){
            SessionCodeResult *result=[SessionCodeResult new];
            result.sessionType=sessionType;
            result.responceCode=responceCode;
            loginInMPosSuccess(0);
        }
    }
    
    
    
    if (responceCode == SESSION_ERROR_ACK) {
        if (sessionType == SESSION_POS_LOGIN) {
            if (logInMPosSuceess) {
                logInMPosSuceess();
            }
            
        }
    
    }else if(responceCode ==SESSION_ERROR_NAK){
        if (sessionType == SESSION_POS_LOGIN) {
            if (logInMPosFail) {
                logInMPosFail(result);
            }
       
        }
    }
}
- (BOOL)readyBLEConnect{
    
    if (bleManager.imBT.isConnected) {
        
        NSLog(@"NDlMPosCoreSDK DeviceState:设备已经连接");
        return YES;
    }else{
        NSLog(@"NDlMPosCoreSDK DeviceState:设备已断开");
    }
    
    return NO;
}

-(void)signInMPosSuceess:(void (^)())success Fail:(void(^)(SessionCodeResult *result))fail{
    
    dispatch_async(dispatch_get_main_queue(), ^{
         MiniPosSDKPosLogin();
    });
    
   
    logInMPosSuceess = success;
    logInMPosFail = fail;
    
}



-(BOOL )loginInMiniPos:(NSString *) result success:(void(^)(SessionCodeResult *result))success fail:(void(^)(NSString *failMs))fail{
    //打印测试

    if(MiniPosSDKPosLogin()>=0){
        if (success) {
            loginInMPosSuccess=success;
        }
        return YES;
    }else{
        if (fail) {
            loginInMPosFail=fail;
        }
        return NO;
    }
    //[self removeMiniPosSDKDelegate];
}
//
- (void)swipeWithCreditCard:(NSString *)amountText
                       type:(NSString *)type success:(void(^)(NSDictionary *dict))success fail:(void(^)(NSString *failMs))fail{
    [self addMininPosSDKDelagate];
    int amount  = [amountText doubleValue]*100;
    if (success) {
        startSwipeSuccess = success;
    }
    if (fail) {
        startSwipeFail = fail;
    }
    if (amount > 0) {
        
        char buf[20];
        
        sprintf(buf,"%012d",amount);
        
        NSLog(@"amount: %s",buf);
        _type = 1;//设置类型
        //sdk的消费方法，刷卡数据
        MiniPosSDKSaleTradeCMD(buf, NULL,[type UTF8String]);
    }
    [self removeMiniPosSDKDelegate];
}

-(BOOL)deviceIsConnected{
    int ready= DeviceState();
    if (ready==0) {
        return YES;
    }else{
        return NO;
    }
}

-(void)addMininPosSDKDelagate{
    //[[NDlMPosManager shardNDlMPosManager] initMiniPosSDKAddDelegate];
    //MiniPosSDKAddDelegate((__bridge void*)self, MiniPosSDKResponce);
 
}

- (void) removeMiniPosSDKDelegate{
    //MiniPosSDKRemoveDelegate((__bridge void*)self);
    //[[NDlMPosManager shardNDlMPosManager] removeMiniPosSDKDelegate];

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
@end
