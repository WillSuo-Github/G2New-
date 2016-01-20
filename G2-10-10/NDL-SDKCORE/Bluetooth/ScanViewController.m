//
//  ScanViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/11/22.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "ScanViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>


@property (strong,nonatomic)AVCaptureDevice * device;

@property (strong,nonatomic)AVCaptureDeviceInput * input;

@property (strong,nonatomic)AVCaptureMetadataOutput * output;

@property (strong,nonatomic)AVCaptureSession * session;

@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;


@property (strong,nonatomic) UIImageView *scanRectImageView;
@property (strong,nonatomic) UIImageView *scanLineImageView;
@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    //添加QRCode灰层
//    UIImageView *scanQRCode = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
//    scanQRCode.image = [UIImage imageNamed:@"ScanQRCodeFrame4"];
//    [self.view addSubview:scanQRCode];
    
    //[self.navigationController setNavigationBarHidden:NO animated:YES];
    

    self.view.frame = CGRectMake(0, 0, 540, 620);
    
    //self.view.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
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
    
    _preview.transform =  CATransform3DMakeRotation(-M_PI_2,0,0,1);
    
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    
    self.scanRectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    self.scanRectImageView.center = self.view.center;
    self.scanRectImageView.image = [UIImage imageNamed:@"HR_border"];
    [self.view addSubview:self.scanRectImageView];
    
    
    self.scanLineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -10, self.scanRectImageView.width, 10)];
    self.scanLineImageView.image = [UIImage imageNamed:@"HR_scan_line"];
    [self.scanRectImageView addSubview:self.scanLineImageView];
    
    self.showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.showLabel.textAlignment = NSTextAlignmentCenter;
    self.showLabel.text = self.showLabelStr;
    CGPoint point = CGPointMake(self.view.center.x, self.view.center.y+200);
    self.showLabel.center = point;
    [self.view addSubview:self.showLabel];
    
    [self moveScanLineImageView];
    
    
//    
//    self.scanLine = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width * 0.2f +25, _preview.bounds.size.height * 0.2f+25, self.view.bounds.size.width * 0.4, self.view.bounds.size.width * 0.4)];
//    
//    self.scanLine.image = [UIImage imageNamed:@"HR_scan_line"];
//    self.scanLine.transform = CGAffineTransformMakeRotation(-M_PI_2);
//    [self.view addSubview:self.scanRoundimage];
//    [self.view insertSubview:self.scanLine aboveSubview:self.scanRoundimage];
    
    [_session startRunning];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
     _preview.frame = self.view.layer.bounds;
     self.scanRectImageView.center = self.view.center;
    
    CGPoint point = CGPointMake(self.view.center.x, self.view.center.y+200);
    self.showLabel.center = point;
    //[self.view addSubview:self.showLabel];
}

-(void)moveScanLineImageView{
    
    [UIView animateWithDuration:2 animations:^{
        
        self.scanLineImageView.origin = CGPointMake(0, self.scanRectImageView.height-5);
        
    } completion:^(BOOL finished) {
        
        [self moveBackScanLineImageView];
    }];
}

-(void)moveBackScanLineImageView{
    
    [UIView animateWithDuration:2 animations:^{
        
        self.scanLineImageView.origin = CGPointMake(0, -10);
        
    } completion:^(BOOL finished) {
        
        [self moveScanLineImageView];
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
 
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_session stopRunning];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    


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

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0){
        
        //停止扫描
        
        [_session stopRunning];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        
        stringValue = metadataObject.stringValue;
        
        if (stringValue) {
           
            
            if ([self.delegate respondsToSelector:@selector(scanViewControllerdidFinishScan:result:)]) {
                [self.delegate scanViewControllerdidFinishScan:self result:stringValue];
            }
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
        
    }
    
    
}

@end
