//
//  PromptSwipingCardViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptSwipingCardViewController.h"

@interface PromptSwipingCardViewController ()

@end

@implementation PromptSwipingCardViewController{
    NSString *_cardNo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    //[rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(-20, -10, 60, 43)];
    datubiaoImage.image = [UIImage imageNamed:@"yinlian"];
    UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 50)];
    zhifuleixingLabel.text = @"银行卡支付";
    [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
    [zhifuleixingLabel sizeToFit];
    [zhongjianView addSubview:datubiaoImage];
    [zhongjianView addSubview:zhifuleixingLabel];
    self.navigationItem.titleView = zhongjianView;
    
    //self.navigationItem.leftBarButtonItem
    self.navigationItem.rightBarButtonItem  =  [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.leftBarButtonItem  =  [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.titleView = zhongjianView;
    
}

-(void)back
{
    //[self dismissViewControllerAnimated:YES completion:nil];
    //MiniPosSDKCancelCMD();
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:@"获取卡号"]) {
        
        _cardNo = [NSString stringWithUTF8String:MiniPosSDKGetCardNo()];
        [self performSegueWithIdentifier:@"next" sender:self];
        
    }
    
    if ([self.statusStr isEqualToString:@"取消刷卡交易"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    //刷卡操作错误
    if([self.statusStr isEqualToString:@"刷卡操作错误"]){
        [self showAlertViewWithMessage:@"请将芯片卡插入卡槽！"];
        //[self showAlertViewWithMessage:@"卡片操作失败，请不要刷芯片卡"];
        
    }
    
    self.statusStr  =@"";
}

- (void)showAlertViewWithMessage:(NSString *)str{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    
    [alert show];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"The segue id is %@", segue.identifier );
    
    if ([segue.identifier isEqualToString:@"next"]) {
        
        UIViewController *destination = segue.destinationViewController;
        if ([destination respondsToSelector:@selector(setCardNo:)])
        {
            [destination setValue:_cardNo forKey:@"cardNo"];
        }
        
        if ([destination respondsToSelector:@selector(setAmount:)]) {
            [destination setValue:_amount forKey:@"amount"];
        }
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
