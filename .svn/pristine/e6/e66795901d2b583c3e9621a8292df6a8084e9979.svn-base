//
//  MenuViewCell.m
//  G2TestDemo
//
//  Created by lcc on 15/7/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "MenuViewCell.h"

@interface MenuViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImage;




@end

@implementation MenuViewCell

- (void)awakeFromNib{
    

}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    self.imageV.image = self.image;
}


- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLabel.text = title;
}

- (void)setBadgeNum:(NSString *)badgeNum{
    
    _badgeNum = badgeNum;
    if (badgeNum.length) {
        self.badgeImage.hidden = NO;
        self.badgeLabel.text = badgeNum;
    }else{
        
        self.badgeImage.hidden = YES;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
