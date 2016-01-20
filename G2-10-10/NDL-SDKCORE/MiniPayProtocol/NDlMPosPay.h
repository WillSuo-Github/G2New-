//
//  NDlMPosPay.h
//  GITestDemo
//
//  Created by NDlan on 17/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "NDlMPosManager.h"
#import "NDlMPosCoreSDK.h"
@interface NDlMPosPay : NDlMPosManager

//@property (strong, nonatomic) id<NDlMPosManagerDelegate> miniPosManagerDelegate;


+ (NDlMPosPay *)shardNDlMPosPay;

-(void) didMiniPosSDKDownPro;
-(void) didProjFileDownThread:(NSArray*) updateFiles;

//获取终端信息
-(NSString*)didObtainSnNo;

-(NSString*)didObtainTerminalNo;

-(NSString*)didObtainMerchantNo;

//签到
- (void)siginAction:(NSString*)phoneNo password:(NSString*)password ;


//登录
-(void)loginActionWithPhoneNo:(NSString *)phoneNo andPassword:(NSString *)password;



//刷卡消费
-(void)payWithCreditCard:(NSString*)cashText;
@end
