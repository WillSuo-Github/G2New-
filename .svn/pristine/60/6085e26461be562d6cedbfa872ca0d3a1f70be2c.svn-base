//
//  TransfreViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/4.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "TransfreViewController.h"
#import "LoginViewController.h"
#import "HttpTool.h"
#import "XYPieChart.h"
#import "paymentTypeVOsOrder.h"
#import "MJExtension.h"
#import "paymentTypeVOsForm.h"
#import "MainViewController.h"
#import "MenuViewController.h"
#import "SecondLoginViewController.h"

@interface TransfreViewController ()<XYPieChartDelegate,XYPieChartDataSource>

@property (weak, nonatomic) IBOutlet UILabel *jiaobanren;
@property (weak, nonatomic) IBOutlet UILabel *shangcijiaobanshijian;
@property (weak, nonatomic) IBOutlet UILabel *bencijiaobanshijian;

@property (weak, nonatomic) IBOutlet UILabel *jiucanrenshu;

@property (weak, nonatomic) IBOutlet UILabel *tuicaijine;

@property (weak, nonatomic) IBOutlet UILabel *fuwufei;

@property (weak, nonatomic) IBOutlet UILabel *zengcaijine;

@property (weak, nonatomic) IBOutlet UILabel *xianjinzhifu;

@property (weak, nonatomic) IBOutlet UILabel *yinhangkazhifu;

@property (weak, nonatomic) IBOutlet UILabel *zaixianzhifu;

@property (weak, nonatomic) IBOutlet UILabel *heji;

@property (weak, nonatomic) IBOutlet UILabel *qianbanjieyuxianjin;

@property (weak, nonatomic) IBOutlet UILabel *xinzengzijin;

@property (weak, nonatomic) IBOutlet UILabel *danqianxianjinzonge;

@property (weak, nonatomic) IBOutlet UILabel *benbanshangjiao;

@property (weak, nonatomic) IBOutlet UILabel *benbanjieyuxianjin;

@property (weak, nonatomic) IBOutlet UILabel *vipxianjin;

@property (weak, nonatomic) IBOutlet UILabel *vipyinhangka;

@property (weak, nonatomic) IBOutlet UILabel *vipheji;

@property (weak, nonatomic) IBOutlet UILabel *shishouheji;

@property (weak, nonatomic) IBOutlet UILabel *moling;

@property (weak, nonatomic) IBOutlet UILabel *zhekouyouhui;

@property (weak, nonatomic) IBOutlet UILabel *qiangzhijiezhang;

@property (weak, nonatomic) IBOutlet UILabel *yingshouheji;

@property (weak, nonatomic) IBOutlet XYPieChart *pieView;

@property (nonatomic, strong) NSMutableArray *slices;

@property (nonatomic, strong) NSArray *sliceColors;

@property (nonatomic, strong) NSMutableArray *yufukuanArr;

@property (nonatomic, strong) NSMutableArray *vipInfoArr;

@property (nonatomic, strong) UITextField *zhanghao;

@property (nonatomic, strong) UITextField *mima;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *juhua;

@property (weak, nonatomic) IBOutlet UIButton *remark;

@property (weak, nonatomic) IBOutlet UILabel *yingyetongjiLabel;
@property (weak, nonatomic) IBOutlet UIView *yingyetongjiBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *huiyuankachongzhiyutuikaLabel;

@property (strong,nonatomic) SecondLoginViewController *secondLoginCtrol;
@property (strong,nonatomic)UIButton *loginButton;
@property (assign,nonatomic)BOOL flagTag;


@end

@implementation TransfreViewController
- (IBAction)qiehuandenglu:(id)sender {
    
    
    if (_isDaYang) {
        //打烊  登出 操作
//        
//        [self dismissViewControllerAnimated:YES completion:nil];
//        LoginViewController *login = [[LoginViewController alloc] init];
//        [kKeyWindow setRootViewController:login];
//        
//        SecondLoginViewController *secondLogin = [[SecondLoginViewController alloc]init];
//        
//        
//        NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/mobile/logout",ceshiIP];
//        [HttpTool GET:urlString parameters:nil success:^(id responseObject) {
//            
//            
//            
//            
//        } failure:^(NSError *error) {
//            
//        }];
//        
        
        
    }else{
    
        UIView *coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.5;
        [self.view addSubview:coverView];
        UITextField *zhanghao = [[UITextField alloc] initWithFrame:CGRectMake(362, 240, 300, 40)];
        zhanghao.backgroundColor = [UIColor whiteColor];
        zhanghao.placeholder = @"请输入账号";
        _zhanghao = zhanghao;
        //    zhanghao.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:zhanghao];
        UITextField *mima = [[UITextField alloc] initWithFrame:CGRectMake(362, 281, 300, 40)];
        mima.placeholder = @"请输入密码";
        mima.backgroundColor = [UIColor whiteColor];
        mima.secureTextEntry = YES;
        _mima = mima;
        //    mima.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:mima];
        
       self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(362, 331, 300, 40)];
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [self.loginButton setFont:[UIFont systemFontOfSize:18]];
        
        self.loginButton.backgroundColor = [UIColor colorWithRed:64/255.0 green:131/255.0 blue:221/255.0 alpha:1];
        self.loginButton.layer.cornerRadius = 3;
        self.loginButton.layer.masksToBounds = YES;
        [self.loginButton addTarget:self action:@selector(dengluChick:) forControlEvents:UIControlEventTouchUpInside];
        UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(100, 17, 10, 10)];
        _juhua = activity;
        [self.loginButton addSubview:activity];
        
        // 设置互联客LOGO
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(440,70, 125,165) ];// Image:
        imageView.image = [UIImage imageNamed:@"hlklogo"];
        //imageView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:imageView];
        
        [self.view addSubview:self.loginButton];
    }
     
}

