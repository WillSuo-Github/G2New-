//
//  NewSwipingCardViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/11/23.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NewSwipingCardViewController.h"
#import "UIUtils.h"
#import "Anasis8583Pack.h"
@interface NewSwipingCardViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *label;


@end

@implementation NewSwipingCardViewController{
    int _nextStep;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //self.navigationController
    _nextStep = 1;
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [rightBtn setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    //[rightBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [leftBtn setImage:[UIImage imageNamed:@"hlk_fh"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIView *zhongjianView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    UIImageView *datubiaoImage = [[UIImageView alloc]initWithFrame:CGRectMake(-20, -10, 60, 43)];
    datubiaoImage.image = [UIImage imageNamed:@"yinlian"];
    UILabel *zhifuleixingLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 80, 50)];
    zhifuleixingLabel.text = @"银行卡支付";
    [zhifuleixingLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:21]];
    [zhifuleixingLabel sizeToFit];
    [zhongjianView addSubview:datubiaoImage];
    [zhongjianView addSubview:zhifuleixingLabel];
    self.navigationItem.titleView = zhongjianView;
    
    //self.navigationItem.leftBarButtonItem
    self.navigationItem.rightBarButtonItem  =  [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.leftBarButtonItem  =  [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.titleView = zhongjianView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
}


- (void)recvMiniPosSDKStatus
{
    if (!self.isViewLoaded) {
        return;
    }
    
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费成功"]]) {
        [self showTipView:self.statusStr];
        [self performSelector:@selector(printNote) withObject:nil afterDelay:0.2];
    }
    
    
    if ([self.statusStr isEqualToString:[NSString stringWithFormat:@"消费失败"]]) {
        [self showTipView:self.statusStr];

        if([self.delegate respondsToSelector:@selector(newSwipingCardViewControllerdidFinishConsume:statusInfo:)]){
            
            
            [self.delegate newSwipingCardViewControllerdidFinishConsume:self statusInfo:@"51 可用余额不足"];
        }
        
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
        
        
        
    }
    
    
    
    if ([self.statusStr isEqualToString:@"打印成功"]) {
        
        self.label.text =@"签购单打印成功，请您保留好存根";
        self.imageView.image = [UIImage imageNamed:@"打印成功"];
        
        [self performSelector:@selector(back) withObject:nil afterDelay:5.0];
        
    }
    
    if ([self.statusStr isEqualToString:@"消费下一步"]) {
     
        if (_nextStep == 1) {
            //收到确认,跳入提示输入密码阶段
            self.label.text =@"请提示顾客在键盘上输入银行卡密码";
            self.imageView.image = [UIImage imageNamed:@"输密提示"];
            
        }if (_nextStep ==2) {
            //完成密码输入,跳到提示用户签名阶段
            self.label.text =@"请提示顾客在客显屏幕签名";
            self.imageView.image = [UIImage imageNamed:@"提示顾客签名1"];
            [self.imageView sizeToFit];
        }
        
        _nextStep++;
        
    }
    
    
    
    //刷卡操作错误
    if([self.statusStr isEqualToString:@"刷卡操作错误"]){
        [self showAlertViewWithMessage:@"请将芯片卡插入卡槽！"];
          //[self showAlertViewWithMessage:@"卡片操作失败，请不要刷芯片卡"];
        
    }
    //取消刷卡交易
    if([self.statusStr isEqualToString:@"取消刷卡交易"]){
        
        [self performSelector:@selector(popAction) withObject:nil afterDelay:1.0];
    }
    
    
    if ([self.statusStr isEqualToString:@"设备响应超时"]) {
        [self showTipView:self.statusStr];
        [self performSelector:@selector(popAction) withObject:nil afterDelay:2.0];
    }
    
    if ([self.statusStr isEqualToString:@"收取图片成功"] ) {
        
        //[self showTipView:self.statusStr];
        //获取签名图片
        //UIImagePNGRepresentation
        UIImage *image = [UIImage imageWithData:[NSData dataWithBytes:imageData length:imageLen]];
        //UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        //self.label.text =@"用户签名图片获取成功";
        //self.imageView.image = image;
        
        
        [self performSelector:@selector(sendPacketToServer) withObject:nil afterDelay:0.2];
        
        return;

        
        
    }
    
    self.statusStr = @"";
}


- (void)showAlertViewWithMessage:(NSString *)str{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    
    [alert show];
}



