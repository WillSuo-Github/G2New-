//
//  JYGouWuCheViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYGouWuCheViewController.h"
#import "JYGouWuCheXinXiTableViewCell.h"
#import "ZhiFuViewController.h"
#import "MiniPosSDK.h"
#import "JYPayToolType.h"
#import "JYMainViewController.h"
#import "JYThirdPayManager.h"

//LiuJQ
//#import "JYPayViewController.h"
//#import "JYGouWuCheXinXiTableViewCell.h"
@interface JYGouWuCheViewController ()<UITableViewDataSource,UITableViewDelegate,sendChuandiDleegate>
@property (weak, nonatomic) IBOutlet UIView *topview;
@property (weak, nonatomic) IBOutlet UIButton *jiezhang;
@property (weak, nonatomic) IBOutlet UIButton *dayin;
@property (weak, nonatomic) IBOutlet UILabel *ZongJiRMB;
//购物车view
@property (weak, nonatomic) IBOutlet UITableView *GouWuCheTableView;
@property(strong,nonatomic)JYPayToolType *pay;
@property (weak, nonatomic) IBOutlet UILabel *GouWuCheLabel;


@end

@implementation JYGouWuCheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dayin.layer.cornerRadius=5;
    self.dayin.backgroundColor=[UIColor colorWithRed:27/255.0 green:156/255.0 blue:253/255.0 alpha:1];
    self.jiezhang.layer.cornerRadius=5;
    self.jiezhang.backgroundColor=[UIColor colorWithRed:27/255.0 green:156/255.0 blue:253/255.0 alpha:1];
    self.topview.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    self.GouWuCheLabel.textColor=[UIColor colorWithRed:83/255.0 green:87/255.0 blue:106/255.0 alpha:1];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(btn:) name:@"OrDerNoti" object:nil];;
    // Do any additional setup after loading the view from its nib.
    //设置UI以及 复用cell WHC
    [self sTtView];
}
-(void)btn :(NSNotification *)sender{
    NSLog(@"%@",sender);
}

-(void)sTtView{
    //WHC 注册cell
    [self.JYShoppingtableView registerNib:[UINib nibWithNibName:@"JYGouWuCheXinXiTableViewCell" bundle:nil] forCellReuseIdentifier:@"wang"];
    //WHC
    self.JYShoppingtableView.rowHeight = 80;
    self.JYShoppingtableView.tableFooterView = [[UIView alloc]init];
    
    
    
}
//打印
- (IBAction)DaYin:(id)sender {
    
}
//结算
- (IBAction)JieSuan:(id)sender {
    
    ZhiFuViewController *zhifuVc = [[ZhiFuViewController alloc] init];
    zhifuVc.dataManager = [[JYThirdPayManager  alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:zhifuVc];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    navController.modalPresentationStyle = UIModalPresentationPageSheet;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navController animated:YES completion:nil];// navController;
    //[[JYMainViewController sharedMainView]MainViewInsertSubviewWith:navController];
    
    //LiuJQ
    //JYPayViewController *pay=[[JYPayViewController alloc]init];
    //UINavigationController *navController= [[UINavigationController alloc] initWithRootViewController:pay];
    //[[JYMainViewController sharedMainView]MainViewInsertSubviewWith:navController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    // 测试 WHC
//    return 7;
    //正式 WHC
    return self.productArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"wang";
    JYGouWuCheXinXiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;

}

-(void)sendChuanDi:(JYPayToolType *)zhifuW{

    self.pay=zhifuW;
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
