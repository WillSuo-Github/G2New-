//
//  VerifyParamsSuccessResult.h
//  GITestDemo
//
//  Created by NDlan on 16/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MiniPosSDK.h"
#import "NDlMPosModel.h"

@interface VerifyParamsSuccessResult : NSObject
//验证参数时显示的信息
@property (nonatomic, strong) NSString* msg;
@property (nonatomic, assign) VerifyParamsSuccessCode step;
@end
