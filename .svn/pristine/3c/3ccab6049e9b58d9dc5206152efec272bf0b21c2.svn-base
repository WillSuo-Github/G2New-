//
//  RechargeRecordViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "RechargeRecordViewController.h"
#import "RechargeRecordCell.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "rechargePg.h"

@interface RechargeRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *rechargeArr;
@property (weak, nonatomic) IBOutlet UIButton *quxiao;
@property (weak, nonatomic) IBOutlet UIButton *queding;

@end

@implementation RechargeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    
    self.quxiao.backgroundColor=[UIColor  colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.queding.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    
    [self.quxiao setTitleColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1 ] forState:UIControlStateNormal];
    [self.queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.quxiao.layer.cornerRadius=5;
    self.queding.layer.cornerRadius=5;

    
    // Do any additional setup after loading the view from its nib.
   // self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self requestRecordInfo];
}


- (void)requestRecordInfo{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/pop/opDetail/createForm/%@?cardOperationType=1&showType=0&returnJson=json",ceshiIP,self.mcid];
//    NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"membershipCardOperations"];
        NSArray *arr = [dict objectForKey:@"content"];
        self.rechargeArr = [rechargePg objectArrayWithKeyValuesArray:arr];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView的数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    RechargeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"RechargeRecordCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    
    if (self.rechargeArr.count > indexPath.row) {
        
        
       // RechargeRecordViewController*vips = self.rechargeArr[indexPath.row];
cell.rechargePG = self.rechargeArr[indexPath.row];
        cell.userInteractionEnabled=YES;
        
        
    }else{
        cell.userInteractionEnabled=NO;
        
    }

    
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0) {
        //cell.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    }
    else
    {
       cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    
}

- (NSArray *)rechargeArr{
    
    if (_rechargeArr == nil) {
        _rechargeArr = [NSArray array];
    }
    return _rechargeArr;
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
