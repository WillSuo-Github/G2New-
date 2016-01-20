//
//  JYMember.m
//  G2TestDemo
//
//  Created by NDlan on 7/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYMember.h"

@implementation JYMember

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
    return [NSString stringWithFormat:@"会员信息，名称: %@ 电话: %@",
            self.name,self.phone];
    
}
@end
