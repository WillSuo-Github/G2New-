//
//  VipCreatViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "VipCreatViewController.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "saleList.h"
#import "PayType.h"
#import "VipCreat.h"
#import "VipCard.h"
#import "WorkType.h"
#import "xueliType.h"
#import "ZhiFuViewController.h"
#import "YuDingDatePickController.h"



#import "DXKeyboard.h"

@interface VipCreatViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,YuDingDatePickControllerDelegate,UIGestureRecognizerDelegate,DXKeyboardDelegate>{
    
    
    NSString *workCount;
    NSString *xueliCount;
    NSString *cardCount;
    NSString *payCount;
    NSString *saleCount;
    NSString *kaifapiaoCount;
}

@property (nonatomic, strong) ZhiFuViewController *zhiFuViewController;
@property (nonatomic,strong) YuDingDatePickController *datePickerContgroller;
@property (nonatomic,strong) UIPopoverController *popController;


@property (weak, nonatomic) IBOutlet UIButton *birthdayButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *yingxiaoyuanBtn;

@property (weak, nonatomic) IBOutlet UIButton *zhiyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *xueliBtn;
@property (weak, nonatomic) IBOutlet UIButton *leixingBtn;//卡片类型
@property (weak, nonatomic) IBOutlet UIButton *zengsongjineBtn;

@property (weak, nonatomic) IBOutlet UIView *yingxiaoyuanView;

@property (weak, nonatomic) IBOutlet UIButton *quxiao;
@property (weak, nonatomic) IBOutlet UIButton *queding;



@property (nonatomic, strong) UITableView *yingxiaoTableView;
@property (nonatomic, strong) UITableView *fukuangTableView;
@property (nonatomic, strong) UITableView *zhiyeTableView;
@property (nonatomic, strong) UITableView *xueliTableView;
@property (nonatomic, strong) UITableView *leixingTableView;


@property (weak, nonatomic) IBOutlet UIView *zhiyeView;
@property (weak, nonatomic) IBOutlet UIView *xueliView;
@property (weak, nonatomic) IBOutlet UIView *leixingView;


//输入的参数
@property (weak, nonatomic) IBOutlet UITextField *xingming;
@property (weak, nonatomic) IBOutlet UITextField *shouji;
@property (weak, nonatomic) IBOutlet UITextField *shengri;

@property (weak, nonatomic) IBOutlet UITextField *youxiang;
@property (weak, nonatomic) IBOutlet UITextField *beizhu;
@property (weak, nonatomic) IBOutlet UITextField *kahao;
@property (weak, nonatomic) IBOutlet UITextField *yajin;
@property (weak, nonatomic) IBOutlet UITextField *mima;
@property (weak, nonatomic) IBOutlet UITextField *chongzhijine;
@property (weak, nonatomic) IBOutlet UITextField *shishoujine;

@property (weak, nonatomic) IBOutlet UIButton *nan;
@property (weak, nonatomic) IBOutlet UIButton *nv;
@property (weak, nonatomic) IBOutlet UIButton *kaifapiaoYes;
@property (weak, nonatomic) IBOutlet UIButton *kaifapiaoNo;



@property (nonatomic, strong) NSMutableArray *tmpArr;
@property (nonatomic, strong) NSMutableArray *PayTypeArr;
@property (nonatomic, strong) NSMutableArray *VipCardArr;
@property (nonatomic, strong) NSMutableArray *worksArr;
@property (nonatomic, strong) NSMutableArray *xueliArr;

@property (strong, nonatomic)UITextField *isBeingEditingTextField;


@end

@implementation VipCreatViewController


