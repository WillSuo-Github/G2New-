//
//  JYSaoMaXiaDanViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYSaoMaXiaDanViewController.h"
#import "lhScanQCodeViewController.h"
#import "JYShangPinXiangQingViewController.h"
#import "JYProductManager.h"
#import "MBProgressHUD.h"
#import "JYMainViewController.h"

@interface JYSaoMaXiaDanViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *ShuRuView;
@property (weak, nonatomic) IBOutlet UITextField *TiaoXingMaTextField;
@property (weak, nonatomic) IBOutlet UIView *SaoYiSaoView;
@property (weak, nonatomic) IBOutlet UIButton *SaoYiSaoButton;
//初始化JYProductManager.h
@property(strong,nonatomic)JYSaoMaXiaDanViewController *JYsm;

@end

@implementation JYSaoMaXiaDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
    //设置UI
    [self vIewSet];
    
    

}
-(void)vIewSet{
    //设置代理
    self.TiaoXingMaTextField.delegate = self;
    //设置输入view圆角和边框
    self.ShuRuView.layer.borderWidth=1;
    self.ShuRuView.layer.borderColor=[UIColor blackColor].CGColor;
    self.ShuRuView.layer.cornerRadius=5;
    //扫描view的圆角和边框
    self.SaoYiSaoView.layer.borderWidth=1;
    self.SaoYiSaoView.layer.borderColor=[UIColor blackColor].CGColor;
    self.SaoYiSaoView.layer.cornerRadius=5;
}
//输入窗代理 WHC
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.TiaoXingMaTextField.text intValue]) {
        JYProductManager *manager = [[JYProductManager alloc]init];
        [manager obtainProduceInfoWith:self.TiaoXingMaTextField.text block:^(id response, ErrorMessage *bsErrorMessage) {
            NSLog(@"123%@",response);
            JYShangPinXiangQingViewController *jyShangPin = [[JYShangPinXiangQingViewController alloc]init];
           
            
            jyShangPin.proDuctModel = response[0];
            if (![jyShangPin.proDuctModel.name isEqualToString:@"错误"]) {
                   //输入成功显示效果
                 [[JYMainViewController sharedMainView] MainViewInsertSubviewWith:jyShangPin];
            }
            //查询不成功
            else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有查询结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
            }
           
         
           
            
        }];
    }
    
    return YES;
}
//扫一扫
- (IBAction)SaoYiSao:(id)sender {
    
    lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc]init];
    
    UINavigationController * nVC = [[UINavigationController alloc]initWithRootViewController:sqVC];
    nVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    nVC.modalPresentationStyle = UIModalPresentationPageSheet;
    [self presentViewController:nVC animated:YES completion:^{
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
