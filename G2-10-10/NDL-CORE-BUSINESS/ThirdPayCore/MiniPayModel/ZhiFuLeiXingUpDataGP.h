//
//  ZhiFuLeiXingUpDataGP.h
//  G2TestDemo
//
//  Created by lcc on 15/9/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhiFuLeiXingUpDataGP : NSObject
/**
 *  账单id
 */
@property (nonatomic, copy) NSString *billId;
/**
 *  支付方式id
 */
@property (nonatomic, copy) NSString *cptId;
/**
 *  账单类型
 */
@property (nonatomic, copy) NSString *paymentType;
/**
 *  折扣类型id
 */
@property (nonatomic, copy) NSString *dbpId;
/**
 *    金额
 */
@property (nonatomic, copy) NSString *money;
/**
 *  是否已经支付
 */
@property (nonatomic, copy) NSString *isSuc;
@end
