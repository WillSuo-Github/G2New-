//
//  DeskState.h
//  G2TestDemo
//
//  Created by lcc on 15/7/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//
/*
 {
 seat = 8;
	isHasTableOrder = 0;
	tabId = ff8080814d40a972014d894211290027;
	isAtOrderExpireTime = 0;
	orderStatus = 已下单;
	billId = 402881024fa785d1014faaa2eaa3008a;
	dinnerStatus = 2;
	tabNo = 002;
	waiterId = <null>;
	saleManId = <null>;
	restId = 72e12515-f54f-11e4-af9a-02004c4f4f50;
	areaId = 73dcdc9a-f54f-11e4-af9a-02004c4f4f50;
	showSeq = 0;
	isAtOrderLockTime = 0;
	peopleCount = 0;
	tabName = 03;
	qrCodeImg = <null>;
	isEnable = <null>;
	isAtOrderWarnTime = 0;
	tableOrderNo = 1509080009;
	createTime = <null>;
	comment = ;
	isChedan = 0;
	openTableTime = 09:47;
 }
 
 */
#import <Foundation/Foundation.h>

@interface DeskState : NSObject<NSCoding,NSCopying>


@property (nonatomic, copy) NSString *dinnerStatus;

@property (nonatomic, copy) NSString *openTableTime;


@property (nonatomic, copy) NSString *tabId;

@property (nonatomic, copy) NSString *tabNo;

@property (nonatomic, copy) NSString *areaId;

@property (nonatomic, copy) NSString *isChedan;

@property (nonatomic, copy) NSString *tabName;

@property (nonatomic, copy) NSString *billId;

@property (nonatomic, copy) NSString *seat;

@property (nonatomic,copy) NSString *minSeat;

@property (nonatomic, copy) NSString *peopleCount;

@property (nonatomic, copy) NSString *totalPrice;

@property (nonatomic,copy)  NSString *billNo;





@end



