//
//  CashChangeViewController.h
//  G2TestDemo
//
//  Created by ws on 15/11/27.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhiFuChuanDiPG.h"

@interface CashChangeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *inputCashTextField;
@property (strong,nonatomic)ZhiFuChuanDiPG *zhiFuChuanDiPG;

@end
