//
//  SaoMiaoController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/10.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ScanController1.h"
#import <AVFoundation/AVFoundation.h>
#import "HttpTool.h"
#import "PromptConsumerSuccessViewController.h"

#import "DengDaiViewController.h"
#import "Common.h"
#import "NDLBusinessConfigure.h"
@interface ScanController1 ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
{
    NSTimer *_timer;
    NSInteger _chaoshishijian;//超时时间
}

@property (strong,nonatomic)AVCaptureDevice * device;

@property (strong,nonatomic)AVCaptureDeviceInput * input;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;

@property (strong,nonatomic)AVCaptureSession * session;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (strong, nonatomic) UIView *boxView;
@property (nonatomic) BOOL isReading;
@property (strong, nonatomic) CALayer *scanLayer;
@property(strong,nonatomic)UIImageView *scanRoundimage;
@property(strong,nonatomic)UIImageView *scanLine;




@property(strong,nonatomic)PromptConsumerSuccessViewController *promptConsumerSuccessViewController;
@property (nonatomic, strong) DengDaiViewController *dengdaiVc;

@end

@implementation ScanController1

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    UIImage *backImage = [UIImage imageNamed:@"hlk_fh"];
    
    UIButton *backButton = [[UIButton alloc]init];
    [backButton setImage:backImage forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, -50)];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backItem;
    
    
    [self setNavigationTitleView];
    
    //添加QRCode灰层
    UIImageView *scanQRCode = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    scanQRCode.image = [UIImage imageNamed:@"ScanQRCodeFrame4"];
    [self.view addSubview:scanQRCode];
    
    
    CGRect promptFrame = self.scanRoundimage.frame;
    promptFrame.origin.y+= 382;
    promptFrame.origin.x;// += 30;
    promptFrame.size.height = 50;
    promptFrame.size.width = 300;
    
    UILabel *QRCodePromptLabel = [[UILabel alloc]initWithFrame:promptFrame];
    QRCodePromptLabel.text = @"将二维码放入框内，即可自动扫描";
    QRCodePromptLabel.textColor = [UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
    QRCodePromptLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    QRCodePromptLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.view insertSubview:QRCodePromptLabel aboveSubview:scanQRCode];
    
    
    
    
    
    
    
// Do any additional setup after loading the view.

    
    self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);

//    NSLog(@"%+++++++ld",[[UIDevice currentDevice]orientation]);
//    if ([[UIDevice currentDevice]orientation] == 4) {
//        self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
//    }else{
//        
//        self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
//    }
    
        // Device
    
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
        // Input
    
//    _input = [AVCaptureDeviceInputdeviceInputWithDevice:self.deviceerror:nil];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];

        // Output
    
    _output = [[AVCaptureMetadataOutput alloc]init];
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    
        // Session
    
    _session = [[AVCaptureSession alloc]init];
    
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:self.input])
        
        {
        
        [_session addInput:self.input];
        
        }
    
    if ([_session canAddOutput:self.output])
        
        {
        
        [_session addOutput:self.output];
        
        }
    
        // 条码类型 AVMetadataObjectTypeQRCode
    
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
//    [_output setRectOfInterest:CGRectMake(400,0.1,400, 0.1)];
//
////    [_output setRectOfInterest:CGRectMake((60+64)/kScreenHeight,((kScreenWidth-220)/2)/kScreenWidth,220/kScreenWidth,220/kScreenHeight)];
//    
//    [_output setRectOfInterest:CGRectMake((124)/kScreenHeight,((kScreenWidth-220)/2)/kScreenWidth,220/kScreenHeight,220/kScreenWidth)];
    
        // Preview
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    
    
    _preview.frame =self.view.layer.bounds;
    
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    
    

//    _boxView = [[UIView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f, _preview.bounds.size.height * 0.2f, self.view.bounds.size.width * 0.4, self.view.bounds.size.height - self.view.bounds.size.height * 0.4f)];
//    _boxView.layer.borderColor = [UIColor greenColor].CGColor;
//    _boxView.layer.borderWidth = 1.0f;
//    [self.view addSubview:_boxView];
    
    self.scanRoundimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f, _preview.bounds.size.height * 0.2f +25, self.view.bounds.size.width * 0.4, self.view.bounds.size.width * 0.4 )];//self.view.bounds.size.height - self.view.bounds.size.height * 0.4f)];
