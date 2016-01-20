//
//  ShuJuPG.m
//  G2TestDemo
//
//  Created by ws on 15/9/11.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ShuJuPG.h"

@implementation ShuJuPG

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary *)dic{
    _caiMing = dic[@"disheName"];
    _shuLiang = [NSString stringWithFormat:@"%@",dic[@"total"]];
}



@end
