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

@protocol sendChuandiDleegate <NSObject>

-(void)sendChuanDi:(ZhiFuChuanDiPG *)zhifuW;

@end
@interface ZhiFuViewController : BaseViewController


//@property (nonatomic,copy) NSString *rechargeAmountStr;
//
//
//@property (nonatomic, copy) NSString *billID;
//@property (nonatomic, copy) NSString *count;
//
//@property(strong,nonatomic) NSString *idIdentifyStr;
//
//
//@property (nonatomic, copy) NSString *whereFrom;
//@property (nonatomic, copy) NSString *orderNo;
//
//@property (nonatomic, copy) NSString *tabID;

@property (nonatomic, strong) ZhiFuChuanDiPG *chuandiPG;

@property (nonatomic,copy) NSString *panDuanHiden;
@property (assign,nonatomic) id<sendChuandiDleegate>delegate;

SingletonH(ZhiFuViewController)

@property (weak, nonatomic) IBOutlet UIView *btnViewBackgroundView;

@end
