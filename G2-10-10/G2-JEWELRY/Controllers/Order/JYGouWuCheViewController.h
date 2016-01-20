//
//  JYGouWuCheViewController.h
//  G2TestDemo
//
//  Created by wjy on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYGouWuCheViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *JYShoppingtableView;

//购物数量Arr
@property (strong,nonatomic) NSMutableArray *productArr;

@end
