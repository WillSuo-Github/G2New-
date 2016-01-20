//
//  MenuBtn.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "MenuBtn.h"
#import "MenuBadge.h"
#import "NDLBusinessConfigure.h"
@interface MenuBtn(){
    
    MenuBadge *_bage;
}

@end



@implementation MenuBtn

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat bageWH = 20;
    CGFloat bageX = self.width - bageWH - 10;
    CGFloat bageY = 10;
    _bage.badge = self.bageNub;
    _bage.frame = CGRectMake(bageX, bageY, bageWH, bageWH);
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        MenuBadge *bage = [[MenuBadge alloc] init];
        _bage = bage;
        [self addSubview:bage];
    }
    return self;
}
@end
