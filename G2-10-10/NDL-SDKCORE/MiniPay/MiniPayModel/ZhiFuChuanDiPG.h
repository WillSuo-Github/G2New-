//
//  ZhiFuChuanDiPG.h
//  G2TestDemo
//
//  Created by ws on 15/11/4.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhiFuChuanDiPG : NSObject

/**
 *  订单编号
 */
@property (nonatomic, copy) NSString *billID;

/**
 *  支付类型
 */
@property (nonatomic, copy) NSString *PayType;

/**
 *  正常消费金额
 */
@property (nonatomic, copy) NSString *count;

@property (strong,nonatomic) NSString *remainChangeRMB;



/**
 *  跳转来源
 */
@property (nonatomic, copy) NSString *whereFrom;

/**
 *  订单编号
 */
@property (nonatomic, copy) NSString *orderNo;

/**
 *  支付类型ID
 */
@property (nonatomic, copy) NSString *cptID;


/**
 *  桌台ID
 */
@property (nonatomic, copy) NSString *tabID;

/**
 *  server 支付类型
 */
@property (nonatomic, copy) NSString *paymentType;


/**
 *  会员验证字段
 */
@property (strong,nonatomic) NSString *idIdentifyStr;

@property (strong,nonatomic)NSString *VIPforwardUrl;


@property(strong,nonatomic)NSString *erweimaStr;

@property (strong,nonatomic)NSString *QRCodeValueStr;
/**
 *  out_trade_no;
 */
@property(strong,nonatomic)NSString *VIPRechargeOutStr;


@property(strong,nonatomic)NSString *RealCount;

@property(strong,nonatomic)NSString *amountPledges;



@end
