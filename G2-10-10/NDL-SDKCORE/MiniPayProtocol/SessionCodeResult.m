//
//  SessionCodeResult.m
//  GITestDemo
//
//  Created by NDlan on 16/11/15.
//  Copyright © 2015年 Kyson. All rights reserved.
//

#import "SessionCodeResult.h"

@implementation SessionCodeResult

- (instancetype)init {
    if ((self = [super init]) != nil) {
        //实例化数据
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"类型码:%ld,描述:%@,\n状态码:%u 描述:%@\n提示信息:%@",
            (long)self.sessionType,self.sessionTypeText, self.responceCode,self.responceCodeText, self.msg];
}
@end
