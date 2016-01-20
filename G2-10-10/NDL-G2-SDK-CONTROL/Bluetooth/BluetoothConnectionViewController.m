 //
//  BluetoothConnectionViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/11/20.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "BluetoothConnectionViewController.h"
#import "LoginViewController.h"
#import "AFNetworking.h"
#import "ScanViewController.h"
#import "UIUtils.h"
#import "CustomAlertView.h"
#import "PromptUploadingTradeViewController.h"
#import "AppDelegate.h"
#import "Common.h"
#import "NDLBusinessConfigure.h"

//结构调整，链接时需要指定其为外部变量，即全局变量 LiuJQ
extern NSMutableArray *searchDevices;

@interface BluetoothConnectionViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *connectedDevice; //连接设备名称
@property (strong, nonatomic) IBOutlet UIImageView *connecetedDeviceImage;

@property  char *connectionType ; //连接类型  00 手动，01扫描

@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (strong,nonatomic) CBPeripheral *device;
@end

@implementation BluetoothConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.connectionType = "\x00";
    
    [KUserDefault setObject:@"13202264038" forKey:kLoginPhoneNo];
    [KUserDefault setObject:@"123456" forKey:KPassword];
    [KUserDefault synchronize];
    
    //设置是否签过到
    [[NSUserDefaults standardUserDefaults]setBool:false forKey:kHasSignedIn];
    //[[BleManager sharedManager] startScan];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"isNeedAutoConnect"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didDiscoverDevice) name:kDidDiscoverDevice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectingDevice:) name:kConnectingDevice object:nil];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kDidDiscoverDevice object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kConnectingDevice object:nil];
    [self.presentingViewController viewWillAppear:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

// UITableViewDataSource<NSObject>

-(void)connectingDevice:(NSNotification *)noti{
    //aper.object
    self.device = noti.object;

    self.connectedDevice.text = self.device.name;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return searchDevices.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identify = @"myCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, cell.contentView.frame.size.width-50, 40)];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.tag = 100;
        [cell.contentView addSubview:label];
        
        UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width+170, 5, 30, 30)];
        imageView1.image=[UIImage imageNamed:@"c"];
        [cell.contentView addSubview:imageView1];
    }
    
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:100];
    
    self.device = [searchDevices objectAtIndex:indexPath.row];
    
    label.text = self.device.name;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.isSelected) {
        
        self.indicatorView =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        
        [self.indicatorView setCenter:CGPointMake(25, 20)];
        [self.indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [cell.contentView addSubview:self.indicatorView];
        [self.indicatorView startAnimating];
        
        
        [[BleManager sharedManager].imBT connect:[searchDevices objectAtIndex:indexPath.row]];
        
        CBPeripheral *aper = [searchDevices objectAtIndex:indexPath.row];
        self.connectedDevice.text = aper.name;
        
    }else{
        [self.indicatorView stopAnimating];
    }
    
}

-(void)didDiscoverDevice{
    [_tableView reloadData];
    
}

- (IBAction)done:(UIButton *)sender {
    
    //[self bindNewDevice];
    
    NSString *str0 = @"0:88888888,金牌会员卡,李小龙,13202264044,200"; //会员页面创建
    NSString *str1 = @"1:李小龙,13922223333,12,11-24";  //预定页面创建
    NSString *str2 = @"2:支付宝支付引导"; //支付宝引导
    NSString *str3 = @"3:微信支付引导"; //微信支付引导
    
//    char *data = [UIUtils UTF8_To_GB2312:str];
//    int datalen =  strlen(data);
//    
//    for (int i=0; i<datalen; i++) {
//        printf("%.2x",data[i]);
//        if (i%2 !=0) {
//            printf(" ");
//        }
//    }
//    printf("\n");
    //01 电压  ，03打印机
    //MiniPosSDKGetG2DeviceInfo("\x01");
    //MiniPosSDKCreateWindow([UIUtils UTF8_To_GB2312:str0]);
    //MiniPosSDKCreateWindow("s");
    

    
    //return;
    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents/44"]];
    UIImage *image = [UIImage imageNamed:@"提示顾客确认卡号"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
    
    
    NSLog(@"imageData:length:%d",imageData.length);
    
    [imageData writeToFile:str atomically:YES];
    
    CustomAlertView *cav = [[CustomAlertView alloc]init];
    [cav show];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        TransferFilesToPos((__bridge void*)cav,@[@"44"]);
        
        [ [ UIApplication sharedApplication] setIdleTimerDisabled:NO ] ;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cav dismiss];
        });
        
    });
}

