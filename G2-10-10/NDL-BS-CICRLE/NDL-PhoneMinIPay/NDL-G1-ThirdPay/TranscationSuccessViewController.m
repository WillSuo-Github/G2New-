//
//  TranscationSuccessViewController.m
//  G2TestDemo
//
//  Created by ws on 15/12/18.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "TranscationSuccessViewController.h"

@interface TranscationSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UIView *failureView;
@property (weak, nonatomic) IBOutlet UIButton *OKButton;

@end

@implementation TranscationSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.isSuccess)
        [self setSuccessUIAutolayout];
    else [self setFailureUIAutolayout];
    

    
    
    
}

-(void)setSuccessUIAutolayout
{
    self.successView.hidden = NO;
    self.failureView.hidden = YES;
    [self.OKButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.OKButton addTarget:self action:@selector(successButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.successView.hidden = YES;
    self.failureView.hidden = YES;
    [self.OKButton setTitle:@"" forState:UIControlStateNormal];
    
    
    
    
}

-(void)setFailureUIAutolayout
{
    self.failureView.hidden = NO;
    self.successView.hidden = YES;
    [self.OKButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.OKButton addTarget:self action:@selector(failureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.OKButton.userInteractionEnabled = YES;
    
    
    
    
    
}
/**
 *  消费成功 调用的方法
 *
 *  @param sender
 */
-(void)successButtonClick:(UIButton *)sender
{
    self.OKButton.userInteractionEnabled = NO;
     [self.navigationController popToRootViewControllerAnimated:YES];
    
    
    
}

/**
 *  消费失败 调用的方法
 *
 *  @param sender
 */
-(void)failureButtonClick:(UIButton *)sender
{
     self.OKButton.userInteractionEnabled = NO;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
