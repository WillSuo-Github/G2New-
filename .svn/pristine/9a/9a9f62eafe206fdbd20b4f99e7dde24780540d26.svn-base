//
//  CardRechargeController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "CardRechargeController.h"
#import "ErweimaController.h"
#import "DXKeyboard.h"

@interface CardRechargeController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DXKeyboardDelegate>


@property (weak, nonatomic) IBOutlet UIButton *quxaio;
@property (weak, nonatomic) IBOutlet UIButton *queding;
@property (weak, nonatomic) IBOutlet UIButton *fukuanfangshi;
@property(strong,nonatomic)UITableView *fukuanfangshiView;
@property (weak, nonatomic) IBOutlet UILabel *xianshishiijan;


@property (weak, nonatomic) IBOutlet UITextField *chongzhijineTextField;
@property (weak, nonatomic) IBOutlet UITextField *shihoujineTextField;
@property (weak, nonatomic) IBOutlet UITextField *fukuanfangshiTextField;
@property (weak, nonatomic) IBOutlet UIButton *invoiceYes;
@property (weak, nonatomic) IBOutlet UIButton *invoiceNo;




@property (strong, nonatomic)UITextField *isBeingEditingTextField;

@end

@implementation CardRechargeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //WHC
    self.yueLable.text = self.yue;
    self.jifenLable.text =self.jifen;
    
    DXKeyboard *jianpanView = [[DXKeyboard alloc] init];
    jianpanView.delegate = self;
    self.chongzhijineTextField.delegate=self;
    [self.chongzhijineTextField setInputView:jianpanView];

    
    // Do any additional setup after loading the view from its nib.
    self.quxaio.layer.cornerRadius=5;
    self.queding.layer.cornerRadius=5;
    self.quxaio.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.queding.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    [self.quxaio setTitleColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1 ] forState:UIControlStateNormal];
    [self.queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self setUpTableView];
    
    self.chongzhijineTextField.delegate = self;

    // add by manman
    
    // 发票 是否
    
    [self.invoiceNo addTarget:self action:@selector(invoiceNoClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.invoiceYes addTarget:self action:@selector(invoiceYesClick:) forControlEvents:UIControlEventTouchUpInside];
    self.invoiceNo.selected = YES;// 默认 否
    
    
    
    
    // end of line
    
    
    
    
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd    HH:mm:SS"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    self.xianshishiijan.text=locationString;
    
    NSLog(@"locationString:%@",locationString);
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.fukuanfangshiView.hidden=YES;
    
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.fukuanfangshiView.hidden=YES;

}
- (void)setUpTableView{
    

    
    UITableView *tableview=[[UITableView alloc]init];
    tableview.hidden=YES;
    tableview.delegate=self;
    tableview.dataSource=self;

    tableview.frame = CGRectMake(self.fukuanfangshi.x, self.fukuanfangshi.y + 30, self.fukuanfangshi.width, 30 * 4);
    tableview.layer.borderWidth=1;
    tableview.layer.borderColor=[UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1].CGColor;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.tableFooterView=[[UITableView alloc]init];
    self.fukuanfangshiView=tableview;
    [self.view addSubview:tableview];
    
    
    
}
- (IBAction)zhifubutton:(id)sender {
    
    self.fukuanfangshiView.hidden=NO;
}

- (void)HiddenOtherWithOneTable:(UITableView *)tableView{
    
    
    self.fukuanfangshiView.hidden = YES;
    tableView.hidden = NO;
}

-(void)invoiceNoClick:(UIButton *)sender
{
    if (sender.selected == YES) {
        sender.selected = NO;
        
    }else
    {
        if (self.invoiceYes.selected ==YES)
        {
            sender.selected = YES;
            self.invoiceYes.selected =NO;
        }
        else
              sender.selected = YES;
        
    }
    
    
    
}


-(void)invoiceYesClick:(UIButton *)sender
{
    if (sender.selected == YES)
    {
        sender.selected = NO;
        
    }else
    {
        if (self.invoiceNo.selected ==YES)
        {
            sender.selected = YES;
            self.invoiceNo.selected =NO;
        }
        else
            sender.selected = YES;
        
    }
    
    
    
    
}



- (IBAction)queding:(id)sender {
    
//    
//    RechargeRecordViewController *rechargeRecord = [[RechargeRecordViewController alloc] init];
//    _tmpVC = rechargeRecord;
//    rechargeRecord.mcid = self.mcid;
//    rechargeRecord.view.frame = self.contentView.bounds;
    
    if (![self.chongzhijineTextField.text floatValue]) {
        [self showAlertViewWithMessage:@"金额输入错误"];
        return;
    }
    if (![self.shihoujineTextField.text floatValue]) {
        [self showAlertViewWithMessage:@"金额输入错误"];
        return;
    }
   
    
    if ([_delegate respondsToSelector:@selector(CardRechargeControllerDidChickQueDing:WithCount:WithPayType:)]) {
//        NSLog(@"wwwwww%@,se")
        [self.delegate CardRechargeControllerDidChickQueDing:self WithCount:self.shihoujineTextField.text.floatValue WithPayType:self.fukuanfangshi.titleLabel.text];
    }
    
}
- (IBAction)quxiao:(id)sender {
    
    
    if ([_delegate respondsToSelector:@selector(CardRechargeControllerDidChickQuXiao:)]) {
        [self.delegate CardRechargeControllerDidChickQuXiao:self];
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return 5 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"现金";
                break;
            case 1:
                cell.textLabel.text = @"刷卡";
                break;
            case 2:
                cell.textLabel.text = @"微信";
                break;
            case 3:
                cell.textLabel.text = @"支付宝";
                break;
            case 4:
            default:
                break;
                
                

        
}
    
    
cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.textColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 30;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";//MenuCell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    
    
        self.fukuanfangshiView.hidden =YES;
        [self.fukuanfangshi setTitle:cell.textLabel.text forState:UIControlStateNormal];

        switch (indexPath.row) {
            case 0:
                [self.fukuanfangshi setTitle:@"现金" forState:UIControlStateNormal];
                
                break;
            case 1:
                
                [self.fukuanfangshi setTitle:@"刷卡" forState:UIControlStateNormal];
                break;
            case 2:
                
                [self.fukuanfangshi setTitle:@"微信支付" forState:UIControlStateNormal];
                break;
            case 3:
                
                [self.fukuanfangshi setTitle:@"支付宝" forState:UIControlStateNormal];
                break;
            case 4:
                        default:
                break;
        

    }
   

}

- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - textField的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    self.shihoujineTextField.text = textField.text;
}

#pragma mark -- 数字键盘
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
    [self.chongzhijineTextField resignFirstResponder];

}

- (void)bgButtonClick27703784131
{
    [self.chongzhijineTextField resignFirstResponder];
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