- (IBAction)scan:(UIButton *)sender {


    ScanViewController *svc = [[ScanViewController alloc]init];
    svc.delegate = self;
    svc.showLabelStr = @"请将摄像头对准客显屏";
    [self.navigationController pushViewController:svc animated:YES];

}



-(void)scanViewControllerdidFinishScan :(ScanViewController *)vc result:(NSString*)str{
    
    
    
    for (CBPeripheral *p in searchDevices) {
        if ([p.name isEqualToString:str]) {
            
            self.connectionType = "\x01";
            self.connectedDevice.text = p.name;
            
            [[BleManager sharedManager].imBT connect:p];
            
        }
    }
    
    
}

- (IBAction)back:(UIButton *)sender {
    
    //[self showAlertViewWithMessage:@"hhh"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要退出\"互联客\"" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:@"取消", nil];
    
    alert.tag = 1;
    [alert show];
}

- (void)exitApplication {
    
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        window.alpha = 0;
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
    } completion:^(BOOL finished) {
        exit(0);
    }];
   
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
//    if (alertView.tag ==1) {
//        if (buttonIndex == 1) {
//            
//            [self dismissViewControllerAnimated:YES completion:nil];
//            
//            //LoginViewController *loginVc = [[LoginViewController alloc] init];
//            
//            //kKeyWindow.rootViewController = loginVc;
//            //[kKeyWindow makeKeyAndVisible];
//        }
//    }
    
    switch (alertView.tag) {
        case 1: //放回弹框
            if (buttonIndex == 0) {
                
                //[self dismissViewControllerAnimated:YES completion:nil];
                
                [self exitApplication];
                
            }
            break;
        case 2: //开门营业
            if (buttonIndex == 0) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            
            }
            break;
        default:
            break;
    }
}



-(void)showConnecetedDeviceStatus:(BOOL)status{
    
    self.connectedDevice.hidden = !status;
    self.connecetedDeviceImage.hidden = !status;
//    if (status) {
//         [self.indicatorView startAnimating];
//    }else{
//        [self.indicatorView stopAnimating];
//    }
   

}

-(void)recvMiniPosSDKStatus{
    
    [super recvMiniPosSDKStatus];
    
    
    if ([self.statusStr isEqualToString:@"设备已插入"]) {
        
   
         [self showConnecetedDeviceStatus:YES];
        
         [self showHUD:@"请从客显屏确认本次配对"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            MiniPosSDKBLEMatch(self.connectionType);
        });
        
    }

    
    if ([self.statusStr isEqualToString:@"蓝牙配对成功"]) {
        [self hideHUD];
        [self showTipView:self.statusStr];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            [self getPosParams];
            
            
            //self
//            self.isFirstGetVersionInfo = YES;
//            if (self.isFirstGetVersionInfo) {
//                
//                if (MiniPosSDKDeviceState() >=0) {
//                    MiniPosSDKGetDeviceInfoCMD();
//                }
//                
//                
//            }
            
        });
    }
    
    
    if ([self.statusStr isEqualToString:@"获取参数成功"]) {
        
        NSString *SnNo = [NSString stringWithCString:MiniPosSDKGetParam("SnNo") encoding:NSUTF8StringEncoding];
        NSString *TerminalNo = [NSString stringWithCString:MiniPosSDKGetParam("TerminalNo") encoding:NSUTF8StringEncoding];
        NSString *MerchantNo = [NSString stringWithCString:MiniPosSDKGetParam("MerchantNo") encoding:NSUTF8StringEncoding];
        
        if(TerminalNo==nil || [TerminalNo isEqualToString:@"00000000"]){
            [[NSUserDefaults standardUserDefaults] setBool:true forKey:kMposG2IsNewDevice];
        }else{
            [[NSUserDefaults standardUserDefaults] setBool:false forKey:kMposG2IsNewDevice];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:SnNo forKey:kMposG1SN];
        [[NSUserDefaults standardUserDefaults] setObject:TerminalNo forKey:kMposG1TerminalNo];
        [[NSUserDefaults standardUserDefaults] setObject:MerchantNo forKey:kMposG1MerchantNo];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"SnNo:%@,TerminalNo:%@,MerchantNo:%@",[[NSUserDefaults standardUserDefaults]stringForKey:kMposG1SN],[[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo],[[NSUserDefaults standardUserDefaults]stringForKey:kMposG1MerchantNo]);
        
        [self hideHUD];
        [self showTipView:@"连接成功"];
        [self.indicatorView stopAnimating];
        
        
        BOOL isNewDevice = [[NSUserDefaults standardUserDefaults]boolForKey:kMposG2IsNewDevice];
        
        
        if(!isNewDevice){
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                if(MiniPosSDKPosLogin()>=0)
                {
                    
                    [self showTipView:@"正在签到"];
                    
                    
                }
                
            });
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
    }
    
    if ([self.statusStr isEqualToString:@"蓝牙配对失败"]) {
        [self hideHUD];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kLastConnectedDevice];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self showConnecetedDeviceStatus:NO];
        [self showTipView:self.statusStr];
        [[BleManager sharedManager].imBT disconnectPeripheral:self.device];
        [self.indicatorView stopAnimating];
    }
    
    if([self.statusStr isEqualToString:@"蓝牙配对超时"]){
        [self hideHUD];
        [self showTipView:self.statusStr];
        [[BleManager sharedManager].imBT disconnectPeripheral:self.device];
        [self.indicatorView stopAnimating];
    }
    
    //获取G2信息成功
    if([self.statusStr isEqualToString:@"获取G2信息成功"]){
    
        int result = MiniPosSDKGetG2BatteryPower();
        MiniPosSDKGetG2PrinterStatus();
        
        NSLog(@"result:%d",result);
        
    }
    
    

    
    self.statusStr =@"";
}

