//
//  CreatReserveController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
#import "CreatReserveController.h"
#import "CreatReservePg.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "YuDingDatePickController.h"
#import "PayType.h"
#import "SaveOrderViewController.h"
#import "DeskState.h"
#import "ZhiFuViewController.h"
#import "DXKeyboard.h"
#import "ZhiFuChuanDiPG.h"

#define kAlpha   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"

@interface CreatReserveController ()<UITableViewDelegate,UITableViewDataSource,YuDingDatePickControllerDelegate,DXKeyboardDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *yudingren;
@property (weak, nonatomic) IBOutlet UITextField *yudingshijian;
@property (weak, nonatomic) IBOutlet UITextField *lianxidianhua;
@property (weak, nonatomic) IBOutlet UIButton *cantaiBtn;
//@property(strong,nonatomic)IBOutlet UIButton *fukuanfangshiBTN;
@property (weak, nonatomic) IBOutlet UITextField *beiyongdianhua;
@property (weak, nonatomic) IBOutlet UITextField *yudingyajin;
@property (weak, nonatomic) IBOutlet UITextField *jiucanrenshu;
@property (weak, nonatomic) IBOutlet UITextView *beizhu;
//时间
@property (weak, nonatomic) IBOutlet UIButton *shijianBtn;


@property (nonatomic, strong) UIPopoverController *popVc;
@property (nonatomic, strong) NSMutableArray *PayTypeArr;


@property (nonatomic, strong) SaveOrderViewController *saveOrderVc;

@property (nonatomic, strong) DXKeyboard *keyBoard;

@property (nonatomic, strong) NSString *tabID;
@property (nonatomic, copy) NSString *orderNo;


//添加就餐人数 wjy
//@property(strong,nonatomic)UITextField *peopleNum;


//支付方式
@property (weak, nonatomic) IBOutlet UIButton *fukuanbutton;

@property(strong,nonatomic)NSMutableArray *payTypeMArray;

//@property(strong,nonatomic)NSString *zhifufangshi;

@property(strong,nonatomic)UITableView *booklaiyuan;
@property (weak, nonatomic) IBOutlet UIButton *quxiao;
@property (weak, nonatomic) IBOutlet UIButton *queding;
@property (strong,nonatomic) NSMutableArray *bookType;

//修改餐桌被预定时 页面不跳转 王京阳
@property(strong,nonatomic)NSString *message;
@property(strong,nonatomic)NSString *statusCode;

@property (strong, nonatomic)UITextField *isBeingEditingTextField;
@end
@implementation CreatReserveController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.yudingren.delegate=self;
    //self.lianxidianhua.delegate=self;
   
    self.quxiao.layer.cornerRadius=5;
    self.queding.layer.cornerRadius=5;
    self.quxiao.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];

    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"MM-dd HH:mm:ss"];//yyyy-MM-dd HH:mm:ss
    NSString *str = [outputFormatter stringFromDate:date];
   // NSLog(@"time:%@",str);
//    NSString *shijianButtonTitle = [NSString stringWithFormat:@"%@",str];
    
    
//时间
    [self.shijianBtn setTitle:str forState:UIControlStateNormal];
    [self.shijianBtn setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ] forState:UIControlStateNormal];
    [self.fukuanbutton setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ] forState:UIControlStateNormal];
    
    
// Do any additional setup after loading the view from its nib.
    
        //设置各个button的圆角和边框
    [self setUpBtnRadiusBorderWithBtn:self.shijianBtn];
//    [self setUpBtnRadiusBorderWithBtn:self.fukuanfangshiBTN];
    [self setUpBtnRadiusBorderWithBtn:self.cantaiBtn];
    
//支付方式
    
    [self setUpBtnRadiusBorderWithBtn:self.fukuanbutton];
    [self getPayTypeDataSource];
    
    
//设置备注框的圆角和边框
    self.beizhu.layer.borderWidth = 1;
    self.beizhu.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    self.beizhu.layer.cornerRadius = 5;
    [self setUpTableView];
