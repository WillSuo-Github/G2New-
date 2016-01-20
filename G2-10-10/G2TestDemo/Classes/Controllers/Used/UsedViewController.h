//
//  UsedViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/22.
//  Copyright (c) 2015年 ws. All rights reserved.
//====

#import <UIKit/UIKit.h>
@class UsedViewController,DeskState;

@protocol UsedViewControllerDelegate <NSObject>

@optional
- (void)UsedViewControllerDeskDidChick:(UsedViewController *)usedVc WithOrderList:(NSMutableArray *)orderListArr DeskStates:(DeskState *)deskState whereFrom:(NSString *)usedOrder;
-(void) UsedViewControllerDeskDidChick:(NSMutableArray *)jiKou;

@end

@interface UsedViewController : UIViewController

@property (nonatomic, weak) id<UsedViewControllerDelegate> delegate;

/**
 *  保存菜品名称  菜品在账单中的ID
 */
@property (nonatomic,strong)NSMutableArray *dishInfoArr;


@end
