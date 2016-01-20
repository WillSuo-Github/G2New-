//
//  PayType.h
//  G2TestDemo
//
//  Created by lcc on 15/8/11.
//  Copyright (c) 2015年 ws. All rights reserved.
/*
 "cptId":"73fca052-f54f-11e4-af9a-02004c4f4f50",
 "isIncludedSales":"1",
 "isShow":"1",
 "notes":"现金",
 "paymentName":"现金",
 "enableStatus":"1",
 "restId":"72e12515-f54f-11e4-af9a-02004c4f4f50",
 "sysdataType":"0",
 "showSeq":"1",
 "paymentType":"1",
 "subType":"MONEY",
 "money":null,
 "paymentTypeDesc":"现金",
 "enableStatusName":"正常"
 */

#import <Foundation/Foundation.h>

@interface PayType : NSObject

@property (nonatomic, copy) NSString *paymentName;
@property (nonatomic, copy) NSString *cptId;

@property (nonatomic, copy) NSString *paymentType;
@property(copy,nonatomic)NSString *bciDesc;

@end
