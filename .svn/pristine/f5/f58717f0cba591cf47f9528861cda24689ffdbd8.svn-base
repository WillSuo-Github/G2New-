//
//  MainViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "Singleton.h"
#import "BaseViewController.h"
#import "CoverView.h"
#import "DaYangAlertViewController.h"

#import "UsedViewController.h"
#import "HardwareInterface.h"

#import "NDLBaseOrderViewController.h"
#import "NDLOrderDelegate.h"

@class BottomView;
@interface MainViewController : BaseViewController<BottomViewDelegate,MenuViewControllerDelegate,CoverViewDelegate,DaYangAlertViewControllerDelegate,NDLFrameWindowDelegate>

SingletonH(MainView)

@property (nonatomic, assign) BOOL isHidden;

@property (nonatomic, strong) MenuViewController *menuVC;

@property (nonatomic, strong) UsedViewController *usedVc;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIViewController *tmpVc;
@property (nonatomic, strong) CoverView *cover;
@property(strong,nonatomic)MainViewController *mainVC;

@property (strong, nonatomic)UIView *dayangBackView;

@property (strong, nonatomic)DaYangAlertViewController *dayangAlertVc;
@property(strong,nonatomic)HardwareInterface *hardwareInterface;
@property (strong,nonatomic)BottomView *bottomView;

@property (nonatomic, strong) id<NDLOrderDelegate> OrderVc;

@property (weak, nonatomic) id<NDLFrameWindowDelegate> frameWindowDelegate;

-(void)setUpMenuView;

-(void)setUporderVc;

- (void)MainViewInsertSubviewWith:(UIViewController *)ViewVC;


- (void)BottomViewDidChick:(BottomView *)bottomView withButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr;
@end
