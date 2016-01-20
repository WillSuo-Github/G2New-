//
//  DetailVipViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/4.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipShow.h"
#import "BaseViewController.h"
@class DetailVipViewController;
@protocol detailVipViewControllerDelegate <NSObject>

@optional

-(void)huiYunaGuanLiQuXiao:(DetailVipViewController *)quxiao;

@end

@interface DetailVipViewController : BaseViewController

@property (nonatomic, copy) NSString *mcid;
@property (nonatomic,copy) NSString *shoujiNO;
@property (copy,nonatomic) NSString *yue;
@property (copy,nonatomic) NSString *jifen;

//蓝牙接收信息
@property (strong,nonatomic) VipShow *vip;
@property (nonatomic,weak)id <detailVipViewControllerDelegate> delegate;

@end
