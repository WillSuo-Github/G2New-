//
//  StoreStateViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/7/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreStateViewController;
@protocol StoreStateViewControllerDelegare <NSObject>

@optional
- (void)StoreStateViewController:(StoreStateViewController *)stateVc DidChickStates:(NSInteger)index;

@end



@interface StoreStateViewController : UITableViewController
@property (nonatomic, weak) id<StoreStateViewControllerDelegare> delegate;
@end
