//
//  CaiPG.h
//  G2TestDemo
//
//  Created by lcc on 15/7/29.
//  Copyright (c) 2015年 ws. All rights reserved.
//
/*
 "dishesId":"ff8080814dbc7c38014dbd5637bc0012",
 "dashesStyleIdArray":null,
 "dishesCode":"002",
 "dishesName":"夫妻肺片",
 "foreignName":null,
 "isAddMinCharge":null,
 "isOnsale":null,
 "isRecommend":null,
 "isRulingPrice":"0",
 "isSpecialty":null,
 "isStopSell":null,
 "isTakeout":"1",
 "isInRestUse":null,
 "materialIdArray":null,
 "reallyPrice":null,
 "specialPrice":null,
 "memberPrice":null,
 "notes":null,
 "price":35,
 "priceFormat":35,
 "pungentLevel":null,
 "restId":null,
 "saleNum":0,
 "dsUnitNum":null,
 "showSeq":null,
 "showSeqTakeout":null,
 "showSeqRecommend":null,
 "tasteIdArray":null,
 "totalScore":null,
 "estimate":null,
 "categoryId":"",
 "rootCategoryId":null,
 "categoryCode":"",
 "dishAndSetDiv":"1",
 "unitId":null,
 "dishesUnitName":"份",
 "dishesSetPics":null,
 "isUserDefined":null,
 "serviceCommission":null,
 "dsDishesId":null,
 "saleCommission":null,
 "praise":null,
 "tread":null,
 "selfDishId":null,
 "selfDishSaleNum":null,
 "discountPriceDesc":null,
 "discountType":null,
 "isSpecial":null,
 "isOrdered":"0",
 "picUrl":null,
 "isAddMinChargeDesc":"未知",
 "dishesPicUrl200x200":null,
 "dishesPicUrl1024x1024":null,
 "isOnsaleDesc":"未知",
 "isRecommendDesc":"未知",
 "isRulingPriceDesc":"是",
 "isSpecialtyDesc":"未知",
 "isStopSellDesc":"未知",
 "isTakeoutDesc":"否",
 "isInRestUseDesc":"未知",
 "dishesPicUrl":null
 
 
 */

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface CaiPG : NSObject

@property (nonatomic, copy) NSString *dishesCode;

@property (nonatomic, copy) NSString *dishesName;
/**
 *  菜品的价格
 */
//@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *oriCostStr;

@property (nonatomic, copy) NSString *picUrl;
/**
 *  套餐图片url
 */
@property (nonatomic, copy) NSString *picUrlSet;

@property (nonatomic, copy) NSString *isRulingPrice;


@property (nonatomic, copy) NSString *unitPrice;

@property (nonatomic, copy) NSString *dishesId;

@property (nonatomic, copy) NSString *dishAndSetDiv;

/**
 *  沽清数量
 */
@property (nonatomic, copy) NSString *estimate;
/**
 *  套餐的菜品份数
 */
@property (nonatomic, copy) NSString *unitNum;
/**
 *  套餐的菜品dsDishesId
 */
@property (nonatomic, copy) NSString *dsDishesId;
/**
 *  套餐的菜品名字
 */
@property (nonatomic, copy) NSString *unitName;
/**
 *  用于判断是否是套餐
 */
@property (nonatomic, copy) NSString *isDishesSet;
/**
 *  套餐菜品
 */
@property (nonatomic, strong) NSArray *dishesSetDesc;
/**
 *  判断是否套餐菜品
 */
@property (nonatomic, copy) NSString *isTaoCanCaiPin;
/**
 *  套餐ID
 */
@property (nonatomic, copy) NSString *taocanID;
/**
 *  判断cell的颜色是否是红色
 */
@property (nonatomic, copy) NSString *isRed;
/**
 *  上传菜品的时候记录菜品的数量
 */
@property (nonatomic, copy) NSString *unitNumStr;
////WHC
@property (nonatomic,copy) NSString *haveJiKou;
@property (nonatomic,copy) NSString *bdId;

@end