- (void)viewDidLoad {
   
    
    //默认不开发票
    self.kaifapiaoNo.selected=YES;
    [super viewDidLoad];
   
    
    DXKeyboard *jianpanView = [[DXKeyboard alloc] init];
    jianpanView.delegate = self;
    
    //充值金额和实收金额和 押金为数字键盘 王京阳
    self.shouji.delegate=self;
    self.chongzhijine.delegate=self;
    self.shishoujine.delegate=self;
    self.yajin.delegate=self;
    self.mima.delegate=self;
    
    self.xingming.delegate=self;
    self.youxiang.delegate=self;
    self.beizhu.delegate=self;
    
    
    
    [self.shouji setInputView:jianpanView];
    [self.chongzhijine setInputView:jianpanView];
    [self.shishoujine setInputView:jianpanView];
    [self.yajin setInputView:jianpanView];
    [self.mima setInputView:jianpanView];

    


    
    self.xingming.tag=1;
    self.shouji.tag=2;
    
//    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(didReceiveNoti:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardFrameBeginUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardFrameEndUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardAnimationDurationUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardAnimationCurveUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardIsLocalUserInfoKey object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];

    
    
    self.datePickerContgroller = [[YuDingDatePickController alloc]init];
    self.datePickerContgroller.delegate = self;

    self.popController = [[UIPopoverController alloc]initWithContentViewController:self.datePickerContgroller];
    
    [self VIPBirthday];
    [self.birthdayButton addTarget:self action:@selector(birthdayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.quxiao.backgroundColor=[UIColor  colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.queding.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    
    [self.quxiao setTitleColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1 ] forState:UIControlStateNormal];
    [self.queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.quxiao.layer.cornerRadius=5;
    self.queding.layer.cornerRadius=5;
    

    // Do any additional setup after loading the view from its nib.
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = YES;
     self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 580, 0);
    // self.scrollView.contentSize = CGSizeMake(700,1500);
    
    //添加手指
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dianjiquxiao)];
    tapG.delegate = self;
    [self.scrollView addGestureRecognizer:tapG];

    

    
    [self.yingxiaoyuanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zhiyeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.xueliBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leixingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];


    [self requestYingyeyuanMingdan];
    
    [self requestPayType];
    
    [self requestType];
    
    [self setNavigationStyle];
    
    
    
    self.chongzhijine.delegate = self;
    self.shishoujine.delegate = self;
    
    for (UIView *view in self.scrollView.subviews) {
        if (view.tag > 9) {
            view.layer.borderWidth = 1;
            view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
            view.layer.cornerRadius = 5;
            view.layer.masksToBounds = YES;
            
        }
    }
    
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField = (UITextField *)view;
            textField.delegate = self;
        }
    }
    
}


