//
//  SaveOrderViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/18.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaveOrderViewController,DeskState;

@protocol SaveOrderViewControllerDelegate <NSObject>

@optional
- (void)SaveOrderViewControllerDidZhifu:(SaveOrderViewController *)saveOrderVc DeskState:(DeskState *)deskState billID:(NSString *)billID;

@end

@interface SaveOrderViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *OrderList;
@property (nonatomic, strong) NSMutableArray *taocanList;

@property (nonatomic, weak) id<SaveOrderViewControllerDelegate> delegate;
@property (nonatomic, copy) NSString *whereCome;
@property (nonatomic,strong)NSString *bookTimeStr;
@property (strong,nonatomic) NSArray *jiKouArr;


@end
