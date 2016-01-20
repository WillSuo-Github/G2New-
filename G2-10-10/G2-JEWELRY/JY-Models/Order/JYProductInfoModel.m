//
//  JYShangPinXinXiModel.m
//  G2TestDemo
//
//  Created by tencrwin on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYProductInfoModel.h"

@implementation JYProductInfoModel


- (instancetype)init {
    if ((self = [super init]) != nil) {
        //
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

-(NSString *)description

{
    return [NSString stringWithFormat:@"商品信息，商品ID: %@ 名称: %@ 店ID：%@",
            self.proId,self.name,self.shopId];
    
}

@end
