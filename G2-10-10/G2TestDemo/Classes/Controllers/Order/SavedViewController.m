//
//  SavedViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/26.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "SavedViewController.h"
#import "SaveOrderListCell.h"
#import "HttpTool.h"
#import "SaveListPG.h"
#import "MJExtension.h"
#import "CaiPG.h"
#import "MiniPosSDK.h"



@interface SavedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderArr;
@property (nonatomic, strong) NSMutableArray *unarchiverArr;

@property (nonatomic, strong) NSMutableArray *orderDetilArr;
@property (weak, nonatomic) IBOutlet UITextField *searchBarTextField;

@end

@implementation SavedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    //self.searchBarTextField.layer.borderWidth = 2;
    //self.searchBarTextField.layer.borderColor = [[UIColor colorWithRed:236/255.0 green:237/255.0 blue:241/255.0 alpha:0]CGColor];
   // self.searchBarTextField.layer.borderColor = [[UIColor clearColor]CGColor];
    //self.searchBarTextField.backgroundColor = [UIColor lightGrayColor];
    //self.searchBarTextField.alpha = 0.3;
   // self.searchBarTextField.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:241/255.0 alpha:0];
    //self.searchBarTextField.backgroundColor = [UIColor clearColor];
    
   // self.searchBarTextField.layer.cornerRadius = 5;
    self.searchBarTextField.borderStyle =  UITextBorderStyleNone;
    
    //self.searchBarTextField.layer.masksToBounds = YES;
    
    
//     self.orderArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:KSaveOrder]];
//
//    for (int i = 0; i < self.orderArr.count; ++i) {
//        NSMutableDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:self.orderArr[i]];
//        [self.unarchiverArr addObject:dict];
//    }
    
//    NSLog(@"%@",[self.unarchiverArr objectAtIndex:0]);
    [self requestInfo];
    
}
- (IBAction)queren:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)requestInfo{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/listBillsContent?returnJson=json&pageType=today&billStatus=",ceshiIP];
    NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"dinerBillList"];
        NSArray *arr = [dict objectForKey:@"content"];

        self.orderArr = [SaveListPG objectArrayWithKeyValuesArray:arr];
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (IBAction)cancle:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.orderArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    SaveOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"SaveOrderListCell" owner:nil options:nil];
        cell = [arr lastObject];
    }
    cell.saveList = self.orderArr[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SaveListPG *saveList = self.orderArr[indexPath.row];
    
    //当点击保存订单的时候删除和退出订单可以被点击通知
    [[NSNotificationCenter defaultCenter]postNotificationName:Kanniudianji object:nil];
    
    
    
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?returnJson=json&billId=%@&billType=1",ceshiIP,saveList.billId];

    NSLog(@"list :%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {

        NSDictionary *dict = [responseObject objectForKey:@"newBill"];
        
        NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
        NSString *tabID = [dict objectForKey:@"tableId"];
        
        self.orderDetilArr = [CaiPG objectArrayWithKeyValuesArray:arr];

        if ([_delegate respondsToSelector:@selector(SavedViewControllerDidChickTableView:WithOrderList:billId:tabID:)]) {
            [self.delegate SavedViewControllerDidChickTableView:self WithOrderList:self.orderDetilArr billId:saveList.billId tabID:tabID];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

//    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//
//        NSDictionary *dict = [responseObject objectForKey:@"newBill"];
//        
//        NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
//        NSString *tabID = [dict objectForKey:@"tableId"];
//        
//        self.orderDetilArr = [CaiPG objectArrayWithKeyValuesArray:arr];
//
//        if ([_delegate respondsToSelector:@selector(SavedViewControllerDidChickTableView:WithOrderList:billId:tabID:)]) {
//            [self.delegate SavedViewControllerDidChickTableView:self WithOrderList:self.orderDetilArr billId:saveList.billId tabID:tabID];
//        }
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];

    
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

- (NSMutableArray *)orderArr{
    
    if (_orderArr == nil) {
        _orderArr = [NSMutableArray array];
    }
    return _orderArr;
}

- (NSMutableArray *)unarchiverArr{
    
    if (_unarchiverArr == nil) {
        _unarchiverArr = [NSMutableArray array];
    }
    return _unarchiverArr;
}

- (NSMutableArray *)orderDetilArr{
    
    if (_orderDetilArr == nil) {
        _orderDetilArr = [NSMutableArray array];
    }
    return _orderDetilArr;
}

@end
