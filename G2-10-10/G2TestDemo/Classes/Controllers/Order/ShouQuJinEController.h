//
//  ShouQuJinEController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/8.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SaoMiaoController.h"
#import "BaseViewController.h"
#import "ZhiFuChuanDiPG.h"
#import "NewSwipingCardViewController.h"
@interface ShouQuJinEController : BaseViewController

@property(nonatomic,strong)SaoMiaoController *saoMiaoVC;

//
//@property (nonatomic, copy) NSString *billID;
//
//@property (nonatomic, copy) NSString *PayType;
//
//@property (nonatomic, copy) NSString *count;
//
//@property (nonatomic, copy) NSString *whereFrom;
//
//@property (nonatomic, copy) NSString *orderNo;
//
//@property (nonatomic, copy) NSString *cptID;
//
//@property (nonatomic, copy) NSString *tabID;
//
//@property (nonatomic, copy) NSString *paymentType;
//
//@property (strong,nonatomic) NSString *idIdentifyStr;

@property(strong,nonatomic)ZhiFuChuanDiPG *zhifuchuandi;


@property (weak, nonatomic) IBOutlet UIButton *okButton;



@end
