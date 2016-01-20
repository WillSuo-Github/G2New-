//
//  CardRecordController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "CardRecordController.h"
#import "CardRecordCell.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "RecordPG.h"

@interface CardRecordController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *recordArr;
@property (weak, nonatomic) IBOutlet UIButton *quxiao;
@property (weak, nonatomic) IBOutlet UIButton *queding;
@end

@implementation CardRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.chognzhijilu.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    self.quxiao.backgroundColor=[UIColor  colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.queding.backgroundColor=[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    
    [self.quxiao setTitleColor:[UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1 ] forState:UIControlStateNormal];
    [self.queding setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    self.quxiao.layer.cornerRadius=5;
    self.queding.layer.cornerRadius=5;

    
    
    // Do any additional setup after loading the view from its nib.
   // self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self requestRecordInfo];

}

- (void)requestRecordInfo{

    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/member/pop/opDetail/createForm/%@?cardOperationType=1&showType=0&returnJson=json",ceshiIP,self.mcid];

//    NSLog(@"----------%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"membershipCard"];
        NSArray *arr = [dict objectForKey:@"dinerBills"];
        self.recordArr = [RecordPG objectArrayWithKeyValuesArray:arr];
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
    
    return self.recordArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    CardRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CardRecordCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }

    
    if (self.recordArr.count>indexPath.row) {
        cell.recordPG=self.recordArr[indexPath.row];
        cell.userInteractionEnabled=YES;
    } else {
        cell.userInteractionEnabled=NO;
    }
    
//    
    RecordPG *record = self.recordArr[indexPath.row];
    cell.recordPG = record;
    return cell;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{


    if (indexPath.row%2==0) {
        cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    } else {
        
        cell.backgroundColor = [UIColor whiteColor];
    }

}
- (IBAction)quxaio:(id)sender {
        
}
- (IBAction)queding:(id)sender {
       
    
}

- (NSArray *)recordArr{
    
    if (_recordArr == nil) {
        _recordArr = [NSArray array];
    }
    return _recordArr;
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
