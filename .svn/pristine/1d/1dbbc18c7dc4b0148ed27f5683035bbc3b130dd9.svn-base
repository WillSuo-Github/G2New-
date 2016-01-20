//
//  JYJiaoYiJiLuViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/11.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYJiaoYiJiLuViewController.h"
#import "JYJiaoYiJiLuTableViewCell.h"
//退货
#import "JYTuiHuoViewController.h"
#import "JYMainViewController.h"
//交易记录
#import "JYOrderManager.h"
#import "JYOderListModel.h"
@interface JYJiaoYiJiLuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *JiaoYiJiLuTableView;
@property(strong,nonatomic)JYOderListModel *JYoderList;
@property(nonatomic,strong)NSMutableArray *moDelArr;
@property (weak, nonatomic) IBOutlet UIButton *JinTianButton;
@property (weak, nonatomic) IBOutlet UIButton *TuiHuoButton;
//实收金额
@property (nonatomic,strong) NSString *selectedShiShou;
//支付方式
@property(strong,nonatomic)NSString *selectedPayTypeName;
@end

@implementation JYJiaoYiJiLuViewController

- (void)viewDidLoad {
    
    
    self.JinTianButton.layer.cornerRadius=20;
    self.JinTianButton.backgroundColor=[UIColor colorWithRed:27/255.0 green:156/255.0 blue:253/255.0 alpha:1];
        self.TuiHuoButton.layer.cornerRadius=5;
    self.TuiHuoButton.backgroundColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    self.TuiHuoButton.userInteractionEnabled=NO;
    
    [super viewDidLoad];
    _moDelArr = [NSMutableArray array];
    [self seTUI];
    [self requestDataArr];
    
    // Do any additional setup after loading the view from its nib.
}
-(void)requestDataArr{
    JYOrderManager *manager = [[JYOrderManager alloc]init];
    [manager obtainOrderHeaderWith:nil block:^(id response, ErrorMessage *bsErrorMessage) {
        self.moDelArr = [NSMutableArray arrayWithArray:response];
        [self.JiaoYiJiLuTableView reloadData];
    }];
}

-(void)seTUI{
    self.JiaoYiJiLuTableView.delegate=self;
    self.JiaoYiJiLuTableView.dataSource=self;
    [self.JiaoYiJiLuTableView registerNib:[UINib nibWithNibName:@"JYJiaoYiJiLuTableViewCell" bundle:nil] forCellReuseIdentifier:@"wang"];
    
    
}

//退货button
- (IBAction)TuiHuoButton:(id)sender {
    
    //退货
    JYTuiHuoViewController *TH=[[JYTuiHuoViewController alloc]init];
    TH.consumption = self.selectedShiShou;
    TH.ArrPayTypeName=self.selectedPayTypeName;
    NSLog(@"%@",self.selectedPayTypeName);

    [[JYMainViewController sharedMainView]MainViewInsertSubviewWith:TH];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.moDelArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYJiaoYiJiLuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"wang"];
   
    JYOderListModel *mode= self.moDelArr[indexPath.row];
    cell.dingdanhao.text=mode.salesNo;//订单号
    cell.xiaofeishijian.text=mode.updateTime;//消费时间
    cell.huiyuanxingming.text=mode.customerName;//会员姓名
    cell.xiaofeijine.text=mode.paySum;//消费金额
    cell.zhekou.text=mode.discount;//折扣
    cell.shishoujine.text=mode.afterDiscount;//实收金额
    cell.zhifufangshi.text=mode.payTypeName;//支付方式
    cell.shouyinyuan.text=mode.seller;//收银员


    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.TuiHuoButton.userInteractionEnabled=YES;
    self.TuiHuoButton.backgroundColor=[UIColor colorWithRed:27/255.0 green:156/255.0 blue:253/255.0 alpha:1 ];
    JYJiaoYiJiLuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"wang"];
    
    JYOderListModel *mode= self.moDelArr[indexPath.row];
        cell.shishoujine.text=mode.afterDiscount;//消费金额
    cell.zhifufangshi.text=mode.payTypeName;//支付方式
    self.selectedShiShou = cell.shishoujine.text;
    self.selectedPayTypeName=cell.zhifufangshi.text;
    NSLog(@"%@",self.selectedPayTypeName);
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if (indexPath.row %2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:205/255.0 alpha:1];
    }
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
