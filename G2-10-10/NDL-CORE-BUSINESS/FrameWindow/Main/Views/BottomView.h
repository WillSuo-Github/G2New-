//
//  BottomView.h
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BottomView;
@protocol BottomViewDelegate <NSObject>

@optional
- (void)BottomViewDidChick:(BottomView *)bottomView withButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr;

@end

@interface BottomView : UIView

@property (nonatomic, weak) id<BottomViewDelegate> delegate;
@property (strong,nonatomic) NSArray *countStr;
-(instancetype)initWithArr :(NSArray *)arr;
@end