-(void)sendPacketToServer{
    
    self.label.text =@"交易上送中...";
    self.imageView.image = [UIImage imageNamed:@"交易上送"];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)popAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)printNote{
    
    self.label.text = @"交易成功，正在打印签购单....";
    self.imageView.image = [UIImage imageNamed:@"打印签购单"];
    
    
    //商户号
    NSData *mcCodeData = [NSData dataWithBytes:(const void *)gMerchantCode length:sizeof( char)*15];
    NSString *mcCodeString = [[NSString alloc] initWithData:mcCodeData encoding:NSUTF8StringEncoding];
    
    //终端号
    NSData *terCodeData = [NSData dataWithBytes:(const void *)gTerminalCode length:sizeof( char)*8];
    NSString *terCodeString = [[NSString alloc] initWithData:terCodeData encoding:NSUTF8StringEncoding];
    
    //发卡行
    
    //收单行
    
    //交易类型
    
    //卡号
    char str[30];
    memset(str, 0x00, sizeof(str));
    
    for (int j = 0; j <= 20; j++) {
        NSLog(@"****** %.2x",gPriAccount[j]);
    }
    
    HexToStr((void *)gPriAccount, (void *)str, 20);
    for(int i = 0; i < 20; i++)
    {
        if(isdigit(str[i]) == 0)
        {
            str[i] = 0x00;
            break;
        }
        
        NSLog(@"act ---- %c  %d",str[i],i);
        
    }
    str[gPriAccountLen] = 0;
    memset(&str[6], '*', strlen(str) - 10);
    NSString *cardStr = @"";
    for (int t=1;t<=strlen(str);t++)
    {
        cardStr=[NSString stringWithFormat:@"%@%c",cardStr,str[t-1]];
    }
    
    
    //日期/时间
    int time = BCDToInt(gLocalTime, 3);
    int date = BCDToInt(gLocalDate, 2);
    
    NSDate *d = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *year = [dateFormatter stringFromDate:d];
    NSString *timeStr =[NSString stringWithFormat:@"%04d/%02d/%02d %02d:%02d:%02d",[year intValue],date/100,date%100,time/10000,(time%10000)/100,time%100];
    
    //有效期
    
    
    //交易参考号
    //gRetrieval[12]
    NSData *reCodeData = [NSData dataWithBytes:(const void *)gRetrieval length:sizeof( char)*12];
    NSString *reCodeString = [[NSString alloc] initWithData:reCodeData encoding:NSUTF8StringEncoding];
    
    //批次号
    int gUserArea = BCDToInt(gUserArea60+1, 3);
    NSString *gUserAreaString = [NSString stringWithFormat:@"%.6d",gUserArea];
    
    //凭证号
    int sysTraceAudit = BCDToInt(gSysTraceAudit, 3);
    NSString *audCodeString = [NSString stringWithFormat:@"%.6d",sysTraceAudit];
    
    //授权码
    
    
    //交易金额
    int transacAmount = BCDToInt(gTransacAmount, 6);
    NSString *amountStr = [NSString stringWithFormat:@"%d.%.2d",transacAmount/100,transacAmount%100];
    
    
//    
//    //顾客联
//    //商户号
//    
//    NSString *mcCodeString = @"1234567890123456";
//    
//    //终端号
//    
//    NSString *terCodeString = @"123456";
//    
//    //发卡行
//    
//    //收单行
//    
//    //交易类型
//    
//    //卡号
//    
//    NSString *cardStr = @"1256342186382163299";
//    
//    
//    
//    //日期/时间
//    NSString *timeStr =@"2015/11/24 16:44:44";
//    
//    //有效期
//    
//    
//    //交易参考号
//    //gRetrieval[12]
//    NSString *reCodeString = @"73648264737";
//    
//    //批次号
//    NSString *gUserAreaString = @"1347768";
//    
//    //凭证号
//    NSString *audCodeString = @"23323";
//    
//    //授权码
//    
//    
//    //交易金额
//    NSString *amountStr = @"44.00";
    
    
    
    MiniPosSDKPrinter(1,50,"",0);
    MiniPosSDKPrinter(3,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"       银联签购单"]],1);
    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"   商户存根联       请妥善保管"]],1);
    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"----------------------------------"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"商户名称(MERCHANT NAME):"]],1);
    MiniPosSDKPrinter(3,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"蒸功夫"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"操作员号(OPERATOR):     01"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"商户号编号(MERCHANT NO.):    %@",mcCodeString]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"终端编号(TERMINAL NO.):      %@",terCodeString]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"发卡行(ISSUER):             友池银行"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"收单行(ACQUIRER):           中国银联"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易类型(TRANS TYPE):"]],1);
    MiniPosSDKPrinter(3,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"消费(SALE)"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"卡号(CARD NO.):"]],1);
    MiniPosSDKPrinter(3,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",cardStr]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"日期/时间(DATA/TIME)      有效期(EXP DATE)"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@        2024/04",timeStr]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易参考号(REFER NO.)      批次号(BATCH NO.)"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@               %@",reCodeString,gUserAreaString]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"凭证号(VOUCHER NO.)      授权码(AUTH NO.)"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@                   *****",audCodeString]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易金额(AMOUNT):"]],1);
    MiniPosSDKPrinter(3,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"RMB   %@",amountStr]],1);
    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"----------------------------------"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"备注(REFERENCE):"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"持卡人签名(CARD HOLDER SIGNATURE)"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@"  "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@"  "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"本人确认以上交易,同意将其计入本卡账号"]],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@"  "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@"  "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(3,50,NULL,2);
    
}


////打印订单
//-(void)printOrderInfo:(NSMutableArray*)foodMenuArr{
//
//
//    MiniPosSDKPrinter(0,50,"",0);
//    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"       真功夫大兴店"]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"台号:%@            人数:%@",self.deskState.tabNo,self.deskState.peopleCount]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"单号:%@   收银员:01",self.deskState.billId]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"时间:%@",self.deskState.openTableTime]],1);
//    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
//    MiniPosSDKPrinter(1,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"菜肴名称      数量       单价      金额    "]],1);
//    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
//    double totals = 0;
//    for (CaiPG *caipg in foodMenuArr) {
//        
//        NSString *name = caipg.dishesName;
//        int num = caipg.unitNumStr.intValue;
//        double price = caipg.oriCostStr.doubleValue;
//        double total = num * price;
//        totals +=total;
//        
//        MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@        %d    %.2f  %.2f",name,num,price,total]],1);
//        
//    }
//    
//    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"      消费合计:%.2f元",totals]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"      优惠折扣:0元"]],1);
//    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"      应付金额:%.2f元",totals]],1);
//    MiniPosSDKPrinter(2,50,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"            欢迎再次光临真功夫大兴店           "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"            定餐电话:010-66669999           "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"            地址:北京市大兴区XX号           "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"            技术支持By腾势股份           "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
//    MiniPosSDKPrinter(0,30,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
//    
//    MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@""],2);
//    return;
//    //MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],2);
//    
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
