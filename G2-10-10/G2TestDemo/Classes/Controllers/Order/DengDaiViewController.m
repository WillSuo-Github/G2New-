//
//  DengDaiViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/10.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "DengDaiViewController.h"
#import "ZhiFuPG.h"
#import "MJExtension.h"
#import "HttpTool.h"
#import "XiaoFeiSuccessController.h"
#import "ZhiFuBaoZhiFuPG.h"
#import "ZhiFuLeiXingUpDataGP.h"

@interface DengDaiViewController (){
    
    NSTimer *_timer;
    NSInteger _chaoshishijian;//超时时间
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) XiaoFeiSuccessController *xiaofeiSuc;



@end

@implementation DengDaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 32, 32);
    [btn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -30)];

    self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    //
//    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 100)];
//    
//    if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]) {
//        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
//        datubiaoImage.image = [UIImage imageNamed:@"hlk_zfb1"];
//        
//        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
//        zhifuleixingLabel.text = @"支付宝支付";
//        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
//        [zhifuleixingLabel sizeToFit];
//        [zhongjianView addSubview:datubiaoImage];
//        [zhongjianView addSubview:zhifuleixingLabel];
//        
//        
//        //添加导航条中间图标
//        
//        UIButton *titleButton = [[UIButton alloc]init];
//        [titleButton setImage:[UIImage imageNamed:@"hlk_zfb1"] forState:UIControlStateNormal];
//        [titleButton setTitle:@"支付宝支付" forState:UIControlStateNormal];
//    
//        
//        
//       
//        self.navigationItem.titleView = titleButton; //zhongjianView;
//        
//    }else if([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]){
//        
//        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
//        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
//        
//        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
//        zhifuleixingLabel.text = @"微信支付";
//        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
//        [zhifuleixingLabel sizeToFit];
//        [zhongjianView addSubview:datubiaoImage];
//        [zhongjianView addSubview:zhifuleixingLabel];
//        self.navigationItem.titleView = zhongjianView;
//        
//    }// add 15-11-12
//    else if([self.zhifuchuandi.PayType isEqualToString:@"QQ钱包"]){
//        
//        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
//        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
//        
//        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
//        zhifuleixingLabel.text = @"QQ钱包";
//        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
//        [zhifuleixingLabel sizeToFit];
//        [zhongjianView addSubview:datubiaoImage];
//        [zhongjianView addSubview:zhifuleixingLabel];
//        self.navigationItem.titleView = zhongjianView;
//        
//    }
//    // add 15-11-19
//    else if([self.zhifuchuandi.PayType isEqualToString:@"百度钱包支付"]){
//        
////        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
////        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
//        
//        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
//        zhifuleixingLabel.text = @"百度钱包支付";
//        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
//        [zhifuleixingLabel sizeToFit];
//       // [zhongjianView addSubview:datubiaoImage];
//        [zhongjianView addSubview:zhifuleixingLabel];
//        self.navigationItem.titleView = zhongjianView;
//    
//    }
//    
    
//    _label=[[UILabel alloc]initWithFrame:CGRectMake(200, 100, 300, 50)];
    _label.text=[NSString stringWithFormat:@"正在连接%@",self.zhifuchuandi.PayType];
    _label.font=[UIFont boldSystemFontOfSize:30];
//    [self.view addSubview:_label];
    
    _chaoshishijian = 120;

    // Do any additional setup after loading the view from its nib.
    
//    CGRect frame = CGRectMake(50,50,100,100);
//    frame.size = [UIImage imageNamed:@"guzhang.gif"].size;
//    self.webView.frame = frame;
//        // 读取gif图片数据
//    self.webView.size = CGSizeMake(200, 200);
    
    // modify by manman for start of line
    // 更换图片
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"animationCircleSmall" ofType:@"gif"]];
    
    // end of line
    
   // NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"ylk_ddh1" ofType:@"gif"]];

    
    [self.webView loadData:gif MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    self.webView.scalesPageToFit = YES;
    
    [self updatezhifuleixing];
    
}



/**
 *  请求支付宝支付
 */
