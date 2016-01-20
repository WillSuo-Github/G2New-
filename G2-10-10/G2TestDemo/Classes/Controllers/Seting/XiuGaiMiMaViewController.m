//
//  XiuGaiMiMaViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "XiuGaiMiMaViewController.h"
#import "HttpTool.h"
#import "changMima.h"
#import "MJExtension.h"

@interface XiuGaiMiMaViewController (){
    
    NSString *empId;
}

@property (weak, nonatomic) IBOutlet UITextField *yuanshimima;
@property (weak, nonatomic) IBOutlet UITextField *xinmima;
@property (weak, nonatomic) IBOutlet UITextField *zaicishuru;


@property (weak, nonatomic) IBOutlet UIView *yuanshimimaView;
@property (weak, nonatomic) IBOutlet UIView *xinmimaView;
@property (weak, nonatomic) IBOutlet UIView *ziacishurumimaView;
@property (weak, nonatomic) IBOutlet UILabel *yuanshimima1;
@property (weak, nonatomic) IBOutlet UILabel *xinmima1;
@property (weak, nonatomic) IBOutlet UILabel *zaixishurumima1;
@property (weak, nonatomic) IBOutlet UIButton *quxiao1;
@property (weak, nonatomic) IBOutlet UIButton *queren1;
//修改颜色

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;


@end

@implementation XiuGaiMiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.queren1.selected=YES;
    
    //设置字体颜色、确认、取消圆角
    self.yuanshimima1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.xinmima1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.zaixishurumima1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.quxiao1.layer.cornerRadius=5;
    self.queren1.layer.cornerRadius=5;
    [self.quxiao1 setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
    self.yuanshimimaView.layer.borderColor=[UIColor colorWithRed:60/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    self.xinmimaView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    self.ziacishurumimaView.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
   
    
    self.label1.layer.borderWidth=1;
    self.label2.layer.borderWidth=1;
    self.label3.layer.borderWidth=1;
    self.label1.layer.borderColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1].CGColor;
    self.label2.layer.borderColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1].CGColor;
    self.label3.layer.borderColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1].CGColor;
    
    
    // Do any additional setup after loading the view from its nib.
    
    self.yuanshimimaView.layer.borderWidth = 1;
    self.yuanshimimaView.layer.cornerRadius = 5;
    self.yuanshimimaView.layer.masksToBounds = YES;
    
    self.xinmimaView.layer.borderWidth = 1;
    self.xinmimaView.layer.cornerRadius = 5;
    self.xinmimaView.layer.masksToBounds = YES;
    
    self.ziacishurumimaView.layer.borderWidth = 1;
    self.ziacishurumimaView.layer.cornerRadius = 5;
    self.ziacishurumimaView.layer.masksToBounds = YES;
    [self requestempId];
    
}

- (void)requestempId{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting?returnJson=json",ceshiIP];

    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {

        empId = [responseObject objectForKey:@"empId"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)queren:(id)sender {
    if (!self.yuanshimima.text.length) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"错误" message:@"原始密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];

        
    }else if(self.xinmima.text.length<6 ){
        
        if(!self.xinmima.text.length ){
            
            UIAlertView *alertView3=[[UIAlertView alloc]initWithTitle:@"错误" message:@"密码不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView3 show];
        }else{
            UIAlertView *alertView1=[[UIAlertView alloc]initWithTitle:@"错误" message:@"密码不能小于6位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView1 show];
        }
        
    }else if (![self.xinmima.text isEqualToString:self.zaicishuru.text]){
        
        UIAlertView *alertView2=[[UIAlertView alloc]initWithTitle:@"错误" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView2 show];
    }else
    {
        
        [self changeMima];
    }

   
}
- (IBAction)cancle:(id)sender {
    
    self.yuanshimima.text = @"";
    self.xinmima.text = @"";
    self.zaicishuru.text = @"";

}

- (void)changeMima{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/employe/ajax/psdUpdate",ceshiIP];
    changMima *mimapg = [[changMima alloc] init];
    mimapg.id = empId;
    mimapg.oldLoginPassword = self.yuanshimima.text;
    mimapg.loginPassword = self.xinmima.text;
    mimapg.confirmPassword = self.zaicishuru.text;
    [HttpTool POST:urlStr parameters:mimapg.keyValues success:^(id responseObject) {

        NSString *message = [responseObject objectForKey:@"message"];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        if ([message isEqualToString:@"修改成功"]) {
            self.yuanshimima.text= @"";
            self.xinmima.text = @"";
            self.zaicishuru.text = @"";
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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

@end
