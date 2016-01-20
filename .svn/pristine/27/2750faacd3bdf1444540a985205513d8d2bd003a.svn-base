//
//  MenuHeadView.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "MenuHeadView.h"
#import "NDLFrameworkHeader.h"
@interface MenuHeadView(){
    
    UIImageView *_imageV;
    
    UILabel *_storeName;
    
    UILabel *_storeAddress;
}



@end



@implementation MenuHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
        [self addImageView];
        [self addstoreName];
        [self addstoreAddress];
    }
    return self;
}

- (void)addImageView{
    UIImageView *imageV = [[UIImageView alloc] init];
    _imageV = imageV;
    imageV.backgroundColor = [UIColor blueColor];
    [self addSubview:imageV];
}

- (void)addstoreName{
    
    UILabel *storeName = [[UILabel alloc] init];
    _storeName = storeName;
    [self addSubview:storeName];
    
}

- (void)addstoreAddress{
    
    UILabel *storeAddress = [[UILabel alloc] init];
    _storeAddress = storeAddress;
    [self addSubview:storeAddress];
    
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    CGFloat headW = self.superview.width;
    CGFloat headH = 160;
    self.frame = CGRectMake(0, 0, headW, headH);
    
    _imageV.center = self.center;
    _imageV.size = CGSizeMake(85, 85);
}
@end
