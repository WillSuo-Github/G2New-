//
//  YuDingDatePickController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/14.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "YuDingDatePickController.h"

@interface YuDingDatePickController ()

@property (nonatomic, strong) UIDatePicker *datePick;

@end

@implementation YuDingDatePickController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    [self setUpDatePickView];
}

- (void)setUpDatePickView{
    
     UIDatePicker *datePick = [[UIDatePicker alloc] init];
    if ([self.datePickerType isEqualToString:@"time"]) {
       
         self.preferredContentSize = CGSizeMake(300, 216);
        datePick.frame = CGRectMake(0, 0,300,216);
        [datePick addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        datePick.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePick = datePick;
        
        datePick.datePickerMode = UIDatePickerModeDateAndTime;
    }else
    {
        self.preferredContentSize = CGSizeMake(300, 216);
        datePick.frame = CGRectMake(0, 0,300,216);
        [datePick addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        datePick.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        self.datePick = datePick;
        
        datePick.datePickerMode = UIDatePickerModeDate;
        
    }
   
    [self.view addSubview:datePick];
}

- (void)dateChanged:(UIDatePicker *)sender{
    
    NSDate* date = sender.date;
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *str = [outputFormatter stringFromDate:date];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *wholeDateStr = [dateFormatter stringFromDate:date];
    
    
    NSLog(@"testDate:%@", str);
//    NSLog(@"%@",date);
    if ([_delegate respondsToSelector:@selector(YuDingDatePickControllerDidSelectDate:AndString:)]) {
        [self.delegate YuDingDatePickControllerDidSelectDate:str AndString:wholeDateStr];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
