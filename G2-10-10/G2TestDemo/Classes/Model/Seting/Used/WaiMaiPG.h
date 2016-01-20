//
//  WaiMaiPG.h
//  G2TestDemo
//
//  Created by ws on 15/9/23.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WaiMaiPG : NSObject
/**
 *  contactName 联系人
    mobile  联系电话
    totalCost 金额
    sendTime 配送时间
    sendAddress 配送地址
 
 */
@property (nonatomic, copy) NSString *contactName;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *totalCost;
@property (nonatomic, copy) NSString *sendTime;
@property (nonatomic, copy) NSString *bianhao;
@property (nonatomic, copy) NSString *takesNumber;
@property (nonatomic,copy) NSString *minuteDiff;


@property (nonatomic, copy) NSString *sendAddress;
/**
 *  订单id
 */
@property (nonatomic, copy) NSString *billId;
///**
// *  Tid
// */
//@property (nonatomic, copy) NSString *tId;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
