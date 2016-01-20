//
//  ShiJiaController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/7.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ShiJiaController.h"

@interface ShiJiaController ()

@property (nonatomic, copy) NSString *result;


@end

@implementation ShiJiaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.result = @"";
}

- (IBAction)jisuanBtnChick:(UIButton *)sender {
    
    if (sender.tag == 1002) {
        self.result = [NSString stringWithFormat:@"%@.",_result];
    }else if (sender.tag == 1001) {
        if (self.result.length) {
            self.result = [_result substringToIndex:self.result.length - 1];
        }
    }else if (sender.tag == 1003 ) {
        [_delegate numberKeyBoardShou:self.textField.text];
        [self.view removeFromSuperview];
        
    }else {
        self.result = [NSString stringWithFormat:@"%@%ld",_result,sender.tag- 990];
    }
    self.textField.text = self.result;
    
    
    
}

- (IBAction)queding:(id)sender {
    
    
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
