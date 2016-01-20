//
//  VipShow.h
//  G2TestDemo
//
//  Created by tencrwin on 15/11/27.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipShow : NSObject
//s手机
@property (copy,nonatomic) NSString *mobile;
//余额

@property (copy,nonatomic) NSString *balance;
//类型
@property (copy,nonatomic) NSString *membershipCardClassName;
//姓名
@property (copy,nonatomic) NSString *name;
//卡号
@property (copy,nonatomic) NSString *cardNo;
@end