- (void)dengluChick:(UIButton *)btn{
    
    
    NSLog(@"into here ...");
    if (self.flagTag == YES) {
        btn.userInteractionEnabled = NO;
        self.juhua.hidden = NO;
        NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/mobile/logout",ceshiIP];
        NSLog(@"logout URL :%@",urlString);
        [HttpTool GET:urlString parameters:nil success:^(id responseObject) {
            
            [self login];
            self.flagTag = NO;
        } failure:^(NSError *error) {
            NSLog(@"交接班  登陆失败：%@",error.localizedDescription);
            self.loginButton.userInteractionEnabled = YES;
            self.juhua.hidden = YES;
        }];
        return;
        
    }
    [self login];

}

- (void)login{

    [self.zhanghao resignFirstResponder];
    [self.mima resignFirstResponder];
   // sleep(0.5);
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/login?username=%@,72e12515-f54f-11e4-af9a-02004c4f4f50&password=%@&from=mobile",ceshiIP,self.zhanghao.text,self.mima.text];
    self.juhua.hidden = NO;
    [HttpTool POST:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"login"];
        NSString *value = [dict objectForKey:@"value"];
        if ([value isEqualToString:@"0"]) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
//            UIWindow *window = [UIApplication sharedApplication].keyWindow;
//            MainViewController *mainV = [[MainViewController alloc] init];
//            CATransition *transition = [CATransition animation];
//            transition.duration = 1.5;
//            transition.type = @"rippleEffect";
//            [window.layer addAnimation:transition forKey:nil];
//            window.rootViewController = mainV;
            
          
        }else{
            
            [self showErrorWithMessage:@"登陆失败"];
            self.juhua.hidden = YES;
             self.loginButton.userInteractionEnabled = YES;
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        self.juhua.hidden = YES;
         self.loginButton.userInteractionEnabled = YES;
        [self showErrorWithMessage:@"登陆超时"];
    }];
}

- (void)showErrorWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.pieView reloadData];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.pieView reloadData];
}


- (void)viewDidUnload
{
    [self setPieView:nil];
    [super viewDidUnload];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.yingyetongjiLabel.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.yingyetongjiBackgroundView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    self.huiyuankachongzhiyutuikaLabel.textColor = [UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1];
    self.huiyuankachongzhiyutuikaLabel.font= [UIFont boldSystemFontOfSize:17];
    //self.yingyetongjiLabel.frame = CGRectMake(0, 0, , )
    
    self.remark.layer.borderWidth = 1;
    self.remark.layer.borderColor = [[UIColor blackColor]CGColor];
    self.remark.layer.cornerRadius = 5;
    if (_isDaYang) {
        [self.qiehuandenglu setTitle:@"确认打烊" forState:UIControlStateNormal];
        [self.qiehuandenglu setBackgroundColor:[UIColor lightGrayColor]];
    }else{
        
        [self.qiehuandenglu setTitle:@"切换登陆" forState:UIControlStateNormal];
    }
    self.qiehuandenglu.layer.cornerRadius = 5;
    self.qiehuandenglu.layer.masksToBounds = YES;
    self.flagTag = YES;
    
    //pie
    [self setUpPie];

    [self requestTransfreInfo];
    
}

