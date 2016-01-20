//
//  DXKeyboard.h
//  G2TestDemo
//
//  Created by ws on 15/9/21.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DXKeyboardDelegate <NSObject>

- (void) numberKeyBoardInput:(NSInteger) number;
- (void) numberKeyBoardBackspace;
- (void) numberKeyBoardFinish;
- (void) numberKeyBoardShou;

@end

@interface DXKeyboard : UIView

@property(nonatomic, assign) id<DXKeyboardDelegate> delegate;

@end
