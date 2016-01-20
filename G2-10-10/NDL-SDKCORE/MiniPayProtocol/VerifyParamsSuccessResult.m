//
//  VerifyParamsSuccessResult.m
//  GITestDemo
//
//  Created by NDlan on 16/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "VerifyParamsSuccessResult.h"

@implementation VerifyParamsSuccessResult

- (id)copyWithZone:(NSZone *)zone {
    return self;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"环节信息:%ld， 提示信息:%@",
            (long)self.step,self.msg];
}
@end
