//
//  ScanQRCodeViewController.m
//  G2TestDemo
//
//  Created by ws on 15/12/18.
//  Copyright © 2015年 ws. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ScanQRCodeViewController.h"
#import "TranscationSuccessViewController.h"
#import "NDLBusinessConfigure.h"


@interface ScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>
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
@end

@implementation ScanQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setScanQRCodeUIAutolayout];
    
    
}

-(void)setScanQRCodeUIAutolayout
{
    
    NSLog(@"into here");
    
    [super viewDidLoad];
  
    
    //添加QRCode灰层
    UIImageView *scanQRCode = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scanQRCode.image = [UIImage imageNamed:@"ScanQRCodeFrame4"];
    [self.view addSubview:scanQRCode];
    
    
    CGRect promptFrame = self.scanRoundimage.frame;
    promptFrame.origin.x = 30;
    promptFrame.origin.y+= 382;
    //promptFrame.origin.x;// += 30;
    promptFrame.size.height = 50;
    promptFrame.size.width = 300;
    
    UILabel *QRCodePromptLabel = [[UILabel alloc]initWithFrame:promptFrame];
    QRCodePromptLabel.text = @"将二维码放入框内，即可自动扫描";
    QRCodePromptLabel.textColor = [UIColor grayColor];
    QRCodePromptLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    //QRCodePromptLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.view insertSubview:QRCodePromptLabel aboveSubview:scanQRCode];

    // Do any additional setup after loading the view.
    
    
    //self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
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
    
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    
    _preview.videoGravity =AVLayerVideoGravityResizeAspectFill;
    
    _preview.frame =self.view.layer.bounds;
    
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    self.scanRoundimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f, _preview.bounds.size.height * 0.2f +25, self.view.bounds.size.width * 0.4, self.view.bounds.size.width * 0.4 )];
    self.scanRoundimage.image = [UIImage imageNamed:@"HR_border"];
    self.scanLine = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f +25, _preview.bounds.size.height * 0.2f+25, self.view.bounds.size.width * 0.4, self.view.bounds.size.width * 0.4)];
    
    self.scanLine.image = [UIImage imageNamed:@"HR_scan_line"];
    self.scanLine.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [self.view addSubview:self.scanRoundimage];
    [self.view insertSubview:self.scanLine aboveSubview:self.scanRoundimage];
    // NSLog(@"view%@",NSStringFromCGRect(self.view.frame));
    // NSLog(@"image%@",NSStringFromCGRect(self.scanRoundimage.frame));
    
    [self move];
    
    // Start
    
    [_session startRunning];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        
        //停止扫描
        
        //        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        stringValue = metadataObject.stringValue;
        
        //        NSLog(@"%@",stringValue);
        //        NSLog(@"%@",self.billID);
        
        if (stringValue)
        {
            
            [_session stopRunning];
            
            [self identifyRequestServer:stringValue];
            

                
            
        }
        
    }
    
    
}


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


