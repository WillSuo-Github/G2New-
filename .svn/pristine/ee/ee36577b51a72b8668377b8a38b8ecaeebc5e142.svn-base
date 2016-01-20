//
//  ZhuanTaiViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ZhuanTaiViewController.h"

@interface ZhuanTaiViewController ()

@end

@implementation ZhuanTaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.5];

}

- (IBAction)cancle:(id)sender {
    
    [self.view removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(zhuantaiViewDidDismissWith:)]) {
        [self.delegate zhuantaiViewDidDismissWith:self];
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
