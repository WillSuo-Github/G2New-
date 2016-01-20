//
//  SavedViewController.h
//  G2TestDemo
//
//  Created by lcc on 15/8/26.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SavedViewController;

@protocol SavedViewControllerDelegate <NSObject>

@optional
- (void)SavedViewControllerDidChickTableView:(SavedViewController *)saveOrderVc WithOrderList:(NSMutableArray *)orderDetil billId:(NSString *)billId tabID:(NSString *)tabID;

@end


@interface SavedViewController : UIViewController

@property (nonatomic, weak) id<SavedViewControllerDelegate> delegate;

@end