-(void)leftButtonClick:(UIButton *)sender{
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(void)identifyRequestServer:(NSString *)QRCodeValueStr
{
    if ([self.transactionParameter.pay_type isEqualToString:@"支付宝支付"]) {
        NSLog(@"支付宝支付");

    }
    else if ([self.transactionParameter.pay_type isEqualToString:@"weixin_pay"])
    {
        NSLog(@"微信支付");
     
       NSMutableDictionary *dicParameter =[self getRequsetParameter:QRCodeValueStr];
        NSLog(@"dicParameter:%@",[dicParameter objectForKey:@"out_trade_no"]);
        NSLog(@"dicParameter:%@",[dicParameter objectForKey:@"total_amount"]);
        
      
        
        [self paymentTermsRequsetServer:dicParameter];
    }
    else if ([self.transactionParameter.pay_type isEqualToString:@"qq钱包"])
    {
        
        NSLog(@"qq钱包");
    }
    else if ([self.transactionParameter.pay_type isEqualToString:@"百度钱包"])
    {
        
        NSLog(@"百度钱包");
    }
    
    
}


-(void)paymentTermsRequsetServer:(NSMutableDictionary *)tmpDic
{
   

    
   // http://192.168.1.227:8080/third-party-payment/barPay.do
    
    NSString *requsetURL = [NSString stringWithFormat:@"%@/third-party-payment/barPay.do",ceshiIP];
    
    NSLog(@"requsetURL:%@",requsetURL);
    NSLog(@"dicParameter:%@",[tmpDic objectForKey:@"out_trade_no"]);
    NSLog(@"dicParameter:%@",[tmpDic objectForKey:@"total_amount"]);
    [HttpTool POST:requsetURL parameters:tmpDic success:^(id responseObject) {
        
        NSLog(@"weChatRequsetServer:%@",responseObject);
        NSString *isSuccess  = [responseObject objectForKey:@"code"];
        if ([isSuccess isEqualToString:@"SUCCESS" ]) {
            NSLog(@"SUCCESS");
            /**
             *  out_trade_no  商户唯一订单号
             auth_code 扫码枪扫描到的用户的付款条码
             total_amount 订单总金额（微信支付为分，支付宝支付为元）
             subject 商品或支付单简要描述
             pay_type支付方式（ali_pay：支付宝支付,qq_pay：qq钱包,weixin_pay：微信支付,baidu_pay：百度钱包）
             merchant_no 商户号（腾势管理的商户的id）
             appl_id 应用标识
             payee_phone 登录账号手机
             */
            
            TransactionParameter *transactionParameter = [[TransactionParameter alloc]init];
            transactionParameter.total_amount = [NSString stringWithFormat:@"%@",self.transactionParameter.total_amount];
            transactionParameter.out_trade_no = [NSString stringWithFormat:@"%@",self.transactionParameter.out_trade_no];;
            transactionParameter.merchant_no = [NSString stringWithFormat:@"%@",self.transactionParameter.merchant_no];;
            transactionParameter.subject = [NSString stringWithFormat:@"%@",self.transactionParameter.subject];;
            transactionParameter.payee_phone = [NSString stringWithFormat:@"%@",self.transactionParameter.payee_phone];;
            transactionParameter.pay_type = [NSString stringWithFormat:@"%@",self.transactionParameter.pay_type];;
            transactionParameter.appl_id = [NSString stringWithFormat:@"%@",self.transactionParameter.appl_id];;
            TranscationSuccessViewController *isSuccess = [[TranscationSuccessViewController alloc]init];
            isSuccess.transactionParameter = transactionParameter;
            isSuccess.isSuccess = YES;
            [self.navigationController pushViewController:isSuccess animated:YES];
        }
        else
        {
            TranscationSuccessViewController *isSuccess = [[TranscationSuccessViewController alloc]init];
            isSuccess.isSuccess = NO;
           [self.navigationController pushViewController:isSuccess animated:YES];
            
            
        }
        
        
        
        
    } failure:^(NSError *error) {
          NSLog(@"weChatRequsetServer  error:%@",error.localizedDescription);
    }];
    
}

-(NSMutableDictionary *) getRequsetParameter:(NSString *)qrCodeValueStr
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:10];
    if (self.transactionParameter.out_trade_no != nil) {
        [dic setObject:self.transactionParameter.out_trade_no forKey:@"out_trade_no"];
    }
    if (qrCodeValueStr != nil) {
        [dic setObject:qrCodeValueStr  forKey:@"auth_code"];
    }
    if (self.transactionParameter.total_amount != nil) {
        [dic setObject:self.transactionParameter.total_amount forKey:@"total_amount"];
    }
    if (self.transactionParameter.subject != nil) {
        [dic setObject:self.transactionParameter.subject forKey:@"subject"];
    }
    if (self.transactionParameter.pay_type != nil) {
        [dic setObject:self.transactionParameter.pay_type forKey:@"pay_type"];
    }
    if (self.transactionParameter.merchant_no != nil) {
        [dic setObject:self.transactionParameter.merchant_no forKey:@"merchant_no"];
    }
    if (self.transactionParameter.appl_id != nil) {
        [dic setObject:self.transactionParameter.appl_id forKey:@"appl_id"];
    }
    if (self.transactionParameter.payee_phone != nil) {
        [dic setObject:self.transactionParameter.payee_phone forKey:@"payee_phone"];
    }
    
    return dic ;
}




-(void)presentNextView:(BOOL)flag
{
    

    TranscationSuccessViewController *transcationSuccessViewController = [[TranscationSuccessViewController alloc]init];
    TransactionParameter *transactionParameter = [[TransactionParameter alloc]init];
    transactionParameter.total_amount = self.transactionParameter.total_amount;
    transactionParameter.subject = self.transactionParameter.subject;
    transactionParameter.pay_type = self.transactionParameter.pay_type;
    transactionParameter.merchant_no = self.transactionParameter.merchant_no;
    transactionParameter.appl_id = self.transactionParameter.appl_id;
    transcationSuccessViewController.transactionParameter  = transactionParameter;
    [self.navigationController pushViewController:transcationSuccessViewController animated:YES];
    
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
