//
//  SaveOrderReusableView.h
//  G2TestDemo
//
//  Created by lcc on 15/8/24.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaveOrderReusableView;
@protocol SaveOrderReusableViewDelegate <NSObject>

@optional
- (void)saveOrderReusableViewDidChick:(SaveOrderReusableView *)saveOrder;

@end


@interface SaveOrderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, assign) CGFloat angle;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSString *titleName;
@property (weak, nonatomic) IBOutlet UILabel *tableCapacity;


@property (nonatomic, weak) id<SaveOrderReusableViewDelegate> delegate;





@end
