//
//  newBill.h
//  G2TestDemo
//
//  Created by lcc on 15/8/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface newBill : NSObject

@property (nonatomic, copy) NSString *billType;
@property (nonatomic, copy) NSString *billStatus;
/**
 *  疑似订单的总价格
 */
@property (nonatomic, copy) NSString *oriCost;

/**
 *  餐桌名字
 */
@property (nonatomic, copy) NSString *tabNo;
/**
 *  服务员名字
 */
@property (nonatomic, copy) NSString *waiterName;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createTime;
/**
 *  就餐人数
 */
@property (nonatomic, copy) NSString *peopleNum;
/**
 *  订单编号
 */
@property (nonatomic, copy) NSString *billNo;
/**
 *  订单id
 */
@property (nonatomic, copy) NSString *billId;
/**
 *  餐台编号
 */
@property (nonatomic, copy) NSString *tableId;
@end
