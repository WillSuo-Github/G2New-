//
//  NDlMPosManagerDelegate.h
//  GITestDemo
//
//  Created by NDlan on 13/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDlMPosModel.h"
#import "VerifyParamsSuccessResult.h"
#import "SessionCodeResult.h"

@protocol NDlMPosManagerDelegate <NSObject>



@optional

/**
 *-(void)setPosWithParams:(NSDictionary *)dictionary success:(void (^)())success;
 *设置参数的回调方法，在Demo中目前的作用是隐藏进度条
 */
- (void)needSetPosWithParams:(NSDictionary *)result;

/**
 *-(void)praseMiniPosSDKResponse:(void *)userData
 *  sessionType:(MiniPosSDKSessionType)sessionType
 *  responseCode:(MiniPosSDKSessionError)responceCode
 *  deviceResponceCode:(const char *)deviceResponceCode
 *  displayInfo:(const char *)displayInfo;
 *  解析时的回调
 *self.sessionType==SESSION_POS_GET_DEVICE_ID
 */
 - (void)needMiniPosSDKResponse:(SessionCodeResult *)result;


/**
 *- (void) verifyParamsSuccess:(void (^)())success;
 *设置回调方法，在视图中提供显示信息
 */
- (void)needVerifyParamsSuccess:(VerifyParamsSuccessResult *)result;

/**
 *initMiniPosSDKAddDelegate回调方法
 */
- (void)needInitMiniPosSDKAddDelegate:( BOOL)result;

#pragma mark--版本信息下载
/**
 *downloadWebVersionFile，下载版本信息
 */
-(void)needDownloadWebVersionFile:( BOOL)result;

/**
 *downloadWebVersionFile，下载版本信息
 */
-(void)needDownloadWebVersionInfo:( NSString*)result bNewVersion:(BOOL)bVersion;

/**
 *下载新版本并更新到Pos
 *- (void)downloadFromWebAndTransmitToPos;
 */
-(void)needDownloadFromWebAndTransmitToPos:( NSString*)result
                                      errorType:(VerisonUpdatedFromWebAndTransmitToPos)errorType;
//-(void)recvMiniPosSDKStatus;
#pragma mark -下面是身份认证、登陆信息

/**
 *- (void)siginAction:(NSString*)phoneNo password:(NSString*)password ;
 *errorType:0登陆正常,1手机或密码不正确,2,其它异常信息,3网络或服务器异常
 */

-(void)needSiginAction:(NSString *)result errorType:(LoginAndSignResultType)code sessionCodeResult:(SessionCodeResult *)result;

/**
 *-(void)payWithCreditCard:(NSString*)cashText;
 */
-(void)needPayWithCreditCard:(NSString *)result errorType:(PayWithCreditCardType)code;


-(void)needLoginAction:(NSString *)result errorType:(LoginResultType)code;

@end
