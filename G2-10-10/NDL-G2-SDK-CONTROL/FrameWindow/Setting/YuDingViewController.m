//
//  YuDingViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "YuDingViewController.h"
#import "HttpTool.h"
#import "yudingPG.h"
#import "MJExtension.h"
#import "DXKeyboard.h"
#import "NDLBusinessConfigure.h"
#import "NDLFrameworkHeader.h"



@interface YuDingViewController ()<DXKeyboardDelegate,UITextFieldDelegate>{
    
    NSString *ccdsId;
}
@property (weak, nonatomic) IBOutlet UITextField *yudingshijan;
@property (weak, nonatomic) IBOutlet UIView *yudingshijianView;

@property (weak, nonatomic) IBOutlet UITextField *suodingshijian;
@property (weak, nonatomic) IBOutlet UIView *suodingshijianView;
@property (weak, nonatomic) IBOutlet UITextField *daoqibaoliu;
@property (weak, nonatomic) IBOutlet UIView *daoqibaoliuView;

@property(strong,nonatomic)DXKeyboard *keyBoard;


@property (strong, nonatomic)UITextField *isBeingEditingTextField;

@property (weak, nonatomic) IBOutlet UIButton *quxaio;
@property (weak, nonatomic) IBOutlet UIButton *queding;

@property (weak, nonatomic) IBOutlet UILabel *yujingshijian;
@property (weak, nonatomic) IBOutlet UILabel *supingshijain;
@property (weak, nonatomic) IBOutlet UILabel *dapqi;
@property (weak, nonatomic) IBOutlet UILabel *fen1;
@property (weak, nonatomic) IBOutlet UILabel *fen2;
@property (weak, nonatomic) IBOutlet UILabel *fen3;
//label线的颜色
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label3;

@property (strong,nonatomic)NSUserDefaults *bookSettingInfo;

@end

@implementation YuDingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //字体颜色
    self.yujingshijian.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.supingshijain.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.dapqi.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    self.fen1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.fen2.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.fen3.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    
    self.yudingshijan.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    self.suodingshijian.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    self.daoqibaoliu.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    //取消textfield边框
    self.yudingshijan.layer.borderWidth=2;
    self.yudingshijan.layer.borderColor=[UIColor whiteColor].CGColor;
    self.suodingshijian.layer.borderWidth=2;
    self.suodingshijian.layer.borderColor=[UIColor whiteColor].CGColor;
    self.daoqibaoliu.layer.borderWidth=2;
    self.daoqibaoliu.layer.borderColor=[UIColor whiteColor].CGColor;
    
    //设置label的颜色
    self.label2.layer.borderWidth=1;
    self.lable1.layer.borderWidth=1;
    self.label3.layer.borderWidth=1;
    self.lable1.layer.borderColor=[UIColor colorWithRed:105/225.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    self.label2.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    self.label3.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    //取消确定按钮圆角
    self.quxaio.layer.cornerRadius=5;
    [self.quxaio setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
    
    self.queding.layer.cornerRadius=5;
    
    // Do any additional setup after loading the view from its nib.
    [self requestccdsId];
    
    self.yudingshijianView.layer.borderWidth = 1;
    self.yudingshijianView.layer.cornerRadius = 5;
    self.yudingshijianView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1].CGColor;
    self.yudingshijianView.layer.masksToBounds = YES;
    self.yudingshijan.tag = 1;
    self.yudingshijan.delegate = self;
    
    self.suodingshijianView.layer.borderWidth = 1;
    self.suodingshijianView.layer.cornerRadius = 5;
    self.suodingshijianView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1].CGColor;
    self.suodingshijianView.layer.masksToBounds = YES;
    self.suodingshijian.tag = 2;
    self.suodingshijian.delegate = self;
    
    self.daoqibaoliuView.layer.borderWidth = 1;
    self.daoqibaoliuView.layer.cornerRadius = 5;
    self.daoqibaoliuView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1].CGColor;
    self.daoqibaoliuView.layer.masksToBounds = YES;
    self.daoqibaoliu.tag=3;
    self.daoqibaoliu.delegate=self;
    
//    [self performSelector:@selector(readSetingInfo) withObject:nil afterDelay:1.0];
    self.bookSettingInfo = [NSUserDefaults standardUserDefaults];
    NSString *str = [self.bookSettingInfo objectForKey:KYuJingShiJian];
    if (str == NULL) str = @"";
    [self.yudingshijan setText:[NSString stringWithFormat:@"%@",str]];
    
    str = [self.bookSettingInfo objectForKey:KSuoDingShiJian];
    if (str == NULL) str = @"";
    self.suodingshijian.text = [NSString stringWithFormat:@"%@",str];
    str = [self.bookSettingInfo objectForKey:KDaoQiBaoLiu];
    if (str == NULL) str = @"";
    self.daoqibaoliu.text = [NSString stringWithFormat:@"%@",str];
    
    //导入系统键盘
    DXKeyboard *jianpanView=[[DXKeyboard alloc]initWithFrame:CGRectMake(0, 300, 1024, 412)];
    jianpanView.delegate=self;
    [self.yudingshijan setInputView:jianpanView];
    [self.suodingshijian setInputView:jianpanView];
    [self.daoqibaoliu setInputView:jianpanView];
    self.keyBoard=jianpanView;
    [self.yudingshijan setBorderStyle:UITextBorderStyleRoundedRect];
    [self.suodingshijian setBorderStyle:UITextBorderStyleRoundedRect];
    [self.daoqibaoliu setBorderStyle:UITextBorderStyleRoundedRect];
    
    
}


- (IBAction)queding:(id)sender {
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting/updateOrder",ceshiIP];
    yudingPG *yudingpg = [[yudingPG alloc] init];
    yudingpg.id = ccdsId;
    yudingpg.orderLockTime = self.suodingshijian.text;
    yudingpg.orderWarnTime = self.yudingshijan.text;
    yudingpg.orderExpireTime = self.daoqibaoliu.text;
    
    
    [HttpTool POST:urlStr parameters:yudingpg.keyValues success:^(id responseObject) {

        NSString *message = [responseObject objectForKey:@"message"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    } failure:^(NSError *error) {
        NSLog(@"YuDingViewController%@",error);
    }];
    
}
- (IBAction)cancle:(id)sender {
}


- (void)requestccdsId{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting?returnJson=json",ceshiIP];
    
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"commonSettingCashierDeskSetting"];
        ccdsId = [dict objectForKey:@"ccdsId"];
        
    } failure:^(NSError *error) {
        NSLog(@"YuDingViewController%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 自定义键盘

- (void)numberKeyBoardInput:(NSInteger) number
{
    
    NSLog(@"number%ld",number);
    
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",self.isBeingEditingTextField.text,(long)number];
       self.isBeingEditingTextField.text =textString;
    }if (number == 11) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",self.isBeingEditingTextField.text];
        self.isBeingEditingTextField.text = textString;
    }if (number == 10) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",self.isBeingEditingTextField.text];
        self.isBeingEditingTextField.text = textString;
    }if (number == 12) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",self.isBeingEditingTextField.text];
        self.isBeingEditingTextField.text = textString;
    }
    
    
    
}
- (void)xiaqufangfa{
    [self.view endEditing:YES];
}




//删除数字
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

- (void)numberKeyBoardFinish
{
    
    [self.yudingshijan resignFirstResponder];
    [self.suodingshijian resignFirstResponder];
    [self.daoqibaoliu resignFirstResponder];
    
}
- (void) numberKeyBoardShou{
    [self xiaqufangfa];
}

#pragma mark - textField 的代理方法
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    self.isBeingEditingTextField = textField;
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
