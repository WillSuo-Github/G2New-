//
//  ZhiFuBaoZhiFuPG.h
//  G2TestDemo
//
//  Created by lcc on 15/9/14.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhiFuBaoZhiFuPG : NSObject
/**
 *  商户订单号
 */
@property (nonatomic, copy) NSString *out_trade_no;
/**
 *  支付场景
 */
@property (nonatomic, copy) NSString *scene;
/**
 *  支付授权码
 */
@property (nonatomic, copy) NSString *auth_code;
/**
 *  订单总金额
 */
@property (nonatomic, copy) NSString *total_amount;
/**
 *  订单标题
 */
@property (nonatomic, copy) NSString *subject;


@property (nonatomic, copy) NSString *ios_billNo;
/**
 *  支付类型ID
 */
@property (nonatomic, copy) NSString *cptId;
@end
