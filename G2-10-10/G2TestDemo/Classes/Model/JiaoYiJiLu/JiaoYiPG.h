//
//  JiaoYiPG.h
//  G2TestDemo
//
//  Created by lcc on 15/8/19.
//  Copyright (c) 2015年 ws. All rights reserved.
/*
 billNo
 tabNo
 cashierName 开单
 salesmanName 收银
 
payTime 结账时间
 billTime 开单时间
 
 payableCost  应收金额
 realCost 实收金额
 
 billStatus 状态
 1 ：未下单
 2 ：已下单
 3 ：已结账
 4 ：反结账
 8 ：撤单
 9 ：部分下单
 10：已并台
 11：派送中
 */

#import <Foundation/Foundation.h>

@interface JiaoYiPG : NSObject
/**
 *  订单id
 */
@property (nonatomic, copy) NSString *billId;

/**
 *  订单类型
 */
@property (nonatomic,copy)NSString *billType;
/**
 *  订单号
 */
@property (nonatomic, copy) NSString *billNo;
/**
 *  餐桌编号
 */
@property (nonatomic, copy) NSString *tabNo;
/**
 *  开单人
 */
@property (nonatomic, copy) NSString *createEmployeeName;
/**
 *  收银员
 */
@property (nonatomic, copy) NSString *cashierEmployeeName;
/**
 *  结账时间
 */
@property (nonatomic, copy) NSString *payTime;
/**
 *  开单时间
 */
@property (nonatomic, copy) NSString *billTime;
/**
 *  应收金额
 */
@property (nonatomic, copy) NSString *oriCost;
/**
 *  实收金额
 */

@property (nonatomic,copy) NSString *billMoney;

@property (nonatomic, copy) NSString *realCost;
/**
 *  订单状态
 */
@property (nonatomic, copy) NSString *billStatusDesc;
@end
