//
//  FoodCell.m
//  G2TestDemo
//
//  Created by lcc on 15/7/24.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "FoodCell.h"
#import "UIImageView+WebCache.h"


@interface FoodCell ()


@property (weak, nonatomic) IBOutlet UIImageView *caiImage;


@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UIImageView *selectImage;

@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *shijia;



@end


@implementation FoodCell


- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor lightTextColor];
    self.width = 120;
    self.height = 150;
    self.bageNum = @"";
    self.bageLable.hidden = YES;
    self.bageImage.hidden = YES;
    self.shouqing.hidden = YES;
    
}

- (void)setCaipg:(CaiPG *)caipg{
    _caipg = caipg;
    self.title.text = caipg.dishesName;

    self.number.text = [NSString stringWithFormat:@"NO:%@",caipg.dishesCode];
    if ([caipg.isRulingPrice isEqualToString:@"0"]) {
        self.shijia.text = @"";
    }else{
        self.shijia.textColor = [UIColor redColor];
        self.shijia.text = @"时价";
    }
    if (caipg.picUrl.length) {
        
        NSString *urlString = [NSString stringWithFormat:@"%@/canyin-main%@",ceshiIP,caipg.picUrl];
//        NSLog(@"%@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];

        
        [self.caiImage sd_setImageWithURL:url];

//        [self.caiImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"11"]];
    }else if(caipg.picUrlSet.length){
        
        NSString *urlString = [NSString stringWithFormat:@"%@/canyin-main%@",ceshiIP,caipg.picUrlSet];
            //        NSLog(@"%@",urlString);
        NSURL *url = [NSURL URLWithString:urlString];
        
        
        [self.caiImage sd_setImageWithURL:url];
        
        
    }else{
        
        self.caiImage.image = [UIImage imageNamed:@"纯白"];
    }
    if (caipg.estimate.length) {
        self.bageImage.hidden = NO;
        self.bageLable.hidden = NO;
        self.bageNum = caipg.estimate;
    }else{
        self.shouqing.hidden = YES;
        self.bageLable.hidden = YES;
        self.bageImage.hidden = YES;
    }
    
    
}


- (void)setBageNum:(NSString *)bageNum{
    
    _bageNum = bageNum;
    
    if ([bageNum isEqualToString:@"0"]) {
        self.shouqing.hidden = NO;
        self.bageLable.hidden = YES;
        self.bageImage.hidden = YES;
    }else{
        self.shouqing.hidden = YES;
        if (bageNum.length) {
            self.bageLable.hidden = NO;
            self.bageLable.text = bageNum;
            self.bageImage.hidden = NO;
        }else{
//            self.shouqing.hidden = YES;
            self.bageLable.hidden = YES;
            self.bageImage.hidden = YES;
        }
    }
    
    
    
}


@end
