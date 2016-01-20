//
//  DeskViewCell.m
//  G2TestDemo
//
//  Created by lcc on 15/7/28.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "DeskViewCell.h"
#define rgbDesk(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]

@interface DeskViewCell ()

//@property (weak, nonatomic) IBOutlet THLabel *ID;
//
//@property (weak, nonatomic) IBOutlet THLabel *states;
//@property (weak, nonatomic) IBOutlet THLabel *time;
//@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *renshu;
@property (weak, nonatomic) IBOutlet UILabel *jine;
@property (weak, nonatomic) IBOutlet UILabel *allLable;
@property (weak, nonatomic) IBOutlet UIImageView *oneImage;

@property (weak, nonatomic) IBOutlet UIImageView *twoImage;
@property (weak, nonatomic) IBOutlet UIImageView *threeImage;
@property (weak, nonatomic) IBOutlet UIImageView *minImage;



@end

@implementation DeskViewCell

- (void)awakeFromNib {
    
    

      self.size = CGSizeMake(kdeskWidth, kdeskHeight);
    
    self.ID.textColor = [UIColor lightGrayColor];
//    _ID.innerShadowColor = [UIColor lightGrayColor];
//    self.ID.innerShadowOffset = CGSizeMake(0.0, 0.5);
//    self.ID.innerShadowBlur = 0.6;
//    self.ID.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.5f];
//    self.ID.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    

    self.jine.textColor = [UIColor lightGrayColor];
    self.renshu.hidden = YES;
    self.jine.hidden = YES;
    self.jine.textColor = [UIColor whiteColor];
    
    self.allLable.hidden =YES;
}

- (void)setState:(DeskState *)state{
    
    _state = state;
//    NSLog(@"table num :%@",state.tabName);
    self.ID.text = state.tabNo;
//     NSLog(@"self.ID.text:%@",self.ID.text);
//    self.allLable.text = state.seat;
    self.allLable.text = [NSString stringWithFormat:@"%@-%@人",state.minSeat,state.seat];
    

//    self.renshu.text = state.peopleCount;
    self.renshu.text = [NSString stringWithFormat:@"%@人",state.peopleCount];
    
  // NSLog(@"state.peopleCount:%@",state.peopleCount);
//    self.jine.text = state.totalPrice;
    self.jine.text = [NSString stringWithFormat:@"%@元",state.totalPrice];
    NSString *oneTimeStr = @"";
    NSString *twoTimeStr = @"";
    NSString *threeTimeStr = @"";
    NSString *chaEtimeStr = @"";

//    NSLog(@"----%@",state.openTableTime);
    /**
     *  判断当前时间和开台时间的差值
     */
//    NSLog(@"tableID:%@   no:%@",state.tabId,state.tabNo);
//     NSLog(@"openTableTime:%@   ",state.openTableTime);
    
    if (state.openTableTime)
    {
        NSDateFormatter *date=[[NSDateFormatter alloc] init];
        [date setDateFormat:@"HH:mm"];
        NSString *nowDateStr = [date stringFromDate:[NSDate date]];
        
        NSCalendar *cal=[NSCalendar currentCalendar];
        unsigned int unitFlags= NSYearCalendarUnit| NSMonthCalendarUnit| NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
        
        NSDateComponents *d = [cal components:unitFlags fromDate:[date dateFromString:state.openTableTime] toDate:[date dateFromString:nowDateStr] options:0];
        
//        NSLog(@"++++======%ld+++%ld",[d hour],[d minute]);
        chaEtimeStr = [NSString stringWithFormat:@"%ld",([d hour]*60 + [d minute])];
//        NSLog(@"%@",chaEtimeStr);
        threeTimeStr = [NSString stringWithFormat:@"%ld",chaEtimeStr.integerValue / 100];//第三位
        twoTimeStr = [NSString stringWithFormat:@"%ld",(chaEtimeStr.integerValue % 100) / 10];//第二位
        oneTimeStr = [NSString stringWithFormat:@"%ld",(chaEtimeStr.integerValue % 10)];//第一位
        
    
        
    }

    if (state.dinnerStatus.length) {

        
        if ([state.dinnerStatus isEqualToString:@"1"])
        {
            if (state.openTableTime) {
                [self changeColorWith:@"blue" one:@"" two:@"" three:@""];
            } else {
                [self changeColorWith:@"dark" one:@"" two:@"" three:@""];
            }
            

        }else if ([state.dinnerStatus isEqualToString:@"2"])
        {

            if (chaEtimeStr.integerValue < 30)
            {
                [self changeColorWith:@"green" one:oneTimeStr two:twoTimeStr three:threeTimeStr];
            }else if (chaEtimeStr.integerValue >= 30 && chaEtimeStr.integerValue <= 100)
            {
                
                [self changeColorWith:@"yellow" one:oneTimeStr two:twoTimeStr three:threeTimeStr];
            }else if (chaEtimeStr.integerValue > 100)
            {
                
                [self changeColorWith:@"red" one:oneTimeStr two:twoTimeStr three:threeTimeStr];
            }

        }
    }else{
        
        self.renshu.hidden = YES;

    }
}




