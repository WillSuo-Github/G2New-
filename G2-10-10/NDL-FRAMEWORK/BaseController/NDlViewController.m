//
//  NDlViewController.m
//  G2TestDemo
//
//  Created by NDlan on 1/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDlViewController.h"
#import "BSUIComponentView.h"
@interface NDlViewController ()

@end

@implementation NDlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController) {
        //iOS有默认导航栏，使用固有的导航栏
        [BSUIComponentView initNavigationHeaderWithDefault:self
                                         navigationProcess:self
                                                     title:self.title];

        [BSUIComponentView navigationHeader:self.navigationController];
        
    }else{
        //没有导航栏，使用Button完成
        [BSUIComponentView initNarHeaderWithDefault:self title: self.title];
        //[BSUIComponentView navigationHeader:self.navigationController];
        
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
