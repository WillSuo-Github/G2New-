//
//  ZhiFuViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/8.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ZhiFuViewController.h"
#import "ShouQuJinEController.h"
#import "HttpTool.h"
#import "PayType.h"
#import "MJExtension.h"
#import "XiaoFeiSuccessController.h"
#import "NewSwipingCardViewController.h"
#import "CashChangeViewController.h"
#import "ScanViewController.h"
@interface ZhiFuViewController ()<UITableViewDelegate,UITableViewDataSource,NewSwipingCardViewControllerDelegate,ScanViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ShouQuJinEController *shouquVC;
@property (weak, nonatomic) IBOutlet UIButton *huiyuankaBtn;
@property (weak, nonatomic) IBOutlet UIButton *youhuimaBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UIView *BtnView;


@property (nonatomic, strong) NSMutableArray *PayTypeArr;

@property(nonatomic,strong)NSMutableArray *tmpArray;


@property (strong, nonatomic) IBOutlet UIView *wrongView; //消费失败显示的视图
@property (strong, nonatomic) IBOutlet UITextView *wrongTextView;//消费失败显示的提示信息

@property (strong, nonatomic) IBOutlet UITextField *ticketTextField; //券输入框

@end

@implementation ZhiFuViewController
SingletonM(ZhiFuViewController)
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //WHC  充值界面 隐藏会员支付功能
    if (self.panDuanHiden) {
        self.youhuimaBtn.hidden = YES;
        self.huiyuankaBtn.hidden = YES;
    }
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.wrongView.hidden = YES;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIButton *price = [[UIButton alloc]init];
    [price setHeight:100.0f];
    //self.navigationItem.titleView.frame = CGRectMake(self.view.width/2, self.view.height/2 - 10, 50, 60);
    //self.navigationItem.titleView
    [price setTitle:[NSString stringWithFormat:@"￥%@",self.chuandiPG.count] forState:UIControlStateNormal];
    //price.textAlignment  = NSTextAlignmentCenter;
    
    //price.font = [UIFont systemFontOfSize:30];
     [price  setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 30 ]];
    [price setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
    [price setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    self.navigationItem.titleView = price;
    [self requestPayType];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZhiFuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
     self.view.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    self.BtnView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    self.btnViewBackgroundView.backgroundColor =  [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
}


- (void)setNavgation{
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 60)];
    
    //王洪昌 会员充值可返回按钮
    if (self.panDuanHiden) {
        [leftBtn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    }
    else{
       [leftBtn setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
    }
   
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
    [leftBtn sizeToFit];
    [leftBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}


- (IBAction)huiyuankazhifu:(id)sender {
    
    NSLog(@" huiyuankaBtn button :%ld",self.huiyuankaBtn.state);
     NSLog(@"youhuimaBtn button :%ld",self.youhuimaBtn.state);
    
    //1 标记为UIControlStateHighlighted
    //0 标记为UIControlStateNormal
    
   
    if (self.huiyuankaBtn.selected == YES)
        self.huiyuankaBtn.selected = NO;
    else
         self.huiyuankaBtn.selected = YES;
    
    if (self.youhuimaBtn.selected == YES)
    {
        self.huiyuankaBtn.selected = YES;
        self.youhuimaBtn.selected = YES;
    }
    
    
    
    
}

- (IBAction)youhuiquanzhifu:(id)sender {
    NSLog(@"2button :%ld",self.huiyuankaBtn.state);
    NSLog(@"2button :%ld",self.youhuimaBtn.state);
    

    
    
  
    if (self.youhuimaBtn.selected == YES )
        self.youhuimaBtn.selected = NO;
    else
        self.youhuimaBtn.selected = YES;
    
    if (self.huiyuankaBtn.selected == YES)
    {
        self.youhuimaBtn.selected = YES;
        self.huiyuankaBtn.selected = NO;
    }
//    self.youhuimaBtn.selected = YES;
//    self.huiyuankaBtn.selected = NO;
    
}

- (void)setButton{
    
    for (UIView *view in self.BtnView.subviews) {
        [view removeFromSuperview];
    }
    // 现在将 现金 按键金额  精确到元
   // CGFloat jine1 = self.chuandiPG.count.floatValue;
    NSInteger jine1 =  self.chuandiPG.count.integerValue;
    NSInteger jine2 = 0;
    NSInteger jine3 = 0;
    NSString *jine4;
    NSString *jine5;
    NSInteger count = self.chuandiPG.count.integerValue;
    if ((count % 10) < 5) {
        
        jine2 = (count / 5 + 1) * 5;
        jine3 = (count / 10 + 1) * 10;
//        jine4 = (count / 50 + 1) * 50;
        jine4 = [NSString stringWithFormat:@"%ld",(count / 100 + 1) * 100];
        jine5 = @"其它";
    }else{
        
        jine2 = (count / 10 + 1) * 10;
//        jine3 = (count / 50 + 1) * 50;
        jine3 = (count / 100 + 1) * 100;
        jine4 = @"其它";
    }
    NSMutableArray *numArr = [NSMutableArray arrayWithObjects:@(jine1),@(jine2),@(jine3),jine4,jine5, nil];
    
    CGFloat BtnX;
    CGFloat BtnY = 0;
    CGFloat BtnW = 100;
    CGFloat BtnH = 67;
    CGFloat margin;
    NSInteger btnNum;
    if ((count % 10) < 5) {
        btnNum = 5;
    }else{
        
        btnNum = 4;
    }
    margin = (self.BtnView.width - btnNum * BtnW) / (btnNum - 1);
    for (int i = 0; i < btnNum; ++i) {
        
        UIButton *btn = [[UIButton alloc] init];
        BtnX = i * (BtnW + margin);
        btn.frame = CGRectMake(BtnX, BtnY, BtnW, BtnH);
        //btn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];

        btn.backgroundColor = [UIColor whiteColor];
        
        [btn setTitleColor:[UIColor colorWithRed:70/255.0 green:128/255.0 blue:218/255.0 alpha:1] forState:UIControlStateNormal];
        NSString *titleStr = [NSString stringWithFormat:@"%@%@",@"￥",numArr[i]];
        
        // 数字和汉字  同一字号  显示效果  汉字比数字大
        
        [btn setTitle:titleStr forState:UIControlStateNormal];
        btn.titleLabel.font =  [UIFont systemFontOfSize: 23 ];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
        
        if ([btn.titleLabel.text isEqualToString:@"￥其它"]) {
           
            [btn setTitle:@"其它" forState:UIControlStateNormal];
            btn.titleLabel.font =  [UIFont systemFontOfSize: 20 ];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置title的字体居中
            [btn addTarget:self action:@selector(otherCrashButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        //[btn setImage:[UIImage imageNamed:@"RMB2"] forState:UIControlStateNormal];
        
    
//        btn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
        if (![btn.titleLabel.text isEqualToString:@"其它"]) {
            [btn addTarget:self action:@selector(xianjinChick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5;
        btn.layer.borderColor = [[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:1.0]CGColor];
        btn.layer.masksToBounds = YES;
        [self.BtnView addSubview:btn];
    }
    
}
//现金支付
- (void)xianjinChick:(UIButton *)btn{
    
    NSLog(@"button title:%@.2f",btn.titleLabel.text);
    NSString *priceButtonStr = [btn.titleLabel.text stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    NSLog(@"test price :%@",priceButtonStr);
    
    
    XiaoFeiSuccessController *xiaofeiVc = [[XiaoFeiSuccessController alloc] init];
    
    
    
    
    
    ZhiFuChuanDiPG *chuandiPg = [[ZhiFuChuanDiPG alloc] init];
    chuandiPg.paymentType = @"1";
    DLog(@"%@",chuandiPg.paymentType);
    chuandiPg.billID = self.chuandiPG.billID;
    
    chuandiPg.idIdentifyStr = self.chuandiPG.idIdentifyStr;
    
    
    //修改找零  问题
    // 找零  属性更换为 remainChangeRMB   wjy
    
    //chuandiPg.remainChangeRMB = [NSString stringWithFormat:@"%ld",(priceButtonStr.integerValue - self.chuandiPG.count.integerValue)];//金额显示  导航条 标题
    
    chuandiPg.count = [NSString stringWithFormat:@"%f",(priceButtonStr.integerValue - self.chuandiPG.count.floatValue)];//金额显示  导航条 标题
    
   // chuandiPg.count = self.chuandiPG.count;
    //chuandiPg.count = //[NSString stringWithFormat:@"%@",priceButtonStr];
    // end of line
    chuandiPg.RealCount = self.chuandiPG.count;
    chuandiPg.PayType = self.chuandiPG.PayType;
    chuandiPg.whereFrom = self.chuandiPG.whereFrom;
    chuandiPg.orderNo = self.chuandiPG.orderNo;
    chuandiPg.cptID = self.chuandiPG.cptID;
    chuandiPg.tabID = self.chuandiPG.tabID;
    xiaofeiVc.zhifuchuandi = chuandiPg;
    
////    xiaofeiVc.count = btn.titleLabel.text;
//    xiaofeiVc.zhifuchuandi.paymentType = @"1";
//    xiaofeiVc.zhifuchuandi.count = [btn.titleLabel.text substringFromIndex:1];
//   // xiaofeiVc.zhifuchuandi.tabID=self.chuandiPG.tabID;
//    xiaofeiVc.zhifuchuandi.RealCount = self.chuandiPG.count;
    [self.navigationController pushViewController:xiaofeiVc animated:YES];
    
}

/**
 *  现金 支付  其他按钮
 *
 */
-(void)otherCrashButtonClick:(UIButton *)sender
{
    
    CashChangeViewController *cashChangeViewController = [[CashChangeViewController alloc]init];
    ZhiFuChuanDiPG *zhifuchuandi = [[ZhiFuChuanDiPG alloc]init];
    zhifuchuandi.billID = self.chuandiPG.billID;
    zhifuchuandi.PayType = self.chuandiPG.PayType;
    zhifuchuandi.paymentType = @"1";
    zhifuchuandi.whereFrom = self.chuandiPG.whereFrom;
    zhifuchuandi.orderNo = self.chuandiPG.orderNo;
    zhifuchuandi.cptID = self.chuandiPG.cptID;
    zhifuchuandi.tabID = self.chuandiPG.tabID;
    zhifuchuandi.count = self.chuandiPG.count;
    cashChangeViewController.zhiFuChuanDiPG = zhifuchuandi;
    [self.navigationController pushViewController:cashChangeViewController animated:YES];
    
 
}


- (void)setOneButtonTypeWith:(UIButton *)btn
{
    
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
}

- (void)requestPayType{
//    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/pop/jianka/createForm?returnJson=json",ceshiIP];
    
    NSString *urlStr  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/getpaymentTypes?returnJson=json",ceshiIP];
   // NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"paymentTypes"];
        //            NSLog(@"%@",arr);
        self.PayTypeArr = [PayType objectArrayWithKeyValuesArray:arr];
       // [self.PayTypeArr removeObjectAtIndex:5];
        
        //支付方式数组  在此处排序
        
        NSLog(@"paytype:%@",self.PayTypeArr);
        NSLog(@"1   count:%ld",self.PayTypeArr.count);
      //  [self.PayTypeArr objectAtIndex:2]removeObject:
//        [self.PayTypeArr removeObject:[self.PayTypeArr objectAtIndex:2]];
        
//        NSLog(@"%@",self.PayTypeArr);
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    CGRect rect = self.navigationController.navigationBar.frame;
    
    
    
    
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,83);
    self.navigationController.navigationBarHidden = NO;


    
    [self setButton];
    
    UIButton *price = [[UIButton alloc]init];
    [price setHeight:100.0f];
    //self.navigationItem.titleView.frame = CGRectMake(self.view.width/2, self.view.height/2 - 10, 50, 60);
    //self.navigationItem.titleView
    [price setTitle:[NSString stringWithFormat:@"￥%@",self.chuandiPG.count] forState:UIControlStateNormal];
    //price.textAlignment  = NSTextAlignmentCenter;
    
    //price.font = [UIFont systemFontOfSize:30];
    [price  setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 30 ]];
    [price setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];
    
    [price setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    
 

    self.navigationItem.titleView = price;
    
    [self setNavgation];
    
}
    

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    CGRect rect = self.navigationController.navigationBar.frame;
    
    
    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,83);

}

- (void)cancle{
    //王洪昌 会员充值
    if (self.panDuanHiden) {
       
        if ([self.delegate respondsToSelector:@selector(sendChuanDi:)]) {
            [self.delegate sendChuanDi:self.chuandiPG];
        }
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


- (IBAction)scan:(UIButton *)sender {
    
    
    ScanViewController *svc = [[ScanViewController alloc]init];
    svc.showLabelStr = @"请将摄像头对准客优惠券";
    svc.delegate = self;
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)jumpToConnectDevice{
    
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStory instantiateViewControllerWithIdentifier:@"CD"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)jumpZhiFuViewWith:(NSString *)payType zhifuID:(NSString *)zhifuID paymentType:(NSString *)paymentType{
    
    
    ShouQuJinEController *shouqujineVc = [[ShouQuJinEController alloc] init];
    
//    传递数据模型
    ZhiFuChuanDiPG *zhifuchuandi = [[ZhiFuChuanDiPG alloc]init];
    zhifuchuandi.billID = self.chuandiPG.billID;
    zhifuchuandi.VIPforwardUrl = self.chuandiPG.VIPforwardUrl;
    zhifuchuandi.idIdentifyStr = self.chuandiPG.idIdentifyStr;
    zhifuchuandi.amountPledges = self.chuandiPG.amountPledges;
    zhifuchuandi.count = self.chuandiPG.count;
    zhifuchuandi.PayType = payType;
    zhifuchuandi.whereFrom = self.chuandiPG.whereFrom;
    zhifuchuandi.whereFrom = self.chuandiPG.whereFrom;
    zhifuchuandi.orderNo = self.chuandiPG.orderNo;
    zhifuchuandi.cptID = zhifuID;
    zhifuchuandi.tabID = self.chuandiPG.tabID;
    zhifuchuandi.paymentType = paymentType;

    shouqujineVc.zhifuchuandi = zhifuchuandi;
    
    self.shouquVC = shouqujineVc;

    
    [self.navigationController pushViewController:shouqujineVc animated:YES];
}

#pragma mark - tableView的代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.PayTypeArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"cell";
  /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    PayType *payType = self.PayTypeArr[indexPath.row];
    cell.textLabel.text = payType.paymentTypeDesc;
    cell.textLabel.textColor = [UIColor colorWithRed:105 green:109 blue:113 alpha:1];
    
    NSLog(@"%@",payType.paymentTypeDesc);
    
    if ([payType.paymentTypeDesc isEqualToString:@"支付宝支付"]) {
        cell.imageView.image = [UIImage imageNamed:@"hlk_zfbq"];
    }else if ([payType.paymentTypeDesc isEqualToString:@"微信支付"]){
        cell.imageView.image = [UIImage imageNamed:@"hlk_wx1"];
    }else if ([payType.paymentTypeDesc isEqualToString:@"会员卡支付"]){
        cell.imageView.image = [UIImage imageNamed:@"hlk_sk"];
    }else if ([payType.paymentTypeDesc isEqualToString:@"优惠券/码支付"]){
        cell.imageView.image = [UIImage imageNamed:@""];
    }else if ([payType.paymentTypeDesc isEqualToString:@"百度钱包支付"]){
        cell.imageView.image = [UIImage imageNamed:@"hlk_bdqb1"];
    }else if ([payType.paymentTypeDesc isEqualToString:@"其他支付"]){
        cell.imageView.image = [UIImage imageNamed:@"hlk_qtzf"];
    }
    
    */
    //modify start
    
    
    ZhiFuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil)
    {
        cell = [[ZhiFuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    PayType *payType = self.PayTypeArr[indexPath.row];
      NSLog(@"number:%ld%@",indexPath.row,payType.paymentName);
    cell.payTypeLabel.text = [NSString stringWithFormat:@"%@",payType.paymentName];
    //cell.payTypeLabel.text = [NSString  stringWithFormat:@"%@",[self.tmpArray objectAtIndex: indexPath.row]];
   // cell.payTypeLabel.text = [NSString stringWithFormat:@"numebr:%ld",indexPath.row];
    //cell.payTypeLabel.textColor = [UIColor redColor];
    cell.payTypeLabel.textColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    cell.payTypeLabel.font = [UIFont boldSystemFontOfSize:17];
   // cell.indicatorImage.backgroundColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    cell.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
    if ([payType.paymentName isEqualToString:@"支付宝支付"]) {
        cell.payTypeImage.image = [UIImage imageNamed:@"hlk_zfbq"];
    }else if ([payType.paymentName isEqualToString:@"微信支付"]){
       cell.payTypeImage.image = [UIImage imageNamed:@"hlk_wx1"];
    }else if ([payType.paymentName isEqualToString:@"银行卡支付"]){
        cell.payTypeLabel.text = [NSString stringWithFormat:@"银行卡支付"];
        cell.payTypeImage.image = [UIImage imageNamed:@"hlk_sk"];
    }else if ([payType.paymentName isEqualToString:@"优惠券/码支付"]){
        cell.payTypeImage.image = [UIImage imageNamed:@""];
    }else if ([payType.paymentName isEqualToString:@"百度钱包支付"]){
        cell.payTypeImage.image = [UIImage imageNamed:@"hlk_bdqb1"];
    }else if ([payType.paymentName isEqualToString:@"其他支付"]){
        cell.payTypeImage.image = [UIImage imageNamed:@"hlk_qtzf"];
    }else if ([payType.paymentName isEqualToString:@"QQ钱包"]){
        cell.payTypeImage.image = [UIImage imageNamed:@"hlk_qq"];
    }else if ([payType.paymentName isEqualToString:@"会员卡支付"]){
        cell.payTypeImage.image = [UIImage imageNamed:@"会员卡_03"];
    }
    
   // cell.textLabel.text =[NSString stringWithFormat:@"number:%ld",indexPath.row];
    
    
    //end of line
    
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
 

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    PayType *payType = self.PayTypeArr[indexPath.row];
    
    
    
    if ([payType.paymentName isEqualToString:@"微信支付"]) {
        [self jumpZhiFuViewWith:payType.paymentName zhifuID:payType.cptId paymentType:payType.paymentType];
        
    }else if ([payType.paymentName isEqualToString:@"支付宝支付"]){
        
        [self jumpZhiFuViewWith:payType.paymentName zhifuID:payType.cptId paymentType:payType.paymentType];
    }else if ([payType.paymentName isEqualToString:@"银行卡支付"]){
        
//        [self jumpZhiFuViewWith:payType.paymentTypeDesc zhifuID:payType.cptId];
        //[self jumpToConnectDevice];
        [self jumpZhiFuViewWith:payType.paymentName zhifuID:payType.cptId paymentType:payType.paymentType];
    }else if ([payType.paymentName isEqualToString:@"QQ钱包"]){
        
        NSLog(@"QQ钱包....");
        [self jumpZhiFuViewWith:payType.paymentName zhifuID:payType.cptId paymentType:payType.paymentType];
    }
    else if ([payType.paymentName isEqualToString:@"百度钱包支付"]){
        
        NSLog(@"百度钱包支付....");
        [self jumpZhiFuViewWith:payType.paymentName zhifuID:payType.cptId paymentType:payType.paymentType];
    }
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70;
}


#pragma mark - 懒加载

- (NSMutableArray *)PayTypeArr{
    
    if (_PayTypeArr == nil) {
        _PayTypeArr = [NSMutableArray array];
    }
    return _PayTypeArr;
}
#pragma mark - 刷卡交易完成回调
-(void)newSwipingCardViewControllerdidFinishConsume :(NewSwipingCardViewController *)vc statusInfo:(NSString*)statusInfo{
    self.wrongView.hidden = NO;
}

#pragma mark - 扫描完成回调
-(void)scanViewControllerdidFinishScan :(ScanViewController *)vc result:(NSString*)str{
    
    self.ticketTextField.text = str;
    
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
