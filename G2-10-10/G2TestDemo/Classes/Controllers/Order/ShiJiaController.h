//
//  ShiJiaController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/7.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ShiJiaControllerDelegate <NSObject>


- (void) numberKeyBoardShou :(NSString *)shijia;

@end

@interface ShiJiaController : UIViewController

@property(nonatomic, assign) id<ShiJiaControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
