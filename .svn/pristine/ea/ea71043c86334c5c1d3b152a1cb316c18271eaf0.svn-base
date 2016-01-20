//
//  topRG.m
//  G2TestDemo
//
//  Created by lcc on 15/7/29.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "topRG.h"

@implementation topRG

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
- (void)setValuesForKeysWithDictionary:(NSDictionary *)dic{
    
    
    if (dic[@"categoryId"] != nil) {
        self.categoryId = dic[@"categoryId"];
    }else{
        self.categoryId = @"";
    }
    if (dic[@"dsId"] != nil) {
        self.dsId = dic[@"dsId"];
    }else{
        self.dsId = @"";
    }
    
    self.categoryId = dic[@"categoryId"];
    self.categoryName = dic[@"categoryName"];
    self.categoryCode = dic[@"catagoryCode"];
    self.categoryLevel = dic[@"categoryLevel"];
    self.parentCategoryId = dic[@"parentCategoryId"];
    self.parentDishesCategory = dic[@"parentDishesCategory"];
    self.foreignName = dic[@"foreignName"];
    self.restId = dic[@"restId"];
    self.showSeq = dic[@"showSeq"];
    self.sysdataType = dic[@"sysdataType"];
    self.enableStatus = dic[@"enableStatus"];
    self.dishAndSetDiv = dic[@"dishAndSetDiv"];
    self.enableStatusDesc = dic[@"enableStatusDesc"];
    self.categoryLevelDesc = dic[@"categoryLevelDesc"];
    
}
@end
