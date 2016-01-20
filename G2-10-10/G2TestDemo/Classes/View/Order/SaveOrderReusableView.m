//
//  SaveOrderReusableView.m
//  G2TestDemo
//
//  Created by lcc on 15/8/24.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "SaveOrderReusableView.h"

@interface SaveOrderReusableView ()

@property (nonatomic, weak) IBOutlet UILabel *name;

@property (nonatomic, strong) UIImageView *selectImageView;

@property (nonatomic, strong) UIButton *selectBtn;



@end


@implementation SaveOrderReusableView

- (void)awakeFromNib {
    // Initialization code
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(586, 0, 44, 44)];
//    imageV.image = [UIImage imageNamed:@"xzd"];
//    imageV.tag = 100;
//    _imageV = imageV;
//    [self.btn addSubview:imageV];
//    [self.btn addTarget:self action:@selector(btnChick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setTitleName:(NSString *)titleName{
    
    _titleName = titleName;
    self.name.text = titleName;
    self.imageView.image = [UIImage imageNamed:@"hlk_qx"];
}

//- (void)btnChick:(UIButton *)btn{
//    
//    self.selectBtn.selected = YES;
//    self.selectBtn = btn;
//    self.selectBtn.selected = NO;
//    
//    if (self.selectBtn.selected) {
//        self.imageView.transform = CGAffineTransformIdentity;
//    }else{
//        
//        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_2_PI);
//        
//    }
//
//    
//    
//}


@end
