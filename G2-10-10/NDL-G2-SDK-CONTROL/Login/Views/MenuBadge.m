//
//  MenuBadge.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//
#define badgeFontSize [UIFont systemFontOfSize:12]
#import "MenuBadge.h"
#import "NDLBusinessConfigure.h"

@implementation MenuBadge



- (void)setBadge:(NSString *)badge{
    
    _badge = [badge copy];
    CGSize titleSize = [badge sizeWithFont:badgeFontSize];
    if (badge.length == 0 || [badge isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"q_ry"] forState:UIControlStateNormal];
        [self setTitle:badge forState:UIControlStateNormal];
    
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
//        [self setBackgroundImage:[UIImage imageNamed:@"q_ry"] forState:UIControlStateNormal];
        [self sizeToFit];
        self.titleLabel.font = badgeFontSize;
        self.userInteractionEnabled = NO;
    }
    return self;
}

@end
