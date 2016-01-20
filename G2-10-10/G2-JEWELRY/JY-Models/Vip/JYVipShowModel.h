//
//  JYVipShowModel.h
//  G2TestDemo
//
//  Created by tencrwin on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYVipShowModel : NSObject
//会员信息
//姓名
@property (copy,nonatomic)NSString *name;
//手机
@property (copy,nonatomic)NSString *phone;
//卡号
@property (copy,nonatomic)NSString *cardNo;
//类型
@property (copy,nonatomic)NSString *cardType;
//创建日期
@property (copy,nonatomic)NSString *createTime;
//状态
@property (copy,nonatomic)NSString *cardStatus;
//积分
@property (copy,nonatomic)NSString *consumptionPoints;
//余额
@property (copy,nonatomic)NSString *mayMoney;

@end