- (void)setUpPie{
    
    self.slices = [NSMutableArray arrayWithCapacity:10];
    
    for(int i = 0; i < 2; i ++)
    {
        NSNumber *one = [NSNumber numberWithInt:rand()%20];
        [_slices addObject:one];
    }
    
    self.sliceColors =[NSArray arrayWithObjects:
                       [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1],
                       [UIColor colorWithRed:113/255.0 green:183/255.0 blue:254/255.0 alpha:1],
                       [UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                       [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                       [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                       [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                       [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1],nil];
    
    //    [self.pieView setDelegate:self];
    //    [self.pieView setDataSource:self];
    //    [self.pieView setPieCenter:CGPointMake(144 , 105)];
    //    [self.pieView setShowPercentage:NO];
    //    [self.pieView setLabelColor:[UIColor blackColor]];
    //    [self.pieView setPieRadius:75];
    //    [self.pieView setLabelRadius:45];
    
    [self.pieView setDataSource:self];
    [self.pieView setStartPieAngle:M_PI_2];
    [self.pieView setAnimationSpeed:2.0];
    [self.pieView setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:16]];
    [self.pieView setLabelRadius:10];
    [self.pieView setShowPercentage:YES];
    [self.pieView setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.pieView setPieCenter:CGPointMake(144, 105)];
    [self.pieView setUserInteractionEnabled:NO];
    [self.pieView setLabelShadowColor:[UIColor blackColor]];
    [self.pieView setPieRadius:75];
    
    //设置中心圆
    UILabel *label = [[UILabel alloc] init];
    label.width = 95;
    label.height = 95;
    label.center = CGPointMake(144, 105);
    label.backgroundColor = [UIColor whiteColor];
    label.layer.cornerRadius = label.width / 2;
    label.layer.masksToBounds = YES;
    [self.pieView addSubview:label];
}



//请求总的服务器数据
- (void)requestTransfreInfo{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/employe/shift?returnJson=json&mobile=ios",ceshiIP];
    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {

        
        NSArray *arr = [responseObject objectForKey:@"paymentTypeVOsOrder"];
        self.yufukuanArr = [paymentTypeVOsOrder objectArrayWithKeyValuesArray:arr];
        //交接人
        [self setJiaoBanRenInfoWith:responseObject];
        //预付款
        [self setYufukuanInfo];
        //会员卡充值和退卡
        arr = [responseObject objectForKey:@"paymentTypeVOsForm"];
        self.vipInfoArr = [paymentTypeVOsForm objectArrayWithKeyValuesArray:arr];
        [self setVipInfoWith:self.vipInfoArr];
        //设置交班信息设计
        [self setJiaoBanXinXi:responseObject];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//设置交班信息设计
- (void)setJiaoBanXinXi:(id)respos{
    
}

//设置会员卡充值和退卡数据
- (void)setVipInfoWith:(NSMutableArray *)arr{
    CGFloat sum = 0.00;
    for (paymentTypeVOsForm *pay in arr) {
        if ([pay.paymentType isEqualToString:@"1"]) {
            if (pay.money.length) {
                self.vipxianjin.text = pay.money;
                sum = sum + pay.money.floatValue;
            }else{
                self.vipxianjin.text = @"0";
            }
            
        }else if ([pay.paymentType isEqualToString:@"2"]){
            if (pay.money.length) {
                self.vipyinhangka.text = pay.money;
                sum = sum + pay.money.floatValue;
            }else{
                self.vipyinhangka.text = @"0";
            }
        }
    }
    
    self.vipheji.text = [NSString stringWithFormat:@"%.2f",sum];
}
//设置交班人信息数据
- (void)setJiaoBanRenInfoWith:(id)responseObject{
    
    self.jiaobanren.text = [responseObject objectForKey:@"employeeName"];
    self.shangcijiaobanshijian.text = [responseObject objectForKey:@"shiftTime"];
    self.bencijiaobanshijian.text = [responseObject objectForKey:@"iosLastShiftTime"];
    
}
//设置预付款信息数据
- (void)setYufukuanInfo{
    CGFloat sum = 0.00;
    for (paymentTypeVOsOrder *pay in self.yufukuanArr) {
        if ([pay.paymentType isEqualToString:@"1"]) {
            if (pay.money.length) {
                self.xianjinzhifu.text = pay.money;
                sum = sum + pay.money.floatValue;
            }else{
                self.xianjinzhifu.text = @"0";
            }
            
        }else if ([pay.paymentType isEqualToString:@"2"]){
            if (pay.money.length) {
                self.yinhangkazhifu.text = pay.money;
                sum = sum + pay.money.floatValue;
            }else{
                self.yinhangkazhifu.text = @"0";
            }
        }else if ([pay.paymentType isEqualToString:@"11"]){
            if (pay.money.length) {
                self.zaixianzhifu.text = pay.money;
                sum = sum + pay.money.floatValue;
            }else{
                self.zaixianzhifu.text = @"0";
            }
        }
    }
    
    self.heji.text = [NSString stringWithFormat:@"%.2f",sum];
}


#pragma mark - pieView的代理和数据源方法

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{

    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSMutableArray *)yufukuanArr{
    
    if (_yufukuanArr == nil) {
        _yufukuanArr = [NSMutableArray array];
    }
    return _yufukuanArr;
}

- (NSMutableArray *)vipInfoArr{
    
    if (_vipInfoArr == nil) {
        _vipInfoArr = [NSMutableArray array];
    }
    return _vipInfoArr;
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
