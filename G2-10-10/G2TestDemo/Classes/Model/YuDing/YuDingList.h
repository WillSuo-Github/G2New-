//
//  YuDingList.h
//  G2TestDemo
//
//  Created by lcc on 15/8/24.
//  Copyright (c) 2015年 ws. All rights reserved.
/*
 
 orderNo 订单id
 tabNo  餐台id
 orderPeopleName  预订人
 telphone  手机号
 peopleNum  就餐人数
 orderTime  预定时间
 prepay   预定押金
 orderWayDesc   预定来源
 orderStatusDesc  订单状态
 isStatus  是否已经点餐
 
 */

#import <Foundation/Foundation.h>

@interface YuDingList : NSObject
/**
 *  订单账号
 */
@property (nonatomic, copy) NSString *orderNo;
/**
 *  餐台id
 */
@property (nonatomic, copy) NSString *tabNo;
/**
 *  预订人
 */
@property (nonatomic, copy) NSString *orderPeopleName;
/**
 *  手机号
 */
@property (nonatomic, copy) NSString *telphone;
/**
 *  就餐人数
 */
@property (nonatomic, copy) NSString *peopleNum;
/**
 *  预定时间
 */
@property (nonatomic, copy) NSString *orderTime;
/**
 *  预定押金
 */
@property (nonatomic, copy) NSString *prepay;
/**
 *  预定来源
 */
@property (nonatomic, copy) NSString *orderWayDesc;
/**
 *  订单状态
 */
@property (nonatomic, copy) NSString *orderStatusDesc;
/**
 *  是否已经点餐
 */
@property (nonatomic, copy) NSString *isStatus;

/**
 *  订单ID
 */
@property(copy,nonatomic)NSString *orderId;

///
@property (copy,nonatomic)NSString * tabId;
@end
