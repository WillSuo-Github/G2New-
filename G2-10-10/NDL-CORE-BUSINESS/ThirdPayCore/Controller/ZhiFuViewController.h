//
//  ZhiFuViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/8.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
#import "BaseViewController.h"
#import "ZhiFuCell.h"
#import "ZhiFuChuanDiPG.h"
#import "JYPayManager.h"
#import "NDLThirdPayDataManager.h"


@protocol sendChuandiDleegate <NSObject>

-(void)sendChuanDi:(ZhiFuChuanDiPG *)zhifuW;

@end
@interface ZhiFuViewController : BaseViewController


@property (nonatomic, strong) ZhiFuChuanDiPG *chuandiPG;

@property (nonatomic,copy) NSString *panDuanHiden;
@property (assign,nonatomic) id<sendChuandiDleegate>delegate;
@property (strong,nonatomic) NDLThirdPayDataManager *dataManager;

SingletonH(ZhiFuViewController)

@property (weak, nonatomic) IBOutlet UIView *btnViewBackgroundView;

@end
