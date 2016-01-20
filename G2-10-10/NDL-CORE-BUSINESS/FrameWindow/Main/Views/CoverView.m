//
//  CoverView.m
//  G2TestDemo
//
//  Created by lcc on 15/7/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "CoverView.h"
#import "NDLBusinessConfigure.h"

@interface CoverView ()

@property (nonatomic, strong) CoverView *cover;

@end

@implementation CoverView

+ (instancetype)showWithRect:(CGRect)rect{
    
    CoverView *cover = [[CoverView alloc] initWithFrame:rect];
//    cover.backgroundColor = [UIColor redColor];
    [kKeyWindow addSubview:cover];
    return cover;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self removeFromSuperview];
    
    if ([_delegate respondsToSelector:@selector(coverViewChick:)]) {
        [_delegate coverViewChick:self];
    }
}

//+ (void)hide{
//    
//    self.
//}

@end
