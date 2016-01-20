//
//  PromptSavingNoteViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptSavingNoteViewController.h"
#import "ZhiFuLeiXingUpDataGP.h"
#import "HttpTool.h"
#import "MJExtension.h"
@interface PromptSavingNoteViewController ()

@end

@implementation PromptSavingNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    ZhiFuLeiXingUpDataGP *zhifuleixing = [[ZhiFuLeiXingUpDataGP alloc] init];
    zhifuleixing.cptId = self.zhifuchuandi.cptID;
    zhifuleixing.billId = self.zhifuchuandi.billID;
    zhifuleixing.paymentType = self.zhifuchuandi.paymentType;
    zhifuleixing.money = self.zhifuchuandi.count;
    
    //NSLog(@"keyValues%@",zhifuleixing.keyValues);
    NSLog(@"self.zhifuchuandi.cptID :%@",self.zhifuchuandi.cptID );
    NSLog(@" self.zhifuchuandi.billID :%@", self.zhifuchuandi.billID);
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pop/paymentType/update",ceshiIP];
    [HttpTool POST:urlStr parameters:zhifuleixing.mj_keyValues success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pay/%@?isPrint=false&isForce=true&rid=0.23375838149835548",ceshiIP,self.zhifuchuandi.billID];
        
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject)
         {
             NSLog(@"s%@",responseObject);
             
             NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/index/qingtai/%@",ceshiIP,self.zhifuchuandi.tabID];
             [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
                 NSLog(@"s%@",responseObject);
                 
                 [self performSelector:@selector(back) withObject:nil afterDelay:5.0];
                 
             } failure:^(NSError *error) {
                 NSLog(@"%@",error);
             }];
             
             
         } failure:^(NSError *error) {
             NSLog(@"e%@",error);
         }];
        
        
        
    }failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    [[NSNotificationCenter defaultCenter] postNotificationName:kSwipingCardConsumeSuccess object:nil];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
