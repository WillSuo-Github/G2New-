//
//  ZhuanTaiViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuanTaiViewController;
@protocol zhuantaiDelegate <NSObject>

@optional
- (void)zhuantaiViewDidDismissWith:(ZhuanTaiViewController *)zhuantaiVc;

@end

@interface ZhuanTaiViewController : UIViewController


@property (nonatomic, weak) id<zhuantaiDelegate> delegate;

@end
