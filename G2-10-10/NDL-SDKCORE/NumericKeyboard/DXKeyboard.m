//
//  DXKeyboard.m
//  G2TestDemo
//
//  Created by ws on 15/9/21.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "DXKeyboard.h"

@interface DXKeyboard ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;

@property (weak, nonatomic) IBOutlet UIButton *fiveButton;
@property (weak, nonatomic) IBOutlet UIButton *sixButton;
@property (weak, nonatomic) IBOutlet UIButton *sevenButton;
@property (weak, nonatomic) IBOutlet UIButton *eightButton;
@property (weak, nonatomic) IBOutlet UIButton *nineButton;
@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *doubleZeroButton;
@property (weak, nonatomic) IBOutlet UIButton *pointButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UIButton *hiddenButton;

@end
@implementation DXKeyboard


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"DXKeyboard" owner:nil options:nil];
        self = [arr objectAtIndex:0];
        
        CGFloat width = self.oneButton.width;
        self.oneButton.layer.cornerRadius = 5;
        self.oneButton.layer.shadowOffset = CGSizeMake(width, 3);
        self.oneButton.layer.shadowColor = [[UIColor colorWithRed:97/255.0 green:99/255.0 blue:102/255.0 alpha:1]CGColor];
        self.twoButton.layer.cornerRadius = 5;
        self.threeButton.layer.cornerRadius = 5;
        self.fourButton.layer.cornerRadius = 5;
        self.fiveButton.layer.cornerRadius = 5;
        self.sixButton.layer.cornerRadius = 5;
        self.sevenButton.layer.cornerRadius = 5;
        self.eightButton.layer.cornerRadius = 5;
        self.nineButton.layer.cornerRadius = 5;
        self.zeroButton.layer.cornerRadius = 5;
        self.doubleZeroButton.layer.cornerRadius = 5;
        self.okButton.layer.cornerRadius = 5;
        self.pointButton.layer.cornerRadius = 5;
        self.pointButton.titleLabel.textAlignment = UITextAlignmentCenter;
       // btn.textLabel.textAlignment = UITextAlignmentLeft
        self.hiddenButton.layer.cornerRadius = 5;
        self.hiddenButton.layer.masksToBounds =YES;
        self.deleteButton.layer.cornerRadius = 5;
        self.deleteButton.layer.masksToBounds =YES;
        
        
        
        
        
        
        
        
    }
    return self;
}

- (IBAction)oneBtn:(UIButton *)sender {
    NSInteger number = sender.tag;
    [_btn.layer setCornerRadius:10];
    if(number <= 12 && number >= 1){
        [_delegate numberKeyBoardInput:number];
        return;
    }if (number == 13)
    {
        [_delegate numberKeyBoardBackspace];
        return;
    }if (number == 14)
    {
        [_delegate numberKeyBoardFinish];
        return;
    }if (number == 15) {
        [_delegate numberKeyBoardShou];
    }
}



@end