//支付方式框
    self.fukuanbutton.layer.borderWidth=1;
    self.fukuanbutton.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    self.fukuanbutton.layer.cornerRadius=5;
    self.fukuanbutton.layer.masksToBounds=YES;
   
//下拉菜单框
    self.booklaiyuan.layer.borderWidth=0.1;

    self.booklaiyuan.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
//    self.daoqibaoliuView.layer.masksToBounds = YES;
//    self.daoqibaoliu.tag=3;
//    self.daoqibaoliu.delegate=self;
//
    //设置输入键盘
    DXKeyboard *jianpanView = [[DXKeyboard alloc] init];
    jianpanView.delegate = self;
    self.lianxidianhua.tag=1;
    self.lianxidianhua.delegate = self;
    [_lianxidianhua setInputView:jianpanView];
 
//    self.keyBoard = jianpanView;
//    [_lianxidianhua setBorderStyle:UITextBorderStyleRoundedRect];


    
    self.beiyongdianhua.delegate = self;
    [_beiyongdianhua setInputView:jianpanView];
    [_beiyongdianhua setBorderStyle:UITextBorderStyleRoundedRect];
        
//就餐人数和预定押金使用数字键盘   WJY
    
    self.jiucanrenshu.delegate = self;
    [self.jiucanrenshu setInputView:jianpanView];
    [self.jiucanrenshu setBorderStyle:UITextBorderStyleRoundedRect];
    
    self.yudingyajin.delegate = self;
    [self.yudingyajin setInputView:jianpanView];
    [self.yudingyajin setBorderStyle:UITextBorderStyleRoundedRect];



    /**
     *  接受选择餐桌界面返回的id
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTableID:) name:KyudingTiaoxuanzhuo object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancle:) name:@"YudingMessage" object:nil];
    
    
    
}

- (void)setUpBtnRadiusBorderWithBtn:(UIButton *)btn{
    
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
}

- (void)getTableID:(NSNotification *)note{
    
//    NSLog(@"%@",note);
    DeskState *deskS = note.userInfo;
    [self.cantaiBtn setTitle:deskS.tabNo forState:UIControlStateNormal];
    self.tabID = deskS.tabId;
   
}


- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:KyudingTiaoxuanzhuo];
}

- (void)setUpTableView{
    

    //预定来源（支付方式原来是方式）
    UITableView * tableView2=[[UITableView alloc]init];
    tableView2.tag=3;
    tableView2.delegate=self;
    tableView2.dataSource=self;
    tableView2.frame=CGRectMake(self.fukuanbutton.x, self.fukuanbutton.y+self.fukuanbutton.height, self.fukuanbutton.width, 44*3);
    tableView2.tableFooterView=[[UIView alloc]init];
    tableView2.layer.borderWidth=1;
    tableView2.layer.cornerRadius=5;
    tableView2.hidden=YES;
   self.booklaiyuan=tableView2;
    [self.view addSubview:tableView2];
    
    
}
- (IBAction)cantaiChick:(id)sender {
    
    SaveOrderViewController *saveOrder = [[SaveOrderViewController alloc] init];
    saveOrder.whereCome = @"预定";
    NSDate *date = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy"];
    NSString *str = [outputFormatter stringFromDate:date];
    
    saveOrder.bookTimeStr = [NSString stringWithFormat:@"%@-%@",str,self.shijianBtn.currentTitle];
    saveOrder.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    saveOrder.modalPresentationStyle = UIModalPresentationPageSheet;
    [kKeyWindow.rootViewController presentViewController:saveOrder animated:YES completion:nil];

}

- (IBAction)queding:(id)sender {
    
    
//    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getOrderNo?returnJson=json",ceshiIP];
    
//    NSLog(@" OK ...");
//    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//   NSLog(@"%@",[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    if (!self.yudingren.text.length)
    {
        [self showAlertViewWithMessage:@"预订人不能为空"];
    }
    else if (!self.shijianBtn.titleLabel.text.length )
    {
        
        [self showAlertViewWithMessage:@"请选择时间"];
    }
    else if (!self.lianxidianhua.text.length)
    {
       
        [self showAlertViewWithMessage:@"联系电话不可为空"];
        
    }
    else if (self.lianxidianhua.text.length!=11)
    {
        
        [self showAlertViewWithMessage:@"请输入正确的联系电话"];
        
        
    }
    else if (!self.cantaiBtn.titleLabel.text.length)
    {
        
        [self showAlertViewWithMessage:@"请选择餐台"];
    }
    else if (self.jiucanrenshu.text.integerValue>99)
    {
        
        [self showAlertViewWithMessage: @"就餐人数1-99人"];
    }
//    else if (self.message.length)
//    {
//        
//        [self showAlertViewWithMessage: @"从新选择餐台"];
//    }

    else
    {
        //押金
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getOrderNo?returnJson=json",ceshiIP];
        //NSLog(@"%@",urlStr);
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
            
            NSLog(@"%@",responseObject);
            self.orderNo = [responseObject objectForKey:@"orderNo"];
            [self isneedToPay];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}


//- (void)requestZhiFuLeiXing:(NSNotification *)note{
//    
//    NSString *urlStr  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getpaymentTypes",ceshiIP];
//    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}


- (void)startYuDing:(NSNotification *)note{
    
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/create",ceshiIP];
    NSDate *date = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy"];
    NSString *str = [outputFormatter stringFromDate:date];
    
    CreatReservePg *pg = [[CreatReservePg alloc] init];
    pg.orderPeopleName = self.yudingren.text;
//    NSLog(@"str:%@",str);
//    NSLog(@"time:%@",self.shijianBtn.titleLabel.text);
    
    pg.orderTimeStr = [NSString stringWithFormat:@"%@-%@:00",str,self.shijianBtn.titleLabel.text];
    NSMutableString *mStr  = [NSMutableString stringWithFormat:@"%@",pg.orderTimeStr];
//     NSLog(@"modify before :%@",mStr);

//    NSRange tmpRang = [mStr rangeOfString:@" " options:NSBackwardsSearch];
//    if (tmpRang.location) {
//        [mStr deleteCharactersInRange:tmpRang];
//        pg.orderTimeStr = mStr;
//        
//    }
   
//    NSLog(@"time:%@",pg.orderTimeStr);
    pg.Telphone = self.lianxidianhua.text;
//    pg.tabNo = self.cantai.text;
    pg.tabNo = self.cantaiBtn.titleLabel.text;
    pg.Prepay = self.yudingyajin.text;
    pg.Notes = self.beizhu.text;
    

    

    //添加就餐人数  wjy
    pg.peopleNum=self.jiucanrenshu.text;
   // NSLog(@"就餐人数%@",pg.peopleNum);
    
      NSLog(@"book type :%@",self.fukuanbutton.currentTitle);
    if ([self.fukuanbutton.currentTitle isEqualToString:@"电话预定"]) {
        NSLog(@"电话预定");
        
        pg.orderWay = @"1";
    }
    if ([self.fukuanbutton.currentTitle isEqualToString:@"到店预定"]) {
        pg.orderWay = @"2";
          NSLog(@"到店预定");
    }
    if ([self.fukuanbutton.currentTitle isEqualToString:@"云餐厅预定"]) {
        pg.orderWay = @"3";
          NSLog(@"云餐厅预定");
    }
    
    
    NSMutableDictionary *dict = pg.mj_keyValues;
    [dict setObject:self.tabID forKey:@"table.tabId"];
    if (note.userInfo) {

        [dict setObject:note.userInfo forKey:@"paymentType.cptId"];
    }
    
    [HttpTool POST:urlStr parameters:dict success:^(id responseObject) {

        //DLog(@"%@",responseObject);
    
        
        //当餐台被预定时页面不跳转statusCode=800 选桌失败     王京阳
        self.message=[responseObject objectForKey:@"message"];
        self.statusCode=[responseObject objectForKey:@"statusCode"];
        
        //NSLog(@"----------%@",self.message);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:self.message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil , nil];
        alert.tag = 10;
        [alert show];
        
      //  [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (void)isneedToPay{
    
    if (self.yudingyajin.text.length) {
        
        ZhiFuViewController *zhifuVc = [ZhiFuViewController sharedZhiFuViewController];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:zhifuVc];
        ZhiFuChuanDiPG *chuandiPg = [[ZhiFuChuanDiPG alloc] init];
        chuandiPg.count = self.yudingyajin.text;
        chuandiPg.whereFrom = @"预定";
        chuandiPg.orderNo = self.orderNo;
        zhifuVc.chuandiPG = chuandiPg;
        
//        zhifuVc.count = self.yudingyajin.text;
//        zhifuVc.whereFrom = @"预定";
        nav.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        nav.modalPresentationStyle = UIModalPresentationPageSheet;
        [kKeyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startYuDing:) name:KzhifuSuccess object:nil];
    }else{
        
        [self startYuDing:nil];
    }
}



//支付方式接口
//-(void)getPayTypeDataSource
//{
//    
//    self.payTypeMArray = [[NSMutableArray alloc]initWithCapacity:10];
//    
//    NSString *urlStr  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getpaymentTypes?returnJson=json",ceshiIP];
//    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//        
//                NSLog(@"------%@",responseObject);
//        NSArray *arr = [responseObject objectForKey:@"paymentTypes"];
//        //        NSLog(@"%@",arr);
//        self.payTypeMArray = [PayType objectArrayWithKeyValuesArray:arr];
//        //支付方式数组  在此处排序
//        
//        
//        NSLog(@"1   count:%ld",self.payTypeMArray.count);
//        //  [self.PayTypeArr objectAtIndex:2]removeObject:<#(nonnull id)#>
//        [self.payTypeMArray removeObject:[self.payTypeMArray objectAtIndex:2]];
//        
//        
//        NSLog(@" 2  count:%ld",self.payTypeMArray.count);
//        
//        //        NSLog(@"%@",self.PayTypeArr);
//        [self.zhifuView reloadData];
//        
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}


//预定来源接口
-(void)getPayTypeDataSource
{

    self.payTypeMArray = [[NSMutableArray alloc]initWithCapacity:10];

    NSString *urlStr  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getorderWayList?returnJson=json",ceshiIP];
    
    NSLog(@"---------%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {

               NSLog(@"****************%@",responseObject);
        NSArray *tmpArr = [responseObject objectForKey:@"orderWayList"];
        self.bookType = [[NSMutableArray alloc]initWithCapacity:4];
        
        for (NSDictionary *dic in tmpArr) {
            NSString *tmpStr = [dic objectForKey:@"bciDesc"];
            [self.bookType addObject:tmpStr];
            
        }
        
        NSLog(@"test BCIDESC:%@",self.bookType);
        
        
        self.bookType = [PayType objectArrayWithKeyValuesArray:tmpArr];
            [self.booklaiyuan reloadData];

        
        
    
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (IBAction)fukuangfangshiChick:(id)sender {
    
  [self hiddenTableViewWith:self.booklaiyuan];
    
}



- (IBAction)shijianChick:(UIButton *)sender {
    [self xiaqufangfa];
    [self.view endEditing:YES];
    
    [self.popVc presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    
    
}

- (void)hiddenTableViewWith:(UITableView *)tableView{
    

    self.booklaiyuan.hidden=YES;
//    self.fukuanfangshiTableView.hidden = YES;
    tableView.hidden = NO;
    
}



- (IBAction)cancle:(id)sender {
    
    [self.view removeFromSuperview];
    
    [self.delegate ChangeLabelText];
    
    if ([self.delegate respondsToSelector:@selector(CreatReserveControllerDidDismiss:)]) {
        
        [self.delegate CreatReserveControllerDidDismiss:self];
    } 
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.booklaiyuan.hidden=YES;
    
}


#pragma mark - tableView的代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        
        return self.bookType.count;

}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"Cell";//MenuCell
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
   
//    PayType *payType = self.payTypeMArray[indexPath.row];
////    NSLog(@"number:%ld%@",indexPath.row,payType.paymentTypeDesc);
//    cell.textLabel.text = [NSString stringWithFormat:@"%@",payType.paymentName];
//    cell.textLabel.font = [UIFont systemFontOfSize:13];
//    cell.backgroundColor=[UIColor whiteColor];//背景颜色
//    cell.textLabel.textColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];//字体颜色
//     cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    PayType *payType = self.bookType[indexPath.row];
    //    NSLog(@"number:%ld%@",indexPath.row,payType.paymentTypeDesc);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",payType.bciDesc];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.backgroundColor=[UIColor whiteColor];//背景颜色
    cell.textLabel.textColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];//字体颜色
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // modify by manman for start of line
    // 获得 预定来源
    
    NSLog(@"预定来源:%@",cell.textLabel.text);
    
    
    
    // end of line
      [self.fukuanbutton setTitle:cell.textLabel.text forState:UIControlStateNormal];
      self.booklaiyuan.hidden = YES;
    
    
}
//
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    
//    NSLog(@"test method");
//
//    if (textField==self.lianxidianhua) {
//        if (textField.text.length > 11) {
//            
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"1111111" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//            [alertView show];
//
//            
//            return NO;
//        }
//    }
//    
//
//    return YES;
//
//}

#pragma mark -- 数字键盘
//- (void)numberKeyBoardInput:(NSInteger) number
//{
//    //    DebugLog(@"string number : %d",number);
//    if (number <= 9 && number >= 1) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",_lianxidianhua.text,(long)number];
//        _lianxidianhua.text = textString;
//    }if (number == 11) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",_lianxidianhua.text];
//        _lianxidianhua.text = textString;
//    }if (number == 10) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",_lianxidianhua.text];
//        _lianxidianhua.text = textString;
//        }if (number == 12) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",_lianxidianhua.text];
//        _lianxidianhua.text = textString;
//    }
//}
//- (void)numberKeyBoardInput:(NSInteger) number
//{
//    if (self.isBeingEditingTextField.text.length >10) return;
//    
//    if (number <= 9 && number >= 1) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",self.isBeingEditingTextField.text,(long)number];
//        self.isBeingEditingTextField.text =textString;
//    }if (number == 11) {
//        if (self.isBeingEditingTextField.text.length) {
//            return;
//        }
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%@",self.isBeingEditingTextField.text,@"00"];
//        self.isBeingEditingTextField.text = textString;//@"00";//textString;
//    }if (number == 10) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%@",self.isBeingEditingTextField.text,@"."];
//        self.isBeingEditingTextField.text = textString;
//    }if (number == 12) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%@",self.isBeingEditingTextField.text,@"0"];
//        self.isBeingEditingTextField.text = textString;
//    }
//    
//    
//    
//}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    self.isBeingEditingTextField = textField;
    
}

//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    
//    NSCharacterSet *cs;
//    
//    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlpha] invertedSet];
//    
//    
//    
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//    
//    
//    BOOL canChange = [string isEqualToString:filtered];
//    
//    
//    
//    return canChange;
//
//}


//- (void)xiaqufangfa{
//    [self.view endEditing:YES];
//}
//

#pragma mark - 键盘代理方法
//- (void)numberKeyBoardBackspace {
//    
//    
//    
//    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", self.isBeingEditingTextField.text];
//    
//    if ([mutableString length] >= 1) {
//        
//        
//        
//        NSRange tmpRange;
//        tmpRange.location = [mutableString length] - 1;
//        tmpRange.length = 1;
//        [mutableString deleteCharactersInRange:tmpRange];
//    }
//    self.isBeingEditingTextField.text = mutableString;
//
////    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", _lianxidianhua.text];
////     NSMutableString* mutableString1 = [[NSMutableString alloc] initWithFormat:@"%@", _beiyongdianhua.text];
////    
////    
////    if ([mutableString length] >= 1) {
////        NSRange tmpRange;
////        tmpRange.location = [mutableString length] - 1;
////        tmpRange.length = 1;
////        [mutableString deleteCharactersInRange:tmpRange];
////    }
////    _lianxidianhua.text = mutableString;
////    _beiyongdianhua.text=mutableString1;
////    
////    NSMutableString* mutableString1 = [[NSMutableString alloc] initWithFormat:@"%@", _beiyongdianhua.text];
////    if ([mutableString1 length] >= 1) {
////        NSRange tmpRange;
////        tmpRange.location = [mutableString1 length] - 1;
////        tmpRange.length = 1;
////        [mutableString1 deleteCharactersInRange:tmpRange];
////    }
////    _beiyongdianhua.text = mutableString1;
//}
//
//- (void)numberKeyBoardFinish
//{
//    //    DebugLog(@"finished.......");
//    [_lianxidianhua resignFirstResponder];
//    [_beiyongdianhua resignFirstResponder];
//}
//
//- (void)bgButtonClick27703784131
//{
//    [_lianxidianhua resignFirstResponder];
//    [_beiyongdianhua resignFirstResponder];
//}
//
//- (void) numberKeyBoardShou{
//    [self xiaqufangfa];
//}


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
        if (self.isBeingEditingTextField.text.length==10)return;
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",self.isBeingEditingTextField.text];

        self.isBeingEditingTextField.text = textString;

    }
//    if (number == 10) {
//        //不能入点
//        
//        if (self.lianxidianhua.text.length==0) return;
//        if (self.beiyongdianhua.text.length==0) return;
//        
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",self.isBeingEditingTextField.text];
//                self.isBeingEditingTextField.text = textString;
//        
//        //更改结束 wjy
//    }
    if (number == 12) {
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

- (void)numberKeyBoardFinish
{
    //    DebugLog(@"finished.......");
    [_lianxidianhua resignFirstResponder];
    [_beiyongdianhua resignFirstResponder];
    [self.jiucanrenshu resignFirstResponder];
    [self.yudingyajin resignFirstResponder];

    

}

- (void)bgButtonClick27703784131
{
    
    [_lianxidianhua resignFirstResponder];
    [_beiyongdianhua resignFirstResponder];
    [self.jiucanrenshu resignFirstResponder];
    [self.yudingyajin resignFirstResponder];

    

}
- (void) numberKeyBoardShou{
    [self xiaqufangfa];
}




#pragma mark - YuDingDatePickController的代理方法
- (void)YuDingDatePickControllerDidSelectDate:(NSString *)date AndString:(NSString *)wholeDateStr{
    
    //将日期转换为整形  王洪昌
//    [[[[NSMutableString  stringWithString:date] componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue];
//    [[[[NSMutableString stringWithString:date] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":-"]] componentsJoinedByString:@""] intValue];
    //获取当前时间  王洪昌
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MMddHHmm"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
//    NSLog(@"locationString%@",locationString);
//    NSLog(@"%@",date);
//    NSLog(@"wholeDateStr%d",[[[[NSMutableString stringWithString:date] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":- "]] componentsJoinedByString:@""] intValue]);
    
    if ([locationString intValue] > [[[[NSMutableString stringWithString:date] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":- "]] componentsJoinedByString:@""] intValue]) {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"日期选择错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    } else {
        [self.shijianBtn setTitle:date forState:UIControlStateNormal];
        [self.cantaiBtn setTitle:@"" forState:UIControlStateNormal];
       
    }
   
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - 弹框
- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - 弹出窗口的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10) {

        //当餐桌被预定是页面不变从新选择餐桌  王京阳
        if ([self.statusCode isEqualToString:@"800"]) {
            
            return;
        }else{
            [self cancle:nil];

        }
           // [self cancle:nil];
            
        
    }
     [[NSNotificationCenter defaultCenter] postNotificationName:@"update" object:nil];
}

#pragma mark - 初始化
- (UIPopoverController *)popVc{
    
    if (_popVc == nil) {
        
        YuDingDatePickController *datePick = [[YuDingDatePickController alloc] init];
        datePick.datePickerType = @"time";
        NSLog(@"------------%@",datePick.datePickerType);
        
        datePick.delegate = self;

        _popVc = [[UIPopoverController alloc] initWithContentViewController:datePick];
    }
       return _popVc;
}

- (NSMutableArray *)PayTypeArr{
    
    if (_PayTypeArr == nil) {
        _PayTypeArr = [NSMutableArray array];
    }
    return _PayTypeArr;
}
@end