//    NSLog(@"Scan QRCode Frame :%@",NSStringFromCGRect(self.scanRoundimage.frame));
    self.scanRoundimage.image = [UIImage imageNamed:@"HR_border"];
    self.scanLine = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f +25, _preview.bounds.size.height * 0.2f+25, self.view.bounds.size.width * 0.4, self.view.bounds.size.width * 0.4)];
    
    self.scanLine.image = [UIImage imageNamed:@"HR_scan_line"];
    self.scanLine.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.view addSubview:self.scanRoundimage];
    [self.view insertSubview:self.scanLine aboveSubview:self.scanRoundimage];
   // NSLog(@"view%@",NSStringFromCGRect(self.view.frame));
   // NSLog(@"image%@",NSStringFromCGRect(self.scanRoundimage.frame));
    
    [self move];
    
//        //10.2.扫描线
//    _scanLayer = [[CALayer alloc] init];
//    _scanLayer.frame = CGRectMake(0, 0, _boxView.bounds.size.width, 1);
//    _scanLayer.backgroundColor = [UIColor brownColor].CGColor;
//    [_boxView.layer addSublayer:_scanLayer];
    
        // Start
    
    [_session startRunning];
}


-(void)setNavigationTitleView
{
    
    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]) {
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hlk_zfb1"];
       // [self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hlk_zfb"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = [NSString stringWithFormat:@"￥%@",self.zhifuchuandi.count];
        //zhifuleixingLabel.text = @"支付宝支付";
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView;
        
    }else if([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]){
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
        //[self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hkl_wxzf1"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        //zhifuleixingLabel.text = @"微信支付";
        zhifuleixingLabel.text = [NSString stringWithFormat:@"￥%@",self.zhifuchuandi.count];
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView ;
        
    }else if([self.zhifuchuandi.PayType isEqualToString:@"银行卡"]){
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        //zhifuleixingLabel.text = @"银行卡";
        zhifuleixingLabel.text = [NSString stringWithFormat:@"￥%@",self.zhifuchuandi.count];
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView;
    } // add 15-11-12
    else if([self.zhifuchuandi.PayType isEqualToString:@"QQ钱包"]){
        UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, 42, 42)];
        //datubiaoImage.image = [UIImage imageNamed:@"hkl_wxzf1"];
        //[self.xiaotubiaoImage setImage:[UIImage imageNamed:@"hkl_wxzf1"]];
        UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 80, 50)];
        zhifuleixingLabel.text = [NSString stringWithFormat:@"￥%@",self.zhifuchuandi.count];
        [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
        [zhifuleixingLabel sizeToFit];
        [zhongjianView addSubview:datubiaoImage];
        [zhongjianView addSubview:zhifuleixingLabel];
        self.navigationItem.titleView = zhongjianView ;
        
    }
    
    
    
    
    
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0){
        
            //停止扫描
        
            //        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        stringValue = metadataObject.stringValue;
        
//        NSLog(@"%@",stringValue);
//        NSLog(@"%@",self.billID);

        if (stringValue) {
            
            [_session stopRunning];
            
            DengDaiViewController *dengdaiVc = [[DengDaiViewController alloc] init];
            
            ZhiFuChuanDiPG *zhifuchuandi = [[ZhiFuChuanDiPG alloc]init];
            zhifuchuandi.PayType = self.zhifuchuandi.PayType;

            zhifuchuandi.idIdentifyStr = self.zhifuchuandi.idIdentifyStr;
            zhifuchuandi.VIPforwardUrl = self.zhifuchuandi.VIPforwardUrl;
            zhifuchuandi.amountPledges = self.zhifuchuandi.amountPledges;
            self.zhifuchuandi.QRCodeValueStr = stringValue;

            
            zhifuchuandi.count = self.zhifuchuandi.count;
            zhifuchuandi.billID = self.zhifuchuandi.billID;
            zhifuchuandi.erweimaStr = stringValue;
            zhifuchuandi.whereFrom = self.zhifuchuandi.whereFrom;
            zhifuchuandi.orderNo = self.zhifuchuandi.orderNo;
            zhifuchuandi.cptID = self.zhifuchuandi.cptID;
            zhifuchuandi.tabID = self.zhifuchuandi.tabID;
            zhifuchuandi.paymentType = self.zhifuchuandi.paymentType;
            dengdaiVc.zhifuchuandi = zhifuchuandi;
            self.dengdaiVc = dengdaiVc;
            
            if ([self.zhifuchuandi.whereFrom isEqualToString:@"VIPCREATCHONGZHI"]) {
                [self identifyVIPRecharge];
            }
            else
            {
          
            
            
            [self.navigationController pushViewController:dengdaiVc animated:YES];
            
            }
        }
        
    }
    
    
}

 -(void)identifyVIPRecharge
{
        if ([self.zhifuchuandi.PayType isEqualToString:@"微信支付"]) {
            [self requestServerWECHATInfo];
            
            //[self requestWinXinZhiFu];
        }else if ([self.zhifuchuandi.PayType isEqualToString:@"支付宝支付"]){
            
            [self requestServerZHIFUBAOInfo];
            
            
        }
    
    
}

