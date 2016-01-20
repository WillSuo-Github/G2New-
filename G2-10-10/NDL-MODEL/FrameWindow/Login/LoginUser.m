//
//  LoginUser.m
//  G2TestDemo
//
//  Created by NDlan on 6/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "LoginUser.h"

@implementation LoginUser

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"用户信息\t%@ \t用户标示: %ld", _username,(long)_userId];
}
@end
