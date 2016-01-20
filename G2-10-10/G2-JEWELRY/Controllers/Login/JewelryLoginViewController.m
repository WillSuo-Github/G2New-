//
//  JewelryLoginViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/4.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JewelryLoginViewController.h"
@interface JewelryLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *zhanghao;   //账号的输入框
@property (weak, nonatomic) IBOutlet UITextField *mima;  //密码的输入框

@property (weak, nonatomic) IBOutlet UIButton *denglu;  //登陆按钮
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *juhua;//等待的菊花

@property (weak, nonatomic) IBOutlet UIView *LoginView;
@property (weak, nonatomic) IBOutlet UIView *zhanghaoView;
@property (weak, nonatomic) IBOutlet UIView *mimaView;

@end

@implementation JewelryLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //登陆背景颜色
    self.denglu.layer.cornerRadius = 7;
    self.denglu.layer.masksToBounds = YES;
    self.denglu.backgroundColor = [UIColor colorWithRed:78/225.0 green:152/255.0 blue:226/255.0 alpha:1];
    //就是可以按照你给它定义的那些操作实现效果
    self.denglu.userInteractionEnabled = YES;
    // 设置账号的显示
    self.zhanghaoView.layer.borderWidth = 1;
    self.zhanghaoView.layer.borderColor = [[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1]CGColor];
    self.zhanghao.tintColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    //设置密码的现实
    self.mimaView.layer.borderWidth = 1;
    self.mimaView.layer.borderColor = [[UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1]CGColor];
    self.mimaView.layer.masksToBounds = YES;
    self.mima.tintColor = [UIColor colorWithRed:65/255.0 green:65/255.0 blue:65/255.0 alpha:1];
    self.mima.delegate = self;
    
    
    // Do any additional setup after loading the view from its nib.
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
