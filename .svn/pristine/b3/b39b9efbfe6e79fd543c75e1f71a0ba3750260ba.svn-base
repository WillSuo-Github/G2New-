//
//  NDlMPosCoreSDK.h
//  GITestDemo
//
//  Created by NDlan on 18/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NDlMPosManager.h"
#import "MiniPosSDK.h"
#import "BLEDriver.h"
@interface NDlMPosCoreSDK : NDlMPosManager

+ (NDlMPosCoreSDK *)shardNDlMPosCoreSDK;

-(void)payStatus:(MiniPosSDKSessionType)sessionType responceCode:(MiniPosSDKSessionError)responceCode;



//刷卡接口
- (void)swipeWithCreditCard:(NSString *)amountText
                       type:(NSString *)type success:(void(^)(NSDictionary *dict))success fail:(void(^)(NSString *failMs))fail;

//签到
-(BOOL )loginInMiniPos:(NSString *) result success:(void(^)(SessionCodeResult *result))success fail:(void(^)(NSString *failMs))fail;

//参数设置
-(NSInteger)mPosSDKPram:(NSString *)syscode paramname:(NSString *)paramname paramvalue:(NSString *)paramvalue;


//设备状态，即蓝牙是否可用
-(BOOL)deviceIsConnected;

//签到(新)
-(void)signInMPosSuceess:(void (^)())success Fail:(void(^)(SessionCodeResult *result))fail;





@end
