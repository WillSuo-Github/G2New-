//
//  JYOrderCollectionViewCell.m
//  G2TestDemo
//
//  Created by tencrwin on 15/12/8.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYOrderCollectionViewCell.h"

@implementation JYOrderCollectionViewCell

- (void)awakeFromNib {
    //
    ;}
-(void)setModel:(JYProductInfoModel *)model{
    _model = model;
    //加载数据
    self.name.text = self.model.name;
    self.jyNumber.text=self.model.proId;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.picture]];
    self.jyImage.image = [UIImage imageWithData:data];

}

@end
