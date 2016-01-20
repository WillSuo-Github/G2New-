//
//  JiLuViewController.m
//  GITestDemo
//
//  Created by WS on 15/10/9.
//  Copyright (c) 2015年 Kyson. All rights reserved.
//

#import "JiLuViewController.h"
#import "JiaoyijiluCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "G1AppDelegate.h"
#import "ConnectDeviceViewController.h"
#import "Common.h"
@interface JiLuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *snTableView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *stateArr;
@property (weak, nonatomic) IBOutlet UIButton *snBtn;

@property (nonatomic, strong) NSMutableArray *snArr;
@end

@implementation JiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.snTableView.delegate = self;
    self.snTableView.dataSource = self;
    self.snTableView.tableFooterView = [[UIView alloc] init];
    self.snTableView.hidden = YES;
    self.snTableView.tag = 0;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tag  = 1;
    self.tableView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
    [self showHUD:@"正在查询记录"];
//    self.navigationController.navigationItem.title = @"交易记录查询";
    self.navigationItem.title = @"交易记录查询";
    
//    if(MiniPosSDKDeviceState()<0){
//        //[self showTipView:@"设备未连接"];
//        
//        [self showConnectionAlert];
//        return;
//    }else{
    
    
//    }
    NSString *sn = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1SN];
    
    
    [self.snBtn setTitle:sn forState:UIControlStateNormal];
    
    NSString *phoneNo = [KUserDefault objectForKey:kLoginPhoneNo];
    NSDictionary *dict = [KUserDefault objectForKey:kkSN];
    NSArray *arr = [dict objectForKey:phoneNo];

    self.snArr = arr;
    
    [self setNavgation];
    
    if (sn.length == 0 && MiniPosSDKDeviceState()<0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请连接设备以查询交易记录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alert show];
        return;
    }
    
    [self requestJiaoyijiluWithSn:sn];
    
    
}


- (void)setNavgation{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    
    [btn addTarget:self  action:@selector(openOrCloseLeftView) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"连接设备" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(connectDevice) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}


- (void)openOrCloseLeftView{
    
    G1AppDelegate *tempAppDelegate = (G1AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
    
}

- (void)connectDevice{
    
    UIStoryboard *mainStory = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ConnectDeviceViewController *cdvc = [mainStory instantiateViewControllerWithIdentifier:@"CD"];
    [self.navigationController pushViewController:cdvc animated:YES];
}

- (IBAction)btnChick:(id)sender {
    
    self.snTableView.hidden = NO;
    [self.snTableView reloadData];
}

- (void)requestJiaoyijiluWithSn:(NSString *)sn{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSString *merchantNo  = [[NSUserDefaults standardUserDefaults] stringForKey:kMposG1MerchantNo];
    NSString *terminalNo  = [[NSUserDefaults standardUserDefaults]stringForKey:kMposG1TerminalNo];
    NSString *phoneNo = [[NSUserDefaults standardUserDefaults] stringForKey:kLoginPhoneNo];
    NSString *urlStr = [NSString stringWithFormat:@"http://%@:%@/MposApp/queryTrans.action?sn=%@&user=%@&mid=%@&tid=%@&flag=120001",kServerIP,kServerPort,sn,phoneNo,merchantNo,terminalNo];
    NSLog(@"%@__%@__%@__%@",sn,phoneNo,merchantNo,terminalNo);
    [mgr POST:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"resultMap"];
        NSString *code = [dict objectForKey:@"code"];
        _stateArr = [Jiaoyijilu objectArrayWithKeyValuesArray:[dict objectForKey:@"searchList"]];
        
        NSLog(@"%@",self.stateArr);
        [self.tableView reloadData];
        [self hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView的代理和数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return self.stateArr.count;
    }else{
        
        return self.snArr.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1) {
        static NSString *ID = @"cell";
        JiaoyijiluCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"JiaoyijiluCell" owner:nil options:nil];
            cell = [nibs lastObject];
        }
        Jiaoyijilu *jilu = self.stateArr[indexPath.row];
        cell.jilu = jilu;
        
        return cell;
    }else{
        
        static NSString *ID = @"snCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.snArr[indexPath.row];
        cell.height = 30;
        return cell;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
////    if (self.tableView.tag == 1) {
////        return 100;
////    }
//    if (self.tableView.tag == 0) {
//        return 30;
//        
//    }else{
//        return 100;
//    }
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1) {
        Jiaoyijilu *jilu = self.stateArr[0];
        if (indexPath.row == 0 && [jilu.txnId isEqualToString:@"200022"] && [jilu.tranStatus isEqualToString:@"1"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"撤销" message:@"是否进行撤销" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"撤销", nil];
            [alert show];
            
        }
        
    }else{
        
        [self.snBtn setTitle:self.snArr[indexPath.row] forState:UIControlStateNormal];

        [self requestJiaoyijiluWithSn:self.snArr[indexPath.row]];
    }
    self.snTableView.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.snTableView.hidden = YES;
}
#pragma mark - 懒加载
- (NSMutableArray *)snArr{
    
    if (_snArr == nil) {
        _snArr = [NSMutableArray array];
    }
    return _snArr;
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