- (void)showAlertViewWithMessage:(NSString *)str{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];

    [alert show];
}


//获取设备的参数
-(void)getPosParams{
    
    NSLog(@"didConnectDevice");
    
    char paramname[100];
    
    memset(paramname, 0x00, sizeof(paramname));
    strcat(paramname, "TerminalNo");
    strcat(paramname, "\x1C");
    strcat(paramname, "MerchantNo");
    strcat(paramname, "\x1C");
    strcat(paramname, "SnNo");
    
    MiniPosSDKGetParams("88888888", paramname);
}


//验证绑定关系
-(void)verifyDevice{
    
    //[[NSUserDefaults standardUserDefaults] setObject:@"222" forKey:kMposG1TerminalNo];
    

    
    [self verifyParamsSuccess:^{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"更新成功，准备开门营业" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        
        alert.tag = 2;
        
        [alert show];
        
    }];
    
}


- (void)bindNewDevice{
    
    NSString *sn = [KUserDefault objectForKey:kMposG1SN];
    NSString *loginPhone = [KUserDefault objectForKey:kLoginPhoneNo];
    NSString *mima = [KUserDefault objectForKey:KPassword];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:%@/MposApp/bindMpos.action?sn=%@&user=%@&passwd=%@&flag=0800464",kServerIP,kServerPort,sn,loginPhone,mima];
    NSLog(@"urlStr:%@",urlStr);
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"resultMap"];
        
        
        if ([dict[@"code"]intValue] == 7) {
            
            [self showHUD:@"正在写入参数"];
            
            NSString *mainKey  = [self decryptMainKey:dict[@"tmk"]];
            NSString *tid = dict[@"tid"];
            NSString *mid = dict[@"mid"];
            NSLog(@"mainKey:%@",mainKey);
            
            NSDictionary *dictionary = @{@"商户号":mid,@"终端号":tid,@"主密钥1":mainKey};
            
            [self setPosWithParams:dictionary success:^{
                //                if(MiniPosSDKPosLogin()>=0)
                //                {
                //                    [self showHUD:@"正在签到"];
                //                }
                
                [[NSUserDefaults standardUserDefaults] setBool:false forKey:kHasSignedIn];
                
                [[NSUserDefaults standardUserDefaults]setObject:mid forKey:kMposG1MerchantNo];
                [[NSUserDefaults standardUserDefaults]setObject:tid forKey:kMposG1TerminalNo];
                [[NSUserDefaults standardUserDefaults]setObject:mainKey forKey:kMposG1MainKey];
                [[NSUserDefaults standardUserDefaults]synchronize];
                
                [self showAlertViewWithMessage:@"绑定设备成功"];
            }];
            
            
            
        }else{
            
            //[self showTipView:[dict objectForKey:@"msg"]];
            
            if([[dict objectForKey:@"msg"] isEqualToString:@"新设备绑定失败，该MPOS机身码已提交注册或已绑定商户"]){
                [self showAlertViewWithMessage:@"新设备绑定失败，该MPOS已绑定其他商户，请重新选择"];
            }else{
                [self showAlertViewWithMessage:[dict objectForKey:@"msg"]];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //        [self showTipView:@"绑定新设备失败"];
        [self showAlertViewWithMessage:@"绑定新设备失败"];
    }];
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
