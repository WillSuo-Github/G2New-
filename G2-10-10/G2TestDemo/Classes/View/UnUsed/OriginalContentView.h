//
//  OriginalContentView.h
//  G2TestDemo
//
//  Created by lcc on 15/7/22.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeskState.h"
#import "JiaoYiPG.h"

@class OriginalContentView;
@protocol OriginalContentViewDelegate <NSObject>

@optional
- (void)OriginalContentViewDidChickXiaDan:(OriginalContentView  *)orderContent;
- (void)OriginalContentViewDidChickJieZhang:(OriginalContentView  *)orderContent WithBillID:(NSString *)billID tableID:(NSString *)tableID count:(NSString *)count;

@end

@interface OriginalContentView : UIView


@property (nonatomic, weak) id<OriginalContentViewDelegate> delegate;
@property (nonatomic, strong) JiaoYiPG *jiaoyiPG;

@end
