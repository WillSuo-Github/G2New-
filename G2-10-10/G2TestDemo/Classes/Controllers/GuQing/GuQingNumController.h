//
//  GuQingNumController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/14.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GuQingNumController;

@protocol GuQingNumControllerDelegate <NSObject>

@optional
- (void)GuQingNumControllerDidChick:(GuQingNumController *)guqingVc num:(NSString *)num;
-(void)guqingChahao:(GuQingNumController *)guqingCha;



@end


//@protocol CustomKeyboardDelegate <NSObject>
//
//@optional
//
////获取输入的数字
//-(void) CustomNumberKeyboardInput:(NSInteger)digital;
//-(void)numberKeyBoardBackspace;




@interface GuQingNumController : UIViewController <UITextFieldDelegate>

@property (nonatomic,weak) id<GuQingNumControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *caiming;
@property (copy,nonatomic) NSString *caimingStr;

//获取输入的数字
-(void)CustomNumberKeyboardInput:(NSInteger)digital;
-(void)numberKeyBoardBackspace;


@end
