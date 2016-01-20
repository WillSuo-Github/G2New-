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

@implementation PromptUploadingTradeViewController{
    NSTimer *_timer60;
    int  no;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *price = [[UIButton alloc]init];
    [price setHeight:100.0f];
    [price setTitle:[NSString stringWithFormat:@"￥%@",self.amount] forState:UIControlStateNormal];
    [price setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 30 ]];
    [price setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
    [price setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    self.navigationItem.titleView = price;
    
    no = 60;
    
    
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


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _timer60 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countdown) userInfo:nil repeats:YES];
    
    [_timer60 fire];
}

-(void)countdown{
    
    self.timeLabel.text = [NSString stringWithFormat:@"%ds",no--];
    if (no <0) {
        [_timer60  invalidate];
    }
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
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费响应超时"]]) {
        [self showTipView:self.statusStr];
        //[self performSegueWithIdentifier:@"next" sender:self];
        [self performSelector:@selector(back) withObject:nil afterDelay:5.0];
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
    }
    
    
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
