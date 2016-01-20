//
//  JYOderListModel.h
//  G2TestDemo
//
//  Created by tencrwin on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYOderListModel : NSObject
//订单信息
//订单主建
@property (copy,nonatomic)NSString *salesId;
//订单编号
@property (copy,nonatomic)NSString *salesNo;
//消费时间
@property (copy,nonatomic)NSString *updateTime;
//会员名称
@property (copy,nonatomic)NSString *customerName;
//消费金额
@property (copy,nonatomic)NSString *paySum;
//折扣
@property (copy,nonatomic)NSString *discount;
//时收金额
@property (copy,nonatomic)NSString *afterDiscount;
//支付方式
@property (copy,nonatomic)NSString *payTypeName;
//收银员
@property (copy,nonatomic)NSString *seller;
//店权限
@property (copy,nonatomic)NSString *barPath;
//店ID
@property (copy,nonatomic)NSString *shopId;

@end
