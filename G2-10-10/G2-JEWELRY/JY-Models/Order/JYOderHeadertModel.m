//
//  JYOderListModel.m
//  G2TestDemo
//
//  Created by tencrwin on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYOderHeadertModel.h"

@implementation JYOderHeadertModel

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
    return [NSString stringWithFormat:@"订单头信息，单号: %@ 店号: %@ 金额：%@",
            self.salesId,self.shopId,self.paySum];
    
}
@end