/**
 *   VIP  WECHAT 请求
 *
 *
 */


//  /run/barPay/savePaymement?cpt_id=&card_id=&momey=&returnJson=json
-(void)requestServerWECHATInfo
{
    //NSString *testAmount = [NSString stringWithFormat:@"%lf",self.zhifuchuandi.count.floatValue *100];
    //NSLog(@"WECHAT Recharge amount:%@  real:%lf",testAmount,self.zhifuchuandi.count.floatValue *100);
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/run/barPay/savePaymement?cpt_id=%@&card_id=%@&momey=%@&auth_code=%@&subject=%@&returnJson=json",ceshiIP,self.zhifuchuandi.cptID,self.zhifuchuandi.VIPforwardUrl,self.zhifuchuandi.count,self.zhifuchuandi.QRCodeValueStr,@"VIPRecharge"];
    NSLog(@"Vip WECHAT recharge :%@",urlStr);
    
    self.promptConsumerSuccessViewController = [[PromptConsumerSuccessViewController alloc]init];
    ZhiFuChuanDiPG *zhiFuChuanDiPG = [[ZhiFuChuanDiPG alloc]init];
    zhiFuChuanDiPG.PayType = self.zhifuchuandi.PayType;
    
    zhiFuChuanDiPG.idIdentifyStr = self.zhifuchuandi.idIdentifyStr;
    zhiFuChuanDiPG.VIPforwardUrl = self.zhifuchuandi.VIPforwardUrl;
    zhiFuChuanDiPG.amountPledges = self.zhifuchuandi.amountPledges;
    zhiFuChuanDiPG.count = self.zhifuchuandi.count;
    zhiFuChuanDiPG.billID = self.zhifuchuandi.billID;
    zhiFuChuanDiPG.whereFrom = self.zhifuchuandi.whereFrom;
    zhiFuChuanDiPG.orderNo = self.zhifuchuandi.orderNo;
    zhiFuChuanDiPG.cptID = self.zhifuchuandi.cptID;
    zhiFuChuanDiPG.tabID = self.zhifuchuandi.tabID;
    zhiFuChuanDiPG.paymentType = self.zhifuchuandi.paymentType;
    self.promptConsumerSuccessViewController.zhiFuChuanDiPG = zhiFuChuanDiPG;
    
    
    
    
    
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"Vip WECHAT  recharge response :%@",responseObject);
        
        //NSDictionary *dic = [responseObject objectForKey:@"return_code"];
        NSString *responseResultStr = [responseObject objectForKey:@"result_code"];//result_code
        if ([responseResultStr isEqualToString:@"SUCCESS"])
        {
            
            //界面跳转  到成功页面
            NSLog(@"WECHAT recharge success");
            // 充值成功
            [self.navigationController pushViewController:self.promptConsumerSuccessViewController animated:YES];
            
        }else if ([responseResultStr isEqualToString:@"FAIL"])
        {
           // NSString *errorCodeDes = [responseObject objectForKey:@"err_code_des"];
            
            [self showAlertViewWithMessage:@"付款失败"];

                //UIAlertView显示错误信息
            
            // 充值失败  显示失败原因
            
        }
    } failure:^(NSError *error) {
        NSLog(@"Vip WECHAT  recharge :error %@",[error localizedDescription]);
        
    }];
    
    
}





/**
 *  支付宝 支付请求
 *
 *
 */