- (void)requestZhiFuBaoZhiFuWith:(NSString *)forwardUrl{
    /**
    @property (nonatomic, copy) NSString *out_trade_no;
    @property (nonatomic, copy) NSString *scene;
    @property (nonatomic, copy) NSString *auth_code;
    @property (nonatomic, copy) NSString *total_amount;
    @property (nonatomic, copy) NSString *subject;
     */
    
    ZhiFuBaoZhiFuPG *zhifupg = [[ZhiFuBaoZhiFuPG alloc] init];
    zhifupg.out_trade_no = forwardUrl;
    zhifupg.scene = @"bar_code";
    zhifupg.auth_code = self.zhifuchuandi.erweimaStr;
    zhifupg.total_amount = self.zhifuchuandi.count;
    zhifupg.cptId = self.zhifuchuandi.cptID;
//    zhifupg.total_amount = [NSString stringWithFormat:@"%.0f",self.count.floatValue * 100];
    zhifupg.subject = self.zhifuchuandi.billID;
    if ([self.zhifuchuandi.whereFrom isEqualToString:@"预定"]) {
        zhifupg.out_trade_no = self.zhifuchuandi.orderNo;
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/barPay.do",ceshiIP];
    NSLog(@"URL:%@",urlStr);
    [HttpTool POST:urlStr parameters:zhifupg.keyValues success:^(id responseObject) {
        
        NSLog(@"zhifubao request :%@",responseObject);
        
        NSDictionary *dict = [responseObject objectForKey:@"alipay_trade_pay_response"];
        NSString *code = [dict objectForKey:@"code"];
        if ([code isEqualToString:@"40004"]) {
            [self showAlertViewWithMessage:@"该订单已支付"];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(requestZhiFuBaoPayStates) userInfo:nil repeats:YES];
            
            [_timer fire];
        }
        

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



//支付宝 支付状态
- (void)requestZhiFuBaoPayStates{
    
    _chaoshishijian -= 1;
    if (_chaoshishijian == 0) {
        [self showAlertViewWithMessage:@"支付超时"];
        [_timer invalidate];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/run/barPay/queryPaymement?returnJson=json",ceshiIP];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.zhifuchuandi.billID,@"id",self.zhifuchuandi.cptID,@"paymentType", nil];
        
        
        NSLog(@"Info:%@",dict);
        
        [HttpTool GET:urlStr parameters:dict success:^(id responseObject) {
           NSLog(@"responseObject info %@",responseObject);
            NSMutableArray *arr = [responseObject objectForKey:@"list"];
            NSMutableDictionary *dict = [arr firstObject];
            NSString *billStatus = [dict objectForKey:@"billStatus"];
            
            
            if ([billStatus isEqualToString:@"1"])
            {
                
                [_timer invalidate];
                [self jiezhang];
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
}

/**
 *   结账 微信支付
 */
- (void)requestWinXinZhiFu{
    
    ZhiFuPG *zhifupg = [[ZhiFuPG alloc] init];
    zhifupg.out_trade_no = self.zhifuchuandi.billID;
//    zhifupg.out_trade_no = @"22222321652354654";
    zhifupg.auth_code = self.zhifuchuandi.erweimaStr;
    zhifupg.total_fee = [NSString stringWithFormat:@"%.0f",self.zhifuchuandi.count.floatValue * 100];
    zhifupg.body = @"餐饮支付";
    zhifupg.device_info = @"5321354";
    if ([self.zhifuchuandi.whereFrom isEqualToString:@"预定"]) {
        zhifupg.out_trade_no = self.zhifuchuandi.orderNo;
    }
    
//    NSLog(@"%@",zhifupg.keyValues);
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/WiXinbarPay.do",ceshiIP];
//    NSLog(@"%@",urlStr);
    [HttpTool POST:urlStr parameters:zhifupg.keyValues success:^(id responseObject) {
        NSLog(@"responseObject+++%@",responseObject);
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"SUCCESS"]
            &&[[responseObject objectForKey:@"result_code"] isEqualToString:@"SUCCESS"]) {
            
            if (self.zhifuchuandi.idIdentifyStr.length != 0)
            {
                [self updataPersonRechargeAmount];
                
            }
            
        [self jiezhang];
        }else{
            
            [self showAlertViewWithMessage:[responseObject objectForKey:@"return_msg"]];
        }
//        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/**
 *  QQWallet quick pay
 */
//http://127.0.0.1:8080/canyin-frontdesk/tenPay/payRequest?auth_code=&sp_billno=&total_fee=
- (void)requestQQWalletPayMoney:(NSString *)forwardUrl{
    
    ZhiFuPG *zhifupg = [[ZhiFuPG alloc] init];
    zhifupg.out_trade_no = forwardUrl;
   // zhifupg.out_trade_no = self.zhifuchuandi.billID;
    // zhifupg.out_trade_no = @"22222321652354654";
    zhifupg.auth_code = self.zhifuchuandi.erweimaStr;
    zhifupg.total_fee = [NSString stringWithFormat:@"%.0f",self.zhifuchuandi.count.floatValue * 100];
    zhifupg.body = @"餐饮支付";
    zhifupg.device_info = @"5321354";

    if ([self.zhifuchuandi.whereFrom isEqualToString:@"预定"]) {
        zhifupg.out_trade_no = self.zhifuchuandi.orderNo;
    }
    
    //    NSLog(@"%@",zhifupg.keyValues);
   // NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/WiXinbarPay.do",ceshiIP];
    //    NSLog(@"%@",urlStr);
    
    NSString *QQUrl = [NSString stringWithFormat:@"%@/canyin-frontdesk/tenPay/payRequest",ceshiIP];
    NSLog(@"qqUrl:%@",QQUrl);
    
    [HttpTool GET:QQUrl parameters:zhifupg.keyValues success:^(id responseObject) {
         NSLog(@"QQWallet %@",responseObject);
        NSString *statusCode = [responseObject objectForKeyedSubscript:@"statusCode"];
        NSString *value = [responseObject objectForKeyedSubscript:@"value"];
        if (statusCode.integerValue == 0 && [value isEqualToString:@"ok"])
        {
            NSLog(@"QQ Wallet success");
            [self jiezhang];
        }else{
            
            [self showAlertViewWithMessage:[responseObject objectForKey:@"value"]];
        }
        //        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


/**
 *  百度钱包支付
 */
- (void)requestBaiDuWalletZhiFu:(NSString *)forwardUrl{
    
    
    
    ZhiFuPG *zhifupg = [[ZhiFuPG alloc] init];
    zhifupg.out_trade_no = forwardUrl;
    // zhifupg.out_trade_no = self.zhifuchuandi.billID;
    // zhifupg.out_trade_no = @"22222321652354654";
    zhifupg.auth_code = self.zhifuchuandi.erweimaStr;
    zhifupg.total_fee = [NSString stringWithFormat:@"%.0f",self.zhifuchuandi.count.floatValue * 100];
    zhifupg.body = @"餐饮支付";
    zhifupg.device_info = @"5321354";
    
    if ([self.zhifuchuandi.whereFrom isEqualToString:@"预定"]) {
        zhifupg.out_trade_no = self.zhifuchuandi.orderNo;
    }

    
    NSString *baiDuUrl = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/baiduPay/Pay",ceshiIP];
    NSLog(@"baiDuUrl:%@",baiDuUrl);
    
    [HttpTool GET:baiDuUrl parameters:zhifupg.keyValues success:^(id responseObject) {
        NSLog(@"baiDuWallet %@",responseObject);
        NSString *statusCode = [responseObject objectForKeyedSubscript:@"statusCode"];
        NSString *value = [responseObject objectForKeyedSubscript:@"value"];
        if (statusCode.integerValue == 0 && [value isEqualToString:@"OK"])
        {
            NSLog(@"baiDu Wallet success");
            [self jiezhang];
        }else{
            
            [self showAlertViewWithMessage:[responseObject objectForKey:@"value"]];
        }
        //[self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
 
}





- (void)updatezhifuleixing{
    
    ZhiFuLeiXingUpDataGP *zhifuleixing = [[ZhiFuLeiXingUpDataGP alloc] init];
    zhifuleixing.cptId = self.zhifuchuandi.cptID;
    zhifuleixing.billId = self.zhifuchuandi.billID;
//    zhifuleixing.paymentType = @"1";
//    if ([self.whereFrom isEqualToString:kWaiMaiJieZhangFromStr]) {
//        zhifuleixing.paymentType = @"2";
//    }
//    zhifuleixing.isSuc = @"0";
//    if ([self.whereFrom isEqualToString:@"预定"]) {
//        zhifuleixing.paymentType = @"2";
//    }
//    NSLog(@"%@",self.paymentType);
    zhifuleixing.paymentType = self.zhifuchuandi.paymentType;
    zhifuleixing.money = self.zhifuchuandi.count;
    
    NSLog(@"keyValues%@",zhifuleixing.keyValues);
    NSLog(@"self.zhifuchuandi.cptID :%@",self.zhifuchuandi.cptID );
     NSLog(@" self.zhifuchuandi.billID :%@", self.zhifuchuandi.billID);
    
   
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pop/paymentType/update",ceshiIP];
    [HttpTool POST:urlStr parameters:zhifuleixing.keyValues success:^(id responseObject) {
        NSLog(@"%@",responseObject);
//        [self jiezhang];
        NSString *forwardUrl = [responseObject objectForKey:@"forwardUrl"];
        
        
        if ([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]) {
            [self requestWinXinZhiFu];
        }else if ([self.zhifuchuandi.PayType isEqualToString:@"QQ钱包"]) {
            [self requestQQWalletPayMoney:forwardUrl];
        }
        else if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]){
            [self requestZhiFuBaoZhiFuWith:forwardUrl];
        }
        else if ([self.zhifuchuandi.PayType isEqualToString:@"百度钱包支付"]){
            [self requestBaiDuWalletZhiFu:forwardUrl];
        }
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


- (void)jiezhang{
    
        //发送成功消费的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:KzhifuSuccess object:nil userInfo:self.zhifuchuandi.PayType];
    
    if (self.zhifuchuandi.billID.length)
    {
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pay/%@?isPrint=false&isForce=true&rid=0.23375838149835548",ceshiIP,self.zhifuchuandi.billID];
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject)
        {
//            NSLog(@"%@",responseObject);
            XiaoFeiSuccessController *xiaofeiSucc = [[XiaoFeiSuccessController alloc] init];
            self.xiaofeiSuc = xiaofeiSucc;
            
            if ([self.zhifuchuandi.whereFrom isEqualToString:kWaiMaiJieZhangFromStr]) {
                
                    //外卖结账成功
                DLog(@"waimaijiezhangchenggong");
            }else{
                
                [self qingtai];
                
            }
            [self.navigationController pushViewController:xiaofeiSucc animated:YES];
            
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    
}

- (void)qingtai{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/index/qingtai/%@",ceshiIP,self.zhifuchuandi.tabID];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        //[self showAlertViewWithMessage:@"交易成功"];
        
        
        //发送通知
        [[NSNotificationCenter defaultCenter]postNotificationName:KxianjinxiaofeiSuccess object:nil];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)back{


    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(BOOL)updataPersonRechargeAmount
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithCapacity:5];
    [mDic setObject:self.zhifuchuandi.idIdentifyStr forKey:@"cardNO"];
    [mDic setObject:self.zhifuchuandi.count forKey:@"rechargeCash"];
    [mDic setObject:self.zhifuchuandi.PayType forKey:@"new_paymentType"];
    
    NSString *rechargeUrlStr = @"http://127.0.0.1:8080/canyin-frontdesk/member/chongzhi/create";
    
    
    [HttpTool POST:rechargeUrlStr parameters:mDic success:^(id responseObject) {
        
        NSLog(@"respond:%@",responseObject);
        
        // 弹出成功页面
    } failure:^(NSError *error) {
        NSLog(@"error:%@",[error localizedDescription]);
        
    }];
    
    
    
   
    return YES;
    
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
