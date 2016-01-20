//
//  PromptUploadingTradeViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptUploadingTradeViewController.h"

@interface PromptUploadingTradeViewController ()

@end

@implementation PromptUploadingTradeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费成功"]]) {
        [self performSegueWithIdentifier:@"next" sender:self];
    }
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费失败"]]) {
        [self showTipView:self.statusStr];
        //[self performSegueWithIdentifier:@"next" sender:self];
        [self performSelector:@selector(back) withObject:nil afterDelay:5.0];
    }
    
    
    self.statusStr  =@"";
}

-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
