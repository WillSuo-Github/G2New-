//
//  PromptSigningViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptSigningViewController.h"
#import "UIUtils.h"
#import "NDLBusinessConfigure.h"
@interface PromptSigningViewController ()

@end

@implementation PromptSigningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *price = [[UIButton alloc]init];
    [price setHeight:100.0f];
    [price setTitle:[NSString stringWithFormat:@"%@",@"签购单"] forState:UIControlStateNormal];
    [price setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 30 ]];
    [price setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
    [price setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    self.navigationItem.titleView = price;
    
    self.amountLabel.text = self.amount;
    
    NSString *time = [UIUtils stringFromDate:[NSDate date] formate:@"yyyy/MM/dd HH:mm:ss"];
    self.timeLabel.text = time;
    
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 60)];
    [cancelButton setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, 0)];
    [cancelButton setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
}

//取消按钮action
-(void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    
    
    if ([self.statusStr isEqualToString:@"收取图片成功"]) {
        
        [self performSegueWithIdentifier:@"next" sender:self];
        
    }
    
    self.statusStr  =@"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"The segue id is %@", segue.identifier );
    
    if ([segue.identifier isEqualToString:@"next"]) {
        
        UIViewController *destination = segue.destinationViewController;
        
        if ([destination respondsToSelector:@selector(setAmount:)]) {
            [destination setValue:_amount forKey:@"amount"];
        }
        
        if ([destination respondsToSelector:@selector(setZhifuchuandi:)]) {
            [destination setValue:_zhifuchuandi forKey:@"zhifuchuandi"];
        }
        
        if ([destination respondsToSelector:@selector(setDelegate:)]) {
            [destination setValue:_delegate forKey:@"delegate"];
        }
    }
    
    
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
