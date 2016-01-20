//
//  CardRechargeController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CardRechargeController;
@protocol CardRechargeControllerDelegate <NSObject>

@optional
- (void)CardRechargeControllerDidChickQuXiao:(CardRechargeController *)cardRechargeVc;
- (void)CardRechargeControllerDidChickQueDing:(CardRechargeController *)cardRechargeVc WithCount:(CGFloat)count WithPayType:(NSString *)payType;

@end

@interface CardRechargeController : UIViewController
//WHC
@property (weak, nonatomic) IBOutlet UILabel *yueLable;
@property (weak, nonatomic) IBOutlet UILabel *jifenLable;
@property (copy,nonatomic) NSString *yue;
@property (copy,nonatomic) NSString *jifen;

@property (nonatomic, weak) id<CardRechargeControllerDelegate> delegate;

@end
