//
//  TiHuanController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/7.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "replacePG.h"
@class TiHuanController;

@protocol TiHuanControllerDelegate <NSObject>

@optional
- (void)TiHuanControllerDidChick:(TiHuanController *)tihuanVc replacePG:(replacePG *)replace taocanID:(NSString *)taocanID;

-(void)sendJiKou :(NSString *)jiKou;

@end


@interface TiHuanController : UIViewController

@property (nonatomic, copy) NSString *taocanID;

@property (nonatomic, copy) NSString *dedishID;
@property (copy,nonatomic) NSString *jikou;

@property (nonatomic, weak) id<TiHuanControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *bigView;

- (IBAction)clickBtn:(id)sender;

@end
