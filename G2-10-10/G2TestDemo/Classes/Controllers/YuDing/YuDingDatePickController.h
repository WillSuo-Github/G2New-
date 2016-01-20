//
//  YuDingDatePickController.h
//  G2TestDemo
//
//  Created by lcc on 15/9/14.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YuDingDatePickControllerDelegate <NSObject>

@optional

- (void)YuDingDatePickControllerDidSelectDate:(NSString *)date AndString:(NSString *)wholeDateStr;

@end


@interface YuDingDatePickController : UIViewController

@property(nonatomic,strong)NSString *datePickerType;

@property (nonatomic, weak) id<YuDingDatePickControllerDelegate> delegate;

@end
