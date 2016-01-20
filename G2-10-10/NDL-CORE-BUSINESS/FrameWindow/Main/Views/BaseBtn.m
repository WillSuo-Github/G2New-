//
//  BaseBtn.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "BaseBtn.h"
#import "NDLBusinessConfigure.h"
@interface BaseBtn(){
    
    UIImageView *_imageV;
    UILabel *_label;
}

@end


@implementation BaseBtn

//- (CGRect)imageRectForContentRect:(CGRect)contentRect{
//    
//    CGFloat ImageX = contentRect.size.width
//}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUpImage];
    }
    return self;
}

- (void)setUpImage{
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = _currImage;
    _imageV = imageV;
    [self addSubview:imageV];
    
}

- (void)setUpTitle{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = _title;
    _label = label;
    [self addSubview:label];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
   
}
@end
