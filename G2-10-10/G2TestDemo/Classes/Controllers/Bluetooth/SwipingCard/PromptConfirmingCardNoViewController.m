//
//  PromptConfirmingCardNoViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptConfirmingCardNoViewController.h"

@interface PromptConfirmingCardNoViewController ()
@property (strong, nonatomic) IBOutlet UILabel *cardLabel;

@end

@implementation PromptConfirmingCardNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cardLabel.text = self.cardNo;
    //self.navigationItem.title = self.amount;

    
    UIButton *price = [[UIButton alloc]init];
    [price setHeight:100.0f];
    [price setTitle:[NSString stringWithFormat:@"￥%@",self.amount] forState:UIControlStateNormal];
    [price  setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 30 ]];
    [price setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
    [price setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    self.navigationItem.titleView = price;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:@"消费下一步"]) {
        
        [self performSegueWithIdentifier:@"next" sender:self];
        
    }
    
    if ([self.statusStr isEqualToString:@"取消刷卡交易"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    self.statusStr  =@"";
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
