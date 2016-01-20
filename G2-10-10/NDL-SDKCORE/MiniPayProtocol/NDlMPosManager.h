//
//  NDlMPosManager.h
//  GITestDemo
//
//  Created by NDlan on 12/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiniPosSDK.h"
#import "BLEDriver.h"
#import "NDlMPosManagerDelegate.h"
#import "NDlMPosModel.h"
#import "VerifyParamsSuccessResult.h"
#import "SessionCodeResult.h"


@interface NDlMPosManager : NSObject


@property (assign, nonatomic) MiniPosSDKSessionType sessionType;
@property (assign, nonatomic) MiniPosSDKSessionError responceCode;
@property (strong, nonatomic) NSMutableString *codeString;
@property (strong, nonatomic) NSMutableString *displayString;


@property (copy, nonatomic) NSString *statusStr;

@property (nonatomic, assign) BOOL isFirstGetVersionInfo;

@property (strong, nonatomic) id<NDlMPosManagerDelegate> miniPosManagerDelegate;

@property (strong, nonatomic) SessionCodeResult *sessionCodeResult;

+ (NDlMPosManager *)shardNDlMPosManager;

//SDK初始化完成基本信息配置
- (void)initConfigureForBLESDK;
//注册代理
- (void) initMiniPosSDKAddDelegate;
//删除代理
- (void) removeMiniPosSDKDelegate;


//内部使用方法
-(void)deviceStatus;
/*
static void MiniPosSDKResponce(void *userData,
                               MiniPosSDKSessionType sessionType,
                               MiniPosSDKSessionError responceCode,
                               const char *deviceResponceCode,
                               const char *displayInfo);
 */
-(void)praseMiniPosSDKResponse:(void *)userData
                   sessionType:(MiniPosSDKSessionType)sessionType
responseCode:(MiniPosSDKSessionError)responceCode
deviceResponceCode:(const char *)deviceResponceCode
displayInfo:(const char *)displayInfo;

/**
 *返回设备是否可用
 */

//下载密码
-(NSString *)decryptMainKey:(NSString *)mainKey;


-(void)setPosWithParams:(NSDictionary *)dictionary success:(void (^)())success;

//验证pos端的参数，成功后执行block
- (void) verifyParamsSuccess:(void (^)())success;

- (void)downloadFromWebAndTransmitToPos;

/*
*登陆
*/
-(void)login:(NSString*)phoneNo password:(NSString*)password bSignedIn:(BOOL)bSignedIn;


@end
