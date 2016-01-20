//
//  GuQingNumController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/14.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "GuQingNumController.h"
#import "DXKeyboard.h"
#import "CaiPG.h"
@interface GuQingNumController ()<DXKeyboardDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UIButton *queding1;
@property(strong,nonatomic)DXKeyboard *shuzijianpan;
@property (weak, nonatomic) IBOutlet UILabel *textFieldLabel;
//沽清菜名的修改   王洪昌 
//@property (weak, nonatomic) IBOutlet UILabel *caiming;
@property(strong,nonatomic)CaiPG*caipg;


/*
    自定义键盘
 
 */


@property (weak, nonatomic) IBOutlet UIView *keyboardView;

@property (weak, nonatomic) IBOutlet UIButton *oneButton;

@property (weak, nonatomic) IBOutlet UIButton *twoButton;

@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveButton;
@property (weak, nonatomic) IBOutlet UIButton *sixButton;
@property (weak, nonatomic) IBOutlet UIButton *sevenButton;
@property (weak, nonatomic) IBOutlet UIButton *pointButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *eightButton;
@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *nineButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@end

@implementation GuQingNumController

- (IBAction)queding:(id)sender {
    
    //modify by manman for start of line
    // 修改 沽清数量文本框为空时，提示沽清成功
    if (self.textField.text.length == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入沽清数量" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }

    // end of line
    
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([_delegate respondsToSelector:@selector(GuQingNumControllerDidChick:num:)]) {
        [self.delegate GuQingNumControllerDidChick:self num:self.textField.text];
    }
    
}
- (IBAction)cancle:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(guqingChahao:)]) {
        [self.delegate guqingChahao:self];
    }
       
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.caiming.textColor=[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    self.label1.layer.borderWidth=1;
    self.label1.layer.borderColor=[UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1].CGColor;
    self.label2.layer.borderWidth=1;
    self.label2.layer.borderColor=[UIColor colorWithRed:108/255.0 green:108/255.0 blue:108/255.0 alpha:1].CGColor;
    self.label3.textColor=[UIColor colorWithRed:151/255.0 green:151/255.0 blue:151/255.0 alpha:1];
    [self.queding1 setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    
    self.textFieldLabel.layer.borderWidth = 1;
    self.textFieldLabel.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    self.textFieldLabel.textColor = [UIColor lightGrayColor];
    
    
    
    
    [self.okButton addTarget:self action:@selector(queding:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.fourButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.fiveButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.sixButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.sevenButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.eightButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.nineButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.zeroButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.pointButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteButton addTarget:self action:@selector(numberBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    //[self.view addSubview: self.keyboardView];
    [self.textField setInputView:[[UIView alloc] init]];
    //[self.textField setInputView:self.keyboardView];

    
    self.textField.delegate = self;
    //菜名 属性传旨
    self.caiming.text = self.caimingStr;
    
    //self.textField.keyboardType = UIKeyboardTypeNumberPad;
    
//    self.shuzijianpan.delegate=self;
//    DXKeyboard *jianpan=[[DXKeyboard alloc]initWithFrame:CGRectMake(0, 10, 50, 10)];
//    
//    [self.view addSubview:jianpan];
    
    
    
    // Do any additional setup after loading the view from its nib.
}


//-(void) CustomNumberKeyboardInput:(NSInteger)digital;
- (void)numberBtn:(UIButton *)sender {
    
    
   
    
    NSLog(@"test sender :%ld",sender.tag);
    NSInteger number = sender.tag - 10;
    if(number <= 9 && number >= 0){
        if ([self.textField.text length]>=3) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"  message:@"输入长度应该小于3位"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            return;
            
        }
        if([self.textField.text length] == 2)
        {
            NSRange testRange = [self.textField.text rangeOfString:@"0"];
            if (testRange.length)
            {
                self.textField.text = @"";
                return;
            }
            
        }
        
        [self CustomNumberKeyboardInput:number];
        // modify by manman for start of line
        // 沽清数量 不可出现小数点
    }if (number == 11) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@",self.textField.text];
        self.textField.text = textString;
    }
    // end of line
    if (number == 12)
    {
        [self numberKeyBoardBackspace];
        return;
    }
}

- (void)CustomNumberKeyboardInput:(NSInteger) number
{
       // NSLog(@"string number : %ld",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString1 = [[NSMutableString alloc] initWithFormat:@"%@%ld",self.textField.text,(long)number];
        self.textField.text = textString1;
    }if (number == 0) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",self.textField.text];
         self.textField.text = textString;
    }
}



- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@",self.textField.text];
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    self.textField.text = mutableString;
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
