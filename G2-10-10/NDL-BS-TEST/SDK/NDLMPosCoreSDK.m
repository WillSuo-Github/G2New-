//
//  NDLMPosCoreSDK.m
//  G2TestDemo
//
//  Created by wd on 15/12/25.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLMPosCoreSDK.h"

@implementation NDLMPosCoreSDK

static NDLMPosCoreSDK *instance;

+ (NDLMPosCoreSDK *)sharedInstance{
    
    static dispatch_once_t oncePredicate;
    if (instance==nil) {
        dispatch_once(&oncePredicate, ^{
            instance=[[self alloc] init];
//            
//            miniPos.sessionCodeResult=[[SessionCodeResult alloc]init];
//            MiniPosSDKInit();//MiniPosSDK的方法,设置Session状态为SESSION_POS_UNKNOWN
//            MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
        });
        
    }
    return instance;
}


@end
