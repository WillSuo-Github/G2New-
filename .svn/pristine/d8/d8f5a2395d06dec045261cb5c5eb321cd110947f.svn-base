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
@class BottomView;
@interface MainViewController : BaseViewController

SingletonH(MainView)

@property (nonatomic, assign) BOOL isHidden;

@property (nonatomic, strong) MenuViewController *menuVC;


- (void)MainViewInsertSubviewWith:(UIViewController *)ViewVC;


- (void)BottomViewDidChick:(BottomView *)bottomView withButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr;
@end
