//
//  JYOrderListAllModel.m
//  G2TestDemo
//
//  Created by tencrwin on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYOrderDetailModel.h"

@implementation JYOrderDetailModel : NSObject 

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
    return [NSString stringWithFormat:@"订单信息，单号: %@ 明细: %@ 商品：%@",
            self.salesId,self.itemId,self.productName];
    
}
@end
