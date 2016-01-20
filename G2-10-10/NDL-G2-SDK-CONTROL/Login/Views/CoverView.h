//
//  CoverView.h
//  G2TestDemo
//
//  Created by lcc on 15/7/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoverView;
@protocol CoverViewDelegate <NSObject>

- (void)coverViewChick:(CoverView *)coverView;

@end

@interface CoverView : UIView

@property (nonatomic, weak)UIView *contentView;
@property (nonatomic, weak) id<CoverViewDelegate> delegate;

+ (instancetype)showWithRect:(CGRect)rect;

//+ (void)hide;
@end