- (void)changeColorWith:(NSString *)colorStr one:(NSString *)one two:(NSString *)two three:(NSString *)three{
    
    if ([colorStr isEqualToString:@"green"]) {
        
        self.allLable.hidden = YES;
        self.renshu.hidden = NO;
        self.jine.hidden = NO;
        self.oneImage.hidden = NO;
        self.twoImage.hidden = NO;
        self.threeImage.hidden = NO;
        self.minImage.hidden = NO;
        self.ID.textColor = [UIColor colorWithRed:63/255.0 green:162/255.0 blue:63/255.0 alpha:1];
        self.renshu.backgroundColor = [UIColor colorWithRed:63/255.0 green:162/255.0 blue:63/255.0 alpha:1];
        self.jine.backgroundColor = [UIColor colorWithRed:63/255.0 green:162/255.0 blue:63/255.0 alpha:1];
        
        self.oneImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_g%@",one]];
        self.twoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_g%@",two]];
        self.threeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_g%@",three]];
        self.minImage.image = [UIImage imageNamed:@"hlk_gmin"];
        
        
        self.leftFenGeXian.backgroundColor = [UIColor colorWithRed:63/255.0 green:162/255.0 blue:63/255.0 alpha:1];
        self.topFenGeXian.backgroundColor = [UIColor colorWithRed:63/255.0 green:162/255.0 blue:63/255.0 alpha:1];
        self.rightFenGeXian.backgroundColor = [UIColor colorWithRed:63/255.0 green:162/255.0 blue:63/255.0 alpha:1];
        
        
        
    }else if ([colorStr isEqualToString:@"yellow"]){
        
        self.allLable.hidden = YES;
        self.renshu.hidden = NO;
        self.jine.hidden = NO;
        self.oneImage.hidden = NO;
        self.twoImage.hidden = NO;
        self.threeImage.hidden = NO;
        self.minImage.hidden = NO;
        self.ID.textColor = [UIColor colorWithRed:247/255.0 green:192/255.0 blue:17/255.0 alpha:1];
        self.renshu.backgroundColor = [UIColor colorWithRed:247/255.0 green:192/255.0 blue:17/255.0 alpha:1];
        self.jine.backgroundColor = [UIColor colorWithRed:247/255.0 green:192/255.0 blue:17/255.0 alpha:1];
        
        self.oneImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_y%@",one]];
        self.twoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_y%@",two]];
        self.threeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_y%@",three]];
        self.minImage.image = [UIImage imageNamed:@"hlk_ymin"];
        
        
        self.leftFenGeXian.backgroundColor = [UIColor colorWithRed:247/255.0 green:192/255.0 blue:17/255.0 alpha:1];
        self.topFenGeXian.backgroundColor = [UIColor colorWithRed:247/255.0 green:192/255.0 blue:17/255.0 alpha:1];
        self.rightFenGeXian.backgroundColor = [UIColor colorWithRed:247/255.0 green:192/255.0 blue:17/255.0 alpha:1];
        
    }else if ([colorStr isEqualToString:@"red"]){
        
        self.allLable.hidden = YES;
        self.renshu.hidden = NO;
        self.jine.hidden = NO;
        self.oneImage.hidden = NO;
        self.twoImage.hidden = NO;
        self.threeImage.hidden = NO;
        self.minImage.hidden = NO;
        self.ID.textColor = [UIColor colorWithRed:228/255.0 green:62/255.0 blue:84/225.0 alpha:1];
        self.renshu.backgroundColor = [UIColor colorWithRed:228/255.0 green:62/255.0 blue:84/225.0 alpha:1];
        self.jine.backgroundColor = [UIColor colorWithRed:228/255.0 green:62/255.0 blue:84/225.0 alpha:1];
        
        self.oneImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_o%@",one]];
        self.twoImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_o%@",two]];
        self.threeImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"hlk_o%@",three]];
        self.minImage.image = [UIImage imageNamed:@"hlk_omin"];
        
        self.leftFenGeXian.backgroundColor = [UIColor colorWithRed:228/255.0 green:62/255.0 blue:84/225.0 alpha:1];
        self.topFenGeXian.backgroundColor = [UIColor colorWithRed:228/255.0 green:62/255.0 blue:84/225.0 alpha:1];
        self.rightFenGeXian.backgroundColor = [UIColor colorWithRed:228/255.0 green:62/255.0 blue:84/225.0 alpha:1];
        
        
    }else if ([colorStr isEqualToString:@"dark"]){
        
//        self.oneImage.image = nil;
//        self.twoImage.image= nil;
//        self.threeImage.image = nil;
        self.renshu.hidden = YES;
        self.jine.hidden = YES;
        self.allLable.hidden = NO;
        
        self.oneImage.hidden = YES;
        self.twoImage.hidden = YES;
        self.threeImage.hidden = YES;
        self.minImage.hidden = YES;
        
        self.ID.textColor = [UIColor colorWithRed:101/255.0 green:104/255.0 blue:115/255.0 alpha:1];
        self.allLable.backgroundColor = [UIColor colorWithRed:101/255.0 green:104/255.0 blue:115/255.0 alpha:1];
        
        
        self.leftFenGeXian.backgroundColor = [UIColor colorWithRed:101/255.0 green:104/255.0 blue:115/255.0 alpha:1];
        self.topFenGeXian.backgroundColor = [UIColor colorWithRed:101/255.0 green:104/255.0 blue:115/255.0 alpha:1];
        self.rightFenGeXian.backgroundColor = [UIColor colorWithRed:101/255.0 green:104/255.0 blue:115/255.0 alpha:1];
    }
    else{
        self.renshu.hidden = YES;
        self.jine.hidden = YES;
        self.allLable.hidden = NO;
        
        self.oneImage.hidden = YES;
        self.twoImage.hidden = YES;
        self.threeImage.hidden = YES;
        self.minImage.hidden = YES;
        
        self.ID.textColor = rgbDesk(76, 135, 231);
        self.allLable.backgroundColor = rgbDesk(76, 135, 231);
        self.allLable.text = _state.openTableTime;
        
        self.leftFenGeXian.backgroundColor = rgbDesk(76, 135, 231);
        self.topFenGeXian.backgroundColor = rgbDesk(76, 135, 231);
        self.rightFenGeXian.backgroundColor = rgbDesk(76, 135, 231);
    
    }
    
}

@end
