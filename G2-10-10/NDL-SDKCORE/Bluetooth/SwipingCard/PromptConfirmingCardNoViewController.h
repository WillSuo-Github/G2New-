//
//  PromptConfirmingCardNoViewController.h
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ZhiFuChuanDiPG.h"
@interface PromptConfirmingCardNoViewController : BaseViewController
@property (nonatomic,strong) NSMutableString *cardNo;
@property (nonatomic,strong) NSString *amount; //消费金额
@property(strong,nonatomic) ZhiFuChuanDiPG *zhifuchuandi;
@end
