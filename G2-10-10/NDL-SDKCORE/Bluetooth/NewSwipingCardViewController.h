//
//  NewSwipingCardViewController.h
//  G2TestDemo
//
//  Created by 吴狄 on 15/11/23.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class NewSwipingCardViewController;

@protocol  NewSwipingCardViewControllerDelegate <NSObject>

@optional

-(void)newSwipingCardViewControllerdidFinishConsume :(NewSwipingCardViewController *)vc statusInfo:(NSString*)statusInfo;

@end

@interface NewSwipingCardViewController : BaseViewController
@property (nonatomic,strong) NSString *amount;
@property (nonatomic, weak) id<NewSwipingCardViewControllerDelegate> delegate;
@end
