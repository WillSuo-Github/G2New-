//
//  SetingViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NDLSettingDelegate.h"

#import "NDLSettingManager.h"

@interface SetingViewController : UIViewController <NDLSettingDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shezhi;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong,nonatomic)NSArray *settingMenuArray;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIViewController *tmpViewController;

//视图的变化代理
@property (strong, nonatomic) id<NDLSettingDelegate> settingDelegate;
//@数据的获取实现
@property (strong, nonatomic) NDLSettingManager *settingManager;

-(NSArray *)SetSettingMenu;
-(void)DidSelectMenuIndex:(NSInteger)index;
- (void)SetUpContentViewWithViewController;

-(NSArray *)setSettingMenu:(SetingViewController *)setingViewController;
-(void)didSelectMenuIndex:(UIViewController *)setingViewController index:(NSInteger)index;

@end