//  /run/barPay/savePaymement?cpt_id=&card_id=&momey=&returnJson=json
-(void)requestServerZHIFUBAOInfo
{
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/run/barPay/savePaymement?cpt_id=%@&card_id=%@&momey=%@&auth_code=%@&subject=%@&returnJson=json",ceshiIP,self.zhifuchuandi.cptID,self.zhifuchuandi.VIPforwardUrl,self.zhifuchuandi.count,self.zhifuchuandi.QRCodeValueStr,@"VIPRecharge"];
    NSLog(@"Vip ZHIFUBAO recharge :%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"Vip  ZHIFUBAO  recharge response :%@",responseObject);
        NSString *out_trade_no = [responseObject objectForKeyedSubscript:@"out_trade_no"];
        if (out_trade_no) {
            self.zhifuchuandi.VIPRechargeOutStr = out_trade_no;
            _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(requestZhiFuBaoPayStates) userInfo:nil repeats:YES];
            [_timer fire];
        }
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"Vip ZHIFUBAO recharge :error %@",[error localizedDescription]);
        
    }];
    
    
 
    //[timer fire];
    
    
    
}


// VIP  支付宝 支付状态
- (void)requestZhiFuBaoPayStates{
    
    _chaoshishijian -= 1;
    if (_chaoshishijian == 0) {
        [self showAlertViewWithMessage:@"支付超时"];
        [_timer invalidate];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{

        
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/run/barPay/queryCardPaymement?returnJson=json",ceshiIP];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.zhifuchuandi.VIPRechargeOutStr,@"id",self.zhifuchuandi.VIPforwardUrl,@"cardId", nil];
        NSLog(@"Info:%@",dict);
        
        [HttpTool GET:urlStr parameters:dict success:^(id responseObject) {
            NSLog(@"responseObject info %@",responseObject);
            NSMutableArray *arr = [responseObject objectForKey:@"list"];
            NSMutableDictionary *dict = [arr firstObject];
            NSString *status = [dict objectForKey:@"stutas"];
            
            NSLog(@"status :%@",status);
            if ([status isEqualToString:@"1"])
            {
                
                [_timer invalidate];
                _timer = nil;
                
            [self VIPRechargeServerOrder];
                
            }
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }
    
}

- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"WECHAT into here");
    [self.navigationController popViewControllerAnimated:YES];
   // self.navigationController pop
    
    
}

//    x:self.view.bounds.size.width * 0.2f +25
 // Y: _preview.bounds.size.height * 0.2f +25
//width:self.view.bounds.size.width * 0.4
//height:self.view.bounds.size.width * 0.4

- (void)move
{
    [UIView animateWithDuration:2 animations:^{
        self.scanLine.frame = CGRectMake(191,182, 20,400);
    } completion:^(BOOL finished) {

        [self moveBack];
    }];
}

- (void)moveBack
{
    [UIView animateWithDuration:2 animations:^{
        self.scanLine.frame = CGRectMake( 191+ 400,182 , 20,400);
    } completion:^(BOOL finished) {

        [self move];
    }];
}




-(void)back{


    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//http://127.0.0.1:8080/canyin-frontdesk/member/chongzhi/create
-(void)VIPRechargeServerOrder
{

    NSString *url = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/chongzhi/create?mcId=%@&rechargeCash=%@&new_paymentType=%@&paidinCash=%@&new_memberIntegral=0&isDrawBill=0&isPrint=0",ceshiIP,self.zhifuchuandi.VIPforwardUrl,self.zhifuchuandi.count,self.zhifuchuandi.cptID,self.zhifuchuandi.count];
    
    NSLog(@"VIP create success last:%@",url);

    
    [HttpTool GET:url parameters:nil success:^(id responseObject) {
        
        NSLog(@"VIP response :%@",responseObject);
        
        NSString *statusCode = [responseObject objectForKeyedSubscript:@"statusCode"];
        if ([statusCode isEqualToString:@"200"]) {
            
            
            NSLog(@"会员创建成功");
            
            
            return ;
            //会员创建成功
        }
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"VIP error:%@",[error localizedDescription]);
    }];
    
//   
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.zhifuchuandi.count.integerValue],@"rechargeCash",self.zhifuchuandi.cptID,@"new_paymentType",[NSNumber numberWithInteger:self.zhifuchuandi.count.integerValue],@"paidinCash",self.zhifuchuandi.idIdentifyStr,@"cardNo",self.zhifuchuandi.VIPforwardUrl,@"mcId",@"0",@"isDrawBill",@"0",@"isPrint", nil];
    
//    [HttpTool POST:url parameters:dic success:^(id responseObject) {
//        NSLog(@"vip Recharge:%@",responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"vip recharge :%@",[error localizedDescription]);
//    }];
    
    
    
    
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
