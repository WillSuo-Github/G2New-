//
//  PrintViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "PrintViewController.h"
#import "NDLBusinessConfigure.h"
#import "DXKeyboard.h"

//导入打印
//#import "NDlPrint.h"

@interface PrintViewController ()<DXKeyboardDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *yujiesuandayin;
@property (weak, nonatomic) IBOutlet UITextField *jiezhangdandayin;
@property (weak, nonatomic) IBOutlet UIView *xiadandayinView;
@property (weak, nonatomic) IBOutlet UIView *yujiesuandayinView;
@property (weak, nonatomic) IBOutlet UIView *jiezhangdandayinView;


@property (weak, nonatomic) IBOutlet UILabel *xiadanzhangshu;
@property (weak, nonatomic) IBOutlet UILabel *xiadandayin;
@property (weak, nonatomic) IBOutlet UILabel *yusuandayin;
@property (weak, nonatomic) IBOutlet UILabel *jiezhangdayin;
@property (weak, nonatomic) IBOutlet UILabel *xiaopaioneirong;
@property (weak, nonatomic) IBOutlet UIButton *queding;

@property (weak, nonatomic) IBOutlet UIButton *quxiao;
//张字颜色
@property (weak, nonatomic) IBOutlet UILabel *zhang1;
@property (weak, nonatomic) IBOutlet UILabel *zhang2;
@property (weak, nonatomic) IBOutlet UILabel *zhang3;
@property (weak, nonatomic) IBOutlet UIView *xiaopiaokuang;
@property (strong,nonatomic) NSUserDefaults *configPintInfo;
@property (weak, nonatomic) IBOutlet UITextField *xiaDanDaYinFiled;

//数字键盘 wjy
@property (strong, nonatomic)UITextField *isBeingEditingTextField;

@end

@implementation PrintViewController

- (void)viewDidLoad {
    
    //添加数字键盘
    DXKeyboard *jianpanView = [[DXKeyboard alloc] init];
    jianpanView.delegate = self;
    
    self.xiaDanDaYinFiled.delegate=self;
    self.yujiesuandayin.delegate=self;
    self.jiezhangdandayin.delegate=self;
    [self.xiaDanDaYinFiled setInputView:jianpanView];
    [self.yujiesuandayin setInputView:jianpanView];
    [self.jiezhangdandayin setInputView:jianpanView];
    

    [super viewDidLoad];
    //小票框圆角
    self.xiaopiaokuang.layer.cornerRadius=5;
    self.xiaopiaokuang.layer.borderWidth=1;
    self.xiaopiaokuang.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    //字体颜色
    
    self.xiadanzhangshu.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.xiadandayin.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.jiezhangdayin.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.xiaopaioneirong.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yusuandayin.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    //取消的字体，边框，颜色
    self.quxiao.layer.cornerRadius=5;
    self.queding.layer.cornerRadius=5;
    [self.queding addTarget:self action:@selector(OKButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.quxiao setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
    //张的颜色
    self.zhang1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.zhang2.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.zhang3.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    //设置textfield边框颜色
    self.xiadandayinView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    self.yujiesuandayinView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    self.jiezhangdandayinView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    // Do any additional setup after loading the view from its nib.
    self.xiadandayinView.layer.borderWidth = 1;
    self.xiadandayinView.layer.cornerRadius = 5;
    self.xiadandayinView.layer.masksToBounds = YES;
    
    self.yujiesuandayinView.layer.borderWidth = 1;
    self.yujiesuandayinView.layer.cornerRadius = 5;
    self.yujiesuandayinView.layer.masksToBounds = YES;
    
    self.jiezhangdandayinView.layer.borderWidth = 1;
    self.jiezhangdandayinView.layer.cornerRadius = 5;
    self.jiezhangdandayinView.layer.masksToBounds = YES;
    
    // print config  add by manman
    
    self.configPintInfo = [NSUserDefaults standardUserDefaults];
    self.xiaDanDaYinFiled.text = [self.configPintInfo objectForKey:KXiaDanPrint];

    self.yujiesuandayin.text = [self.configPintInfo objectForKey:KYuJieSuanPrint];
    self.jiezhangdandayin.text = [self.configPintInfo objectForKey:KJieZhangDanPrint];
    NSLog(@"xiaDanDaYinFiled:%@",self.xiaDanDaYinFiled.text);
    NSLog(@"yujiesuandayin.text:%@",self.yujiesuandayin.text);
     NSLog(@"self.xiaDanDaYinFiled.text:%@",self.xiaDanDaYinFiled.text);
    
    
    
    
    
    
    
    // end of line
    
    
}
- (IBAction)cancle:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"取消修改" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
    
}


-(void)OKButtonClick:(UIButton *)sender
{
    
    
    [self.configPintInfo setObject:self.xiaDanDaYinFiled.text forKey:KXiaDanPrint ];
    [self.configPintInfo setObject:self.yujiesuandayin.text forKey:KYuJieSuanPrint ];
    [self.configPintInfo setObject:self.jiezhangdandayin.text forKey:KJieZhangDanPrint ];//
    NSLog(@"xiaDanDaYinFiled:%@",self.xiaDanDaYinFiled.text);
    NSLog(@"yujiesuandayin.text:%@",self.yujiesuandayin.text);
    NSLog(@"self.xiaDanDaYinFiled.text:%@",self.xiaDanDaYinFiled.text);
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"修改成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 数字键盘   wjy
- (void)numberKeyBoardInput:(NSInteger) number
{
    if (self.isBeingEditingTextField.text.length >10) {
        return;
        
    }
    //    DebugLog(@"string number : %d",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",self.isBeingEditingTextField.text,(long)number];
        self.isBeingEditingTextField.text = textString;
    }if (number == 11) {
        if (self.isBeingEditingTextField.text.length==0) return;
        if (self.isBeingEditingTextField.text.length==10)return;
        
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",self.isBeingEditingTextField.text];
        self.isBeingEditingTextField.text = textString;
        
        
        
    }
    //手机号不让输入.
    //    if (number == 10) {
    //
    //        if (self.isBeingEditingTextField.text.length==0)return;
    //
    //        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",self.isBeingEditingTextField.text];
    //        self.isBeingEditingTextField.text = textString;
    //
    //    }
    if (number == 12) {
        
        if (self.isBeingEditingTextField.text.length==0) return;
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",self.isBeingEditingTextField.text];
        self.isBeingEditingTextField.text = textString;
        
        
        
    }
}

- (void)xiaqufangfa{
    
    [self.view endEditing:YES];
}

- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", self.isBeingEditingTextField.text];
    
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    self.isBeingEditingTextField.text = mutableString;
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    self.isBeingEditingTextField = textField;
    
}



- (void)numberKeyBoardFinish
{
    
    [self.xiaDanDaYinFiled resignFirstResponder];
    [self.yujiesuandayin resignFirstResponder];
    [self.jiezhangdandayin resignFirstResponder];

    
}

- (void)bgButtonClick27703784131
{
    [self.xiaDanDaYinFiled resignFirstResponder];
    [self.yujiesuandayin resignFirstResponder];
    [self.jiezhangdandayin resignFirstResponder];
    
    
    
}


- (void) numberKeyBoardShou{
    [self xiaqufangfa];
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
