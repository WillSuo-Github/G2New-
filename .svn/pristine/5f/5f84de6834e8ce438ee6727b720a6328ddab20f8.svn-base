//
//  PromptPrintingNoteViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptPrintingNoteViewController.h"
#import "UIUtils.h"
#import "Anasis8583Pack.h"
@interface PromptPrintingNoteViewController ()

@end

@implementation PromptPrintingNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 60)];
    [cancelButton setImageEdgeInsets:UIEdgeInsetsMake(-30, -30, 0, 0)];
    [cancelButton setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:cancelButton];
}

//取消按钮action
-(void)cancelAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self printNote];
}


-(void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:@"打印成功"]) {
        [self performSegueWithIdentifier:@"next" sender:self];
    }
    
    
    self.statusStr  =@"";
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"The segue id is %@", segue.identifier );
    
    if ([segue.identifier isEqualToString:@"next"]) {
        
        UIViewController *destination = segue.destinationViewController;
        
        if ([destination respondsToSelector:@selector(setZhifuchuandi:)]) {
            [destination setValue:_zhifuchuandi forKey:@"zhifuchuandi"];
        }
        
    }
    
    
}

- (IBAction)printAgain:(UIButton *)sender {
    [self printNote];
}

-(void)printNote{
    
    //self.label.text = @"交易成功，正在打印签购单....";
    //self.imageView.image = [UIImage imageNamed:@"打印签购单"];
    
    
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
    
    
    
    
    //商户存根联
    MiniPosSDKPrinter(1,5,"",0);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"       银联签购单"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"  商户存根联       请妥善保管"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"--------------------"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"商户名称(MERCHANT NAME)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"蒸功夫"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"操作员号(OPERATOR)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"01"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"商户号编号(MERCHANT NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",mcCodeString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"终端编号(TERMINAL NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",terCodeString]],1);
    //MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"发卡行(ISSUER):             中国银行"]],1);
    //MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"收单行(ACQUIRER):           中国银联"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易类型(TRANS TYPE)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"消费(SALE)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"卡号(CARD NO.)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",cardStr]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"日期/时间(DATA/TIME)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",timeStr]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易参考号(REFER NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",reCodeString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"批次号(BATCH NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",gUserAreaString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"凭证号(VOUCHER NO.) "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",audCodeString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易金额(AMOUNT)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"RMB   %@",amountStr]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"----------------------------------"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"备注(REFERENCE)"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"持卡人签名(CARD HOLDER SIGNATURE)"]],1);
    
    MiniPosSDKPrinter(0x80,0x10,[UIUtils UTF8_To_GB2312:@"\x5/jmp.bmp"],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"本人确认以上交易,同意将其计入本卡账号"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"I  ACKNOWLEDGE  SATISFACTORY RECEIPT OF RELATIVE"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"GOODS/SEVICES"]],1);
    MiniPosSDKPrinter(2,75,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@" 商户存根 MERCHANT COPY"]],1);
    
    
    
    //持卡人存根联
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"       银联签购单"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@" 持卡人存根联       请妥善保管"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"----------------------------------"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"商户名称(MERCHANT NAME)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"蒸功夫"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"操作员号(OPERATOR)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"01"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"商户号编号(MERCHANT NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",mcCodeString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"终端编号(TERMINAL NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",terCodeString]],1);
    //MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"发卡行(ISSUER):             中国银行"]],1);
    //MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"收单行(ACQUIRER):           中国银联"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易类型(TRANS TYPE)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"消费(SALE)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"卡号(CARD NO.)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",cardStr]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"日期/时间(DATA/TIME)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",timeStr]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易参考号(REFER NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",reCodeString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"批次号(BATCH NO.)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",gUserAreaString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"凭证号(VOUCHER NO.) "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",audCodeString]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"交易金额(AMOUNT)"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"RMB   %@",amountStr]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"----------------------------------"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"备注(REFERENCE)"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"持卡人签名(CARD HOLDER SIGNATURE)"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:@" "],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:@"  "],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"本人确认以上交易,同意将其计入本卡账号"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"I  ACKNOWLEDGE  SATISFACTORY RECEIPT OF RELATIVE"]],1);
    MiniPosSDKPrinter(1,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"GOODS/SEVICES"]],1);
    MiniPosSDKPrinter(2,95,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"持卡人存根联 MERCHANT COPY"]],1);
    MiniPosSDKPrinter(3,15,NULL,2);
    
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