-(void)setNavigationStyle
{
    UIButton *leftButton = [[UIButton alloc]init];
     [leftButton sizeToFit];
    [leftButton setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
    //[leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 50)];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];
    
   
    [leftButton addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton sizeToFit];
    //[rightButton setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 50)];
       [rightButton setImageEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    [rightButton setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(queding:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    
    UIButton *navigationTitleButton = [[UIButton alloc]init];
    [navigationTitleButton sizeToFit];
    [navigationTitleButton setTitle:@"会员创建" forState:UIControlStateNormal];
    navigationTitleButton.userInteractionEnabled = NO;
    [navigationTitleButton setTitleEdgeInsets:UIEdgeInsetsMake(-30, -55, 0, -30)];
    //navigationTitleButton.backgroundColor = [UIColor redColor];
    [navigationTitleButton  setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 30 ]];
    [navigationTitleButton setTitleColor:[UIColor colorWithRed:103/255.0 green:108/255.0 blue:112/255.0 alpha:1] forState:UIControlStateNormal];

    self.navigationItem.titleView = navigationTitleButton;
    
 
}


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
  
    self.navigationController.navigationBar.frame = CGRectMake(0,0,self.view.width,83);
 
   
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     self.navigationController.navigationBar.frame = CGRectMake(0,0,self.view.width,83);
}



- (IBAction)kaifapiaoYesChick:(id)sender {
    if (self.kaifapiaoYes.selected) {
        self.kaifapiaoYes.selected = NO;
    }else{
        self.kaifapiaoNo.selected = NO;
        self.kaifapiaoYes.selected = YES;
    }
}
- (IBAction)kaifapiaoNoChick:(id)sender {
    if (self.kaifapiaoNo.selected) {
        self.kaifapiaoNo.selected = NO;
    }else{
        
        self.kaifapiaoYes.selected = NO;
        self.kaifapiaoNo.selected = YES;
    }
}


- (IBAction)nanChick:(id)sender {
      [self.view endEditing:YES];
    //点击男button  下拉菜单收起 wjy
    self.leixingTableView.hidden=YES;
    self.xueliTableView.hidden=YES;
    self.yingxiaoTableView.hidden=YES;
    self.zhiyeTableView.hidden=YES;

    
    if (self.nan.selected) {
        self.nan.selected = NO;
    }else{
        
        self.nv.selected = NO;
        self.nan.selected = YES;
    }
}
- (IBAction)nvChick:(id)sender {
    //点击女button  下拉菜单收起 wjy

      [self.view endEditing:YES];
    self.leixingTableView.hidden=YES;
    self.xueliTableView.hidden=YES;
    self.yingxiaoTableView.hidden=YES;
    self.zhiyeTableView.hidden=YES;

    if (self.nv.selected) {
        self.nv.selected = NO;
    }else{
        
        self.nan.selected = NO;
        self.nv.selected = YES;
    }
}

- (void)requestYingyeyuanMingdan{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/index/pop/employee/select?type=5&_=1439171041470&returnJson=json",ceshiIP];
    
    [HttpTool GET:urlString parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"employees"];;
        self.tmpArr = [saleList objectArrayWithKeyValuesArray:[dict objectForKey:@"content"]];
        
        [self requestPayType];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestPayType{
    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/pop/jianka/createForm?returnJson=json",ceshiIP];
    [HttpTool GET:urlString parameters:nil success:^(id responseObject) {

        self.PayTypeArr = [PayType objectArrayWithKeyValuesArray:[responseObject objectForKey:@"paymentTypes"]];
        [self requestType];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)requestType{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/pop/jianka/createForm?returnJson=json",ceshiIP];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSArray *arr = [responseObject objectForKey:@"membershipCardClasses"];
        self.VipCardArr = [VipCard objectArrayWithKeyValuesArray:arr];
        
        arr = [responseObject objectForKey:@"works"];
        self.worksArr = [WorkType objectArrayWithKeyValuesArray:arr];
        
        arr = [responseObject objectForKey:@"edus"];
        self.xueliArr = [xueliType objectArrayWithKeyValuesArray:arr];
        
        arr = [responseObject objectForKey:@"membershipCardClasses"];
        self.VipCardArr = [VipCard objectArrayWithKeyValuesArray:arr];
        
        [self setUpxuanzeView];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)setUpxuanzeView{
    //营销员
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tag = 1;
    tableView.layer.borderWidth=0.5;
    tableView.layer.borderColor=[UIColor blackColor].CGColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.frame = CGRectMake(self.yingxiaoyuanView.x + 80, self.yingxiaoyuanView.y + 44, self.yingxiaoyuanView.width - 80, 44 * self.tmpArr.count);
    tableView.tableFooterView= [[UIView alloc] init];
    tableView.hidden = YES;
    _yingxiaoTableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:tableView];
    
    //付款方式
    UITableView *tableView1 = [[UITableView alloc] init];
    tableView1.tag = 2;
    tableView1.layer.borderWidth=0.5;
    tableView1.layer.borderColor=[UIColor blackColor].CGColor;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView1.tableFooterView= [[UIView alloc] init];
    tableView1.hidden = YES;
    _fukuangTableView = tableView1;
    [self.scrollView addSubview:tableView1];
    
    //职业
    UITableView *tableView2 = [[UITableView alloc] init];
    tableView2.tag = 3;
    tableView2.layer.borderWidth=0.5;
    tableView2.layer.borderColor=[UIColor blackColor].CGColor;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView2.frame = CGRectMake(self.zhiyeView.x + 80 , self.zhiyeView.y + 44, self.zhiyeView.width - 80, 44 * 6);
    tableView2.tableFooterView= [[UIView alloc] init];
    tableView2.hidden = YES;
    _zhiyeTableView = tableView2;
    [self.scrollView addSubview:tableView2];
    
    //学历
    UITableView *tableView3 = [[UITableView alloc] init];
    tableView3.tag = 4;
    tableView3.layer.borderWidth=0.5;
    tableView3.layer.borderColor=[UIColor blackColor].CGColor;
    tableView3.delegate = self;
    tableView3.dataSource = self;
    tableView3.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView3.frame = CGRectMake(self.xueliView.x + 80 , self.xueliView.y + 44, self.xueliView.width - 80, 44 * 6);
    tableView3.tableFooterView= [[UIView alloc] init];
    tableView3.hidden = YES;
    _xueliTableView = tableView3;
    [self.scrollView addSubview:tableView3];
    
    //会员卡类型
    UITableView *tableView4 = [[UITableView alloc] init];
    tableView4.layer.borderWidth=0.5;
    tableView4.layer.borderColor=[UIColor blackColor].CGColor;
    tableView4.tag = 5;
    tableView4.delegate = self;
    tableView4.dataSource = self;
    tableView4.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView4.frame = CGRectMake(self.leixingView.x + 80 , self.leixingView.y + 44, self.leixingView.width - 80, 44 * self.VipCardArr.count);
    tableView4.tableFooterView= [[UIView alloc] init];
    tableView4.hidden = YES;
    _leixingTableView = tableView4;
    [self.scrollView addSubview:tableView4];
}

- (void)creatTableViewWithTag:(NSInteger)tag baseView:(UIView *)baseView{
    
    UITableView *tableView4 = [[UITableView alloc] init];
    tableView4.tag = 5;
    tableView4.delegate = self;
    tableView4.dataSource = self;
    tableView4.frame = CGRectMake(self.leixingView.x + 80 , self.leixingView.y + 44, self.leixingView.width - 80, 44 * self.VipCardArr.count);
    tableView4.tableFooterView= [[UIView alloc] init];
    tableView4.hidden = YES;
    _leixingTableView = tableView4;
    [self.scrollView addSubview:tableView4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)yingxiaoyuanChick:(id)sender {
      [self.view endEditing:YES];
    [self xiaqufangfa];
    
    self.leixingTableView.hidden = YES;
    self.xueliTableView.hidden = YES;
    self.zhiyeTableView.hidden = YES;
    self.fukuangTableView.hidden = YES;
    self.yingxiaoTableView.hidden = NO;
    [self textViewStopEditing];
}
- (IBAction)fukuanfangshiChick:(id)sender {
    self.leixingTableView.hidden = YES;
    self.xueliTableView.hidden = YES;
    self.zhiyeTableView.hidden = YES;
    self.yingxiaoTableView.hidden = YES;
    self.fukuangTableView.hidden = NO;
    [self textViewStopEditing];
}
- (IBAction)xueliChick:(id)sender {
      [self.view endEditing:YES];
    self.leixingTableView.hidden = YES;
    self.xueliTableView.hidden = NO;
    self.zhiyeTableView.hidden = YES;
    self.yingxiaoTableView.hidden = YES;
    self.fukuangTableView.hidden = YES;
    [self textViewStopEditing];
    
}
- (IBAction)zhiyeChick:(id)sender {
      [self.view endEditing:YES];
    self.leixingTableView.hidden = YES;
    self.xueliTableView.hidden = YES;
    self.zhiyeTableView.hidden = NO;
    self.yingxiaoTableView.hidden = YES;
    self.fukuangTableView.hidden = YES;
    [self textViewStopEditing];
}
- (IBAction)leixing:(id)sender {
      [self.view endEditing:YES];
    self.leixingTableView.hidden = NO;
    self.xueliTableView.hidden = YES;
    self.zhiyeTableView.hidden = YES;
    self.yingxiaoTableView.hidden = YES;
    self.fukuangTableView.hidden = YES;
    [self textViewStopEditing];
}

- (void)textViewStopEditing{
    
    for (UIView *view in self.scrollView.subviews) {
        if ([view isKindOfClass:[UITextView class]]) {
            [view endEditing:YES];
        }
    }
}



- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (IBAction)queding:(id)sender {
    
    
    BOOL isSuccess ;
    //测试阶段 不做校验
    
    if (_xingming.text.length == 0) {
        
        [self showAlertViewWithTitle:@"名字不能为空"];
        return;
    }
    else if (!_nan.selected &&! _nv.selected){
        
        [self showAlertViewWithTitle:@"请选择性别"];
        return;
    }
    else if (_shouji.text.length == 0 || self.shouji.text.length != 11 ||!(isSuccess = [self isPureInt:self.shouji.text]))
    {

            [self showAlertViewWithTitle:@"手机号不正确"];
            return;
    }else if (_chongzhijine.text.length == 0){
        
        [self showAlertViewWithTitle:@"充值金额不能为空"];
        return;
    }else if (_shishoujine.text.length == 0){
        
        [self showAlertViewWithTitle:@"实收金额不能为空"];
        return;
    }
    else if (self.leixingBtn.titleLabel.text.length == 0){
        
        [self showAlertViewWithTitle:@"卡片类型不能为空"];
        return;
    }
    
    //创建一个VIP modeler 对象
    VipCreat *vipC = [[VipCreat alloc] init];
    vipC.name = self.xingming.text;
    vipC.birthdayStr = self.birthdayButton.titleLabel.text;
    vipC.mobile = self.shouji.text;
    vipC.work = workCount;
    vipC.edu = xueliCount;
    vipC.email = self.youxiang.text;
    vipC.notes = self.beizhu.text;
    vipC.salesmanName = saleCount;
    
    //性别
    if (self.nan.selected) {
        vipC.gender = @"1";
    }else{
        
        vipC.gender = @"0";
    }
    if (self.kaifapiaoYes.selected) {
        kaifapiaoCount = @"1";
    }else if (self.kaifapiaoNo.selected){
        
        kaifapiaoCount = @"0";
    }
    
    NSDictionary *dict = vipC.keyValues;
    [dict setValue:self.kahao.text forKey:@"new_cardNo"];
    [dict setValue:cardCount forKey:@"new_membershipCardClasseType"];
    [dict setValue:self.yajin.text forKey:@"new_cashPledge"];
    [dict setValue:self.mima.text forKey:@"new_cardPassword"];
    //充值金额  在创建会员的时候 先设置为0 待付款成功之后在 在记录充值金额
   // [dict setValue:self.chongzhijine.text forKey:@"new_rechargeCash"];
    [dict setValue:0 forKey:@"new_rechargeCash"];
    [dict setValue:payCount forKey:@"new_paymentType"];
    [dict setValue:self.shishoujine.text forKey:@"new_paidinCash"];
    [dict setValue:saleCount forKey:@"salesmanId"];
    [dict setValue:kaifapiaoCount forKey:@"new_drawBill"];
    [dict setValue:@"" forKey:@"new_paymentType"];
    NSLog(@"%@",dict);
    [self creatVipWithDict:dict];
    
    
    
    
}


- (void)creatVipWithDict:(NSDictionary *)dict{
    
 self.zhiFuViewController = [[ZhiFuViewController alloc]init];
    //交换数据
    ZhiFuChuanDiPG *chuandiPg = [[ZhiFuChuanDiPG alloc] init];
    chuandiPg.amountPledges = self.yajin.text;
    chuandiPg.count = self.shishoujine.text;
    
    //手机号是唯一标示
    chuandiPg.idIdentifyStr = self.shouji.text;
    chuandiPg.whereFrom = KVipCreatChongzhi;
    self.zhiFuViewController.chuandiPG = chuandiPg;
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/jianka/create",ceshiIP];
    
    //NSLog(@"send message dic:%@",dict);
    
    [HttpTool POST:urlStr parameters:dict success:^(id responseObject) {
       // NSLog(@"responseObject : %@",responseObject);
        //server response message
        NSString *str = [responseObject objectForKeyedSubscript:@"forwardUrl"];
        //NSLog(@"vipForward URL:%@",str);
        self.zhiFuViewController.chuandiPG.VIPforwardUrl = str;
        
        
        //建卡成功
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"快速建卡成功"]) {
         //whc 2015 11 24 赠送创建会员充值
            if ([self.shishoujine.text isEqualToString:@"0"]) {
                NSString *url = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/chongzhi/create",ceshiIP];
                //http://192.168.1.160:8080/canyin-frontdesk/member/chongzhi/create?isDrawBill=1&isPrint=0&new_paymentType=&rechargeCash=3&paidinCash=3&mcId=7427b1bf-f54f-11e4-af9a-02004c4f4f50&cardNo=100000001&returnJson=json
                NSString * rechargeCash = self.chongzhijine.text;
                NSString * paidinCash = self.shishoujine.text;
                NSDictionary *dic = @{@"isDrawBill":@"1",@"isPrint":@"0",@"new_paymentType":@"",@"rechargeCash":rechargeCash,@"paidinCash":paidinCash,@"mcId":str,@"cardNo":self.shouji.text,@"returnJson":@"json",@"":@""};
                [HttpTool POST:url  parameters:dic success:^(id responseObject) {
                    //发送页面刷新通知
  [[NSNotificationCenter defaultCenter]postNotificationName:KshuaxinVIP object:nil];
                    //代理传旨
                    if ([self.delegate respondsToSelector:@selector(sendShuaxin)]) {
                        [self.delegate sendShuaxin];
                    }
                    [self dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"983978787%@",responseObject);
                } failure:^(NSError *error) {
                    
                }];
                
                
            } else {
                [self.navigationController pushViewController: self.zhiFuViewController animated:YES];
            }
            
//            
//            [[NSNotificationCenter defaultCenter]postNotificationName:KchuaxinVIP object:nil];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[responseObject objectForKey:@"message"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            
            
            
            
            
            [alert show];
            
            
            
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
    
    
}


//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSCharacterSet *cs;
//    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
//    
//    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""]; //按cs分离出数组,数组按@""分离出字符串
//    
//    BOOL canChange = [string isEqualToString:filtered];
//    
//    return canChange;
//}


- (IBAction)quxiao:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    
//    self.yingxiaoTableView.hidden = YES;
//    self.fukuangTableView.hidden = YES;
//}



-(void)dianjiquxiao{
    
    self.leixingTableView.hidden=YES;
    self.xueliTableView.hidden=YES;
    self.zhiyeTableView.hidden=YES;
    self.xueliTableView.hidden=YES;
    self.yingxiaoTableView.hidden=YES;
    

    [self.view endEditing:YES];

}

#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1) {
        return self.tmpArr.count;
    }else if (tableView.tag == 2){
        
        return self.PayTypeArr.count;
    }else if (tableView.tag == 3){
        
        return self.worksArr.count;
    }else if (tableView.tag == 4){
        
        return self.xueliArr.count;
    }else if (tableView.tag == 5){
        
        return self.VipCardArr.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (tableView.tag == 1) {
        saleList *list = self.tmpArr[indexPath.row];
        cell.textLabel.text = list.name;
         cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        return cell;
    }else if (tableView.tag == 2){
        
    
        PayType *payType = self.PayTypeArr[indexPath.row];
        cell.textLabel.text = payType.paymentName;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        return cell;
    }else if (tableView.tag == 3){
        
        
        WorkType *workType = self.worksArr[indexPath.row];
        cell.textLabel.text = workType.bciName;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        return cell;
    }else if (tableView.tag == 4){
        
        
        xueliType *xueliType = self.xueliArr[indexPath.row];
        cell.textLabel.text = xueliType.bciName;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        return cell;
    }else if (tableView.tag == 5){
        
        
        VipCard *vipCard = self.VipCardArr[indexPath.row];
        cell.textLabel.text = vipCard.name;
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        
        return cell;
    }
   
        return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1) {
        saleList *list = self.tmpArr[indexPath.row];
        saleCount = list.salesmanId;
        [self.yingxiaoyuanBtn setTitle:list.name forState:UIControlStateNormal];
        self.yingxiaoTableView.hidden = YES;
    }else if (tableView.tag == 2){
        
        
        PayType *payType = self.PayTypeArr[indexPath.row];
        payCount = payType.cptId;
 
        self.fukuangTableView.hidden = YES;
    }else if (tableView.tag == 3){

        WorkType *workType = self.worksArr[indexPath.row];
        workCount = workType.bciCode;
        [self.zhiyeBtn setTitle:workType.bciName forState:UIControlStateNormal];
        self.zhiyeTableView.hidden = YES;
    }else if (tableView.tag == 4){
        
        xueliType *xueliType = self.xueliArr[indexPath.row];
        xueliCount = xueliType.bciCode;
        [self.xueliBtn setTitle:xueliType.bciName forState:UIControlStateNormal];
        self.xueliTableView.hidden = YES;
    }else if (tableView.tag == 5){
        
        VipCard *vipCard = self.VipCardArr[indexPath.row];
        
        cardCount  = vipCard.mcclassId;
        [self.leixingBtn setTitle:vipCard.name forState:UIControlStateNormal];
        self.leixingTableView.hidden = YES;
    }
    
}



//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    //self.lianxidianhua.text.length!=11
//    
//       if (textField==self.shouji) {
//        if (textField.text.length!=11) {
//
//            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"请输入正确电话" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//          //  textField.text=@"";
//            [alertView show];
//
//
//            return NO;
//        }
//    }
//    return YES;
//    
//
//}
//



-(void)VIPBirthday
{
    
    NSDate *date = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];//yyyy-MM-dd HH:mm:ss
    NSString *str = [outputFormatter stringFromDate:date];
    //初始化为当前时间
    [self.birthdayButton setTitle:str forState:UIControlStateNormal];
    
    
    
}

#pragma mark - YuDingDatePickController的代理方法
- (void)YuDingDatePickControllerDidSelectDate:(NSString *)date AndString:(NSString *)wholeDateStr{
    //将日期转换为整形  王洪昌
    [[[[NSMutableString  stringWithString:wholeDateStr] componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue];
    //获取当前时间  王洪昌
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMdd"];
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    
    if ([locationString intValue] > [[[[NSMutableString  stringWithString:wholeDateStr] componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue]) {
         [self.birthdayButton setTitle:wholeDateStr forState:UIControlStateNormal];
    } else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"日期选择错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
    
    
}

- (void)birthdayButtonClick:(UIButton *)sender {
    
    
    CGRect  birthdayButtonFrame = sender.superview.frame;
   birthdayButtonFrame.origin.y = birthdayButtonFrame.origin.y +60;
    
    [self.popController presentPopoverFromRect:birthdayButtonFrame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
}





#pragma mark - alertView的创建
- (void)showAlertViewWithTitle:(NSString *)title{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"错误" message:title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - textView的代理方法
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (self.chongzhijine.text.length && self.shishoujine.text.length) {
        NSInteger count  = self.chongzhijine.text.integerValue - self.shishoujine.text.integerValue;
        self.zengsongjineBtn.titleLabel.text = [NSString stringWithFormat:@"%ld",count];
        [self.zengsongjineBtn setTitle:[NSString stringWithFormat:@"%ld",count] forState:UIControlStateNormal];
    }
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);

}


#pragma mark - 手指的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if (touch.view == self.scrollView) {
        return YES;
    }else{
        
        return NO;
    }
}



- (NSMutableArray *)tmpArr{
    
    if (_tmpArr == nil) {
        _tmpArr = [NSMutableArray array];
    }
    return _tmpArr;
}

- (NSMutableArray *)PayTypeArr{
    
    if (_PayTypeArr == nil) {
        _PayTypeArr = [NSMutableArray array];
    }
    return _PayTypeArr;
}

- (NSMutableArray *)VipCardArr{
    
    if (_VipCardArr ==  nil) {
        _VipCardArr = [NSMutableArray array];
    }
    return _VipCardArr;
}

- (NSMutableArray *)worksArr{
    
    if (_worksArr == nil) {
        _worksArr = [NSMutableArray array];
    }
    return _worksArr;
}

- (NSMutableArray *)xueliArr{
    
    if (_xueliArr == nil) {
        _xueliArr = [NSMutableArray array];
    }
    return _xueliArr;
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
        //WHC 数字键盘打开  
//        if (self.isBeingEditingTextField.text.length==0) return;
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
    
    
    self.leixingTableView.hidden=YES;
    self.xueliTableView.hidden=YES;
    self.yingxiaoTableView.hidden=YES;
    self.zhiyeTableView.hidden=YES;
    
    
    
}



- (void)numberKeyBoardFinish
{
    [self.shouji resignFirstResponder];
    [self.shishoujine resignFirstResponder];
    [self.chongzhijine resignFirstResponder];
    [self.yajin resignFirstResponder];
    [self.mima resignFirstResponder];
    

    

   
}

- (void)bgButtonClick27703784131
{
    [self.shouji resignFirstResponder];
    [self.shishoujine resignFirstResponder];
    [self.chongzhijine resignFirstResponder];
    [self.yajin resignFirstResponder];
    [self.mima resignFirstResponder];
    
    

    
}


- (void) numberKeyBoardShou{
    [self xiaqufangfa];
}

@end
