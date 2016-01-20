//
//  topRG.h
//  G2TestDemo
//
//  Created by lcc on 15/7/29.
//  Copyright (c) 2015年 ws. All rights reserved.
/*
 "categoryId":"72e1275a-f54f-11e4-af9a-02004c4f4f50",
 "categoryCode":"recai",
 "categoryLevel":"1",
 "parentCategoryId":null,
 "parentDishesCategory":null,
 "categoryName":"热菜",
 "foreignName":"recai",
 "restId":"72e12515-f54f-11e4-af9a-02004c4f4f50",
 "showSeq":1,
 "sysdataType":"0",
 "enableStatus":"1",
 "dishAndSetDiv":null,
 "enableStatusDesc":"正常",
 "categoryLevelDesc":"一级菜类"
 */

#import <Foundation/Foundation.h>

@interface topRG : NSObject

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *dsId;

@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *categoryCode;
@property (nonatomic, copy) NSString *categoryLevel;
@property (nonatomic, copy) NSString *parentCategoryId;
@property (nonatomic, copy) NSString *parentDishesCategory;
@property (nonatomic, copy) NSString *foreignName;
@property (nonatomic, copy) NSString *restId;
@property (nonatomic, copy) NSString *showSeq;
@property (nonatomic, copy) NSString *sysdataType;
@property (nonatomic, copy) NSString *enableStatus;
@property (nonatomic, copy) NSString *dishAndSetDiv;
@property (nonatomic, copy) NSString *enableStatusDesc;
@property (nonatomic, copy) NSString *categoryLevelDesc;


//@property (nonatomic, copy) NSString *dsld;


- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
