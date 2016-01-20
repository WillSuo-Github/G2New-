//
//  CashChangeViewController.m
//  G2TestDemo
//
//  Created by ws on 15/11/27.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "CashChangeViewController.h"
#import "SuperSuccessViewController.h"
#import "DXKeyboard.h"

@interface CashChangeViewController ()<DXKeyboardDelegate>
@property (strong,nonatomic)SuperSuccessViewController *superSuccessViewController;


@property (nonatomic, strong) DXKeyboard *keyBoard;

@end

@implementation CashChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    


    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 60)];
    //    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    //[rightBtn setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];

    [leftBtn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    //.image=[UIImage imageNamed:@"right_button.png"];
    leftBtn.tintColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
    [leftBtn addTarget:self action:@selector(leftBtnCLick:) forControlEvents:UIControlEventTouchUpInside];

    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
    [leftBtn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];

    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *titleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    [titleButton setTitle:@"现金支付" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont systemFontOfSize:21];
    titleButton.userInteractionEnabled = NO;
    [titleButton setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];

    self.navigationItem.titleView = titleButton;


    DXKeyboard  *jianpanView = [[DXKeyboard alloc]initWithFrame:CGRectMake(0, 300, 1024, 412)];
    jianpanView.delegate = self;
    [_inputCashTextField setInputView:jianpanView];

    self.keyBoard = jianpanView;
    [_inputCashTextField setBorderStyle:UITextBorderStyleRoundedRect];



    
    
}


-(void)leftBtnCLick:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)rightButtonClick:(UIButton *)sender
{
    
    if (self.inputCashTextField.text.length == 0)
    {
        [self showAlertViewMessage:@"请输入消费金额！"];
        return;
    }
    else
    {
        if (self.inputCashTextField.text.integerValue == 0)
        {
            [self showAlertViewMessage:@"请输入正确消费金额！"];
            return;
        }
        
    }
    self.superSuccessViewController = [[SuperSuccessViewController alloc]init];
    ZhiFuChuanDiPG *zhifuchuanDi = [[ZhiFuChuanDiPG alloc]init];
    zhifuchuanDi.PayType = self.zhiFuChuanDiPG.PayType;
    zhifuchuanDi.paymentType = self.zhiFuChuanDiPG.paymentType;
    zhifuchuanDi.billID = self.zhiFuChuanDiPG.billID;
    //zhifuchuanDi.count = self.zhiFuChuanDiPG.count;
    // 现在 这个界面可以更改 消费金额
    zhifuchuanDi.count = self.inputCashTextField.text;
    zhifuchuanDi.RealCount = self.inputCashTextField.text;
    zhifuchuanDi.whereFrom = self.zhiFuChuanDiPG.whereFrom;
    zhifuchuanDi.orderNo = self.zhiFuChuanDiPG.orderNo;
    zhifuchuanDi.cptID = self.zhiFuChuanDiPG.cptID;
    zhifuchuanDi.tabID = self.zhiFuChuanDiPG.tabID;
    zhifuchuanDi.paymentType = self.zhiFuChuanDiPG.paymentType;
    self.superSuccessViewController.zhiFuChuanDiPG= zhifuchuanDi;
    [self.navigationController pushViewController:self.superSuccessViewController animated:YES];
    
}




#pragma mark -- 自定义键盘
/**
 *  键盘  数字按键
 *
 */
- (void)numberKeyBoardInput:(NSInteger) number
{
    //    DebugLog(@"string number : %d",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",_inputCashTextField.text,(long)number];
        _inputCashTextField.text = textString;
    }if (number == 11) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",_inputCashTextField.text];
        _inputCashTextField.text = textString;
    }if (number == 10) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",_inputCashTextField.text];
        _inputCashTextField.text = textString;
    }if (number == 12) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",_inputCashTextField.text];
        _inputCashTextField.text = textString;
        
        
    }
}


/**
 *  自定义键盘  删除  按键
 */
- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", _inputCashTextField.text];
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    _inputCashTextField.text = mutableString;
}

/**
 *  键盘  确认输入键
 */
- (void)numberKeyBoardFinish
{
    //    DebugLog(@"finished.......");
    [_inputCashTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  键盘   键盘 回收按键
 */
- (void) numberKeyBoardShou
{
    [self setEditingEnd ];
}




-(void)showAlertViewMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}
- (void)setEditingEnd{
    [self.view endEditing:YES];
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
