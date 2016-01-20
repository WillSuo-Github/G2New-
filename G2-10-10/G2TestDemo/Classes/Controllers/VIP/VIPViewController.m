//
//  VIPViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/4.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "VIPViewController.h"
#import "VipTableViewCell.h"
#import "DetailVipViewController.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "VipStates.h"
#import "VipCreatViewController.h"
#import "DXKeyboard.h"
#import "IQKeyboardManager.h"
#import "MJRefresh.h"
//后台蓝牙接收模型
#import "VipShow.h"



@interface VIPViewController ()<UITableViewDelegate,UITableViewDataSource,DXKeyboardDelegate,UITextFieldDelegate,sendShuaxin>


@property (weak, nonatomic) IBOutlet UIButton *delButton;


@property (weak, nonatomic) IBOutlet UIButton *VipCreat;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *VipStatusArr;

@property (weak, nonatomic) IBOutlet UITextField *sousuo;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (nonatomic, strong) VipCreatViewController *vipCreateVC;



@end

@implementation VIPViewController

- (void)viewDidLoad {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shuaxin) name:KshuaxinVIP object:nil];
    
    [self.tableView.header beginRefreshing];
    
//搜索框的颜色

    self.sousuo.layer.borderWidth=1;
    self.sousuo.layer.borderColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1].CGColor;
    self.label1.layer.borderWidth=1;
    self.label1.layer.borderColor=[UIColor colorWithRed:149/255.0 green:149/255.0 blue:149/255.0 alpha:1].CGColor;
    self.label2.layer.borderWidth=1;
    self.label2.layer.borderColor=[UIColor colorWithRed:197/255.0 green:198/255.0 blue:199/255.0 alpha:1].CGColor;
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.VipCreat.layer.cornerRadius = 15;
    self.VipCreat.layer.masksToBounds = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self requestVipStates];
   
    
    
    

    
}

- (void)viewWillAppear:(BOOL)animated{
    
         
    [super viewWillAppear:animated];
    [self.tableView.header beginRefreshing];
    [self shuaxin];
}
-(void)viewDidAppear:(BOOL)animated{


}
-(void)orderListReload:(NSNotification *)info
{
    NSLog(@"receive notification");
    [self.tableView.header beginRefreshing];
    
}



- (void)setSearchTextField{
    self.sousuo.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
//    [_ssField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // textField的文本发生变化时相应事件
//    设置ReturnKeyType为UIRetuirKeySearch ：
    [self.sousuo setReturnKeyType:UIReturnKeySearch];
    [self.sousuo setReturnKeyType:UIReturnKeySearch];
//    设置UITextField的delegate为self：
    
    self.sousuo.delegate=self;
}
////响应点击搜索按钮的响应事件的函数
//- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {
//    [theTextField resignFirstResponder];
//    NSLog(@"do something what you want");
//    return YES;
//}
//
////textField的文本内容发生变化时，处理事件函数
//- (void) textFieldDidChange:(UITextField*) TextField{
//    NSLog(@"textFieldDidChange textFieldDidChange");
//    if(![TextField.text isEqualToString:@""]) {
//        _delButton.hidden=NO;  // 仿制searchbar后面的小叉叉
//    } else{
//        _delButton.hidden=YES;
//    } 
//}


- (IBAction)vipCreat:(id)sender {
    
   self.vipCreateVC = [[VipCreatViewController alloc] init];
//    creatVc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    creatVc.modalPresentationStyle = UIModalPresentationPageSheet;
    UINavigationController *nagvigationVC = [[UINavigationController alloc]initWithRootViewController:self.vipCreateVC];
    nagvigationVC.modalPresentationStyle =  UIModalPresentationPageSheet;
    self.vipCreateVC.delegate = self;
   // self.navigationController.navigationBar.frame = CGRectMake(0,0,self.view.width,200);；
    //nagvigationVC.navigationBarHidden = YES;
    
    [self presentViewController:nagvigationVC animated:YES completion:nil];
    
}
-(void)sendShuaxin{
    [self shuaxin];
}
- (void)requestVipStates{
    
    //?returnJson=json&search_EQ_membershipCardClass.mcclassId=72e1288a-f54f-11e4-af9a-02004c4f4f50
    NSString *url = [NSString stringWithUTF8String:"/canyin-frontdesk/member/ajax/member/list?returnJson=json&cardStatus=&search_EQ_membershipCardClass.mcclassId=&pageSize=200"];
    url = [NSString stringWithFormat:@"%@%@",ceshiIP,url];
    
 // NSLog(@"------------------%@",url);
    [HttpTool POST:url parameters:nil success:^(id responseObject) {
       
    //   NSLog(@" request Vip state   response URL :%@",responseObject);
        
        NSDictionary *dict = [responseObject objectForKey:@"restMemberInfos"];
        NSArray *arr = [dict objectForKey:@"content"];
        
        //NSLog(@"content :%@",arr);

        self.VipStatusArr = [VipStates objectArrayWithKeyValuesArray:arr];
        
//        NSLog(@"------%@",self.VipStatusArr);
        
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
  
    return self.VipStatusArr.count;
//    if (self.VipStatusArr.count>8) {
//        return  self.VipStatusArr.count;
//    } else {
//        return ;
//    }
    
    //return self.VipStatusArr.count;
    //return self.VipStatusArr.count;
        //NSLog(@"================");
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    VipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"VipTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        
    }
//    if (indexPath.row % 2) {
//        cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
//    }
//    if (self.VipStatusArr.count > indexPath.row) {
//        
    
//    VipStates *vips = self.VipStatusArr[indexPath.row];
//    cell.vips = vips;
//    //NSLog(@"test :%@",cell.vips.shipCards.firstObject);
//        cell.userInteractionEnabled=YES;
//        
//    }else{
//        
//        cell.userInteractionEnabled=NO;
//    
//    }

    //会员倒序
  VipStates *vips = self.VipStatusArr[_VipStatusArr.count -  indexPath.row - 1];
    cell.vips = vips;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 == 0) {
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    }
    else
    {
        //cell.backgroundColor = [UIColor redColor];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    
}


/*
 
 @interface VipStates : NSObject
 
 @property (nonatomic, copy) NSString *name;
 @property (nonatomic, copy) NSString *mobile;
 
 @property (nonatomic, strong) NSArray *shipCards;
 
 @end
 
 
 ****************
 
 @interface CardStatus : NSObject
 
 @property (nonatomic, copy) NSString *mcId;
 
 @property (nonatomic, copy) NSString *cardStatus;
 @property (nonatomic, copy) NSString *cardNo;
 @property (nonatomic, copy) NSString *memberIntegral;
 @property (nonatomic, copy) NSString *balance;
 @property (nonatomic, copy) NSString *membershipCardClassName;
 @property (nonatomic, copy) NSString *cardIssueTime;
 @end

 
 
 
 */



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    VipStates *vips = self.VipStatusArr[ self.VipStatusArr.count - indexPath.row - 1];

    NSLog(@"vips:name: %@  mobile :%@ ",vips.name,vips.mobile);
    
    //信息存在
    CardStatus *cards = [CardStatus objectWithKeyValues:vips.shipCards[0]];
    
    NSLog(@"cardStatus :mcId %@,cardStatus %@, cardNo %@,memberIntegral %@,balance %@,membershipCardClassName %@,cardIssueTime %@ ",cards.mcId,cards.cardStatus,cards.cardNo,cards.memberIntegral,cards.balance,cards.membershipCardClassName,cards.cardIssueTime);
   
    
    DetailVipViewController *detailVc = [[DetailVipViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:detailVc];
    
    nav.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    nav.modalPresentationStyle = UIModalPresentationPageSheet;
    //蓝牙传递数据
    VipShow *vip1 = [[VipShow alloc]init];
    vip1.mobile = vips.mobile;
    vip1.balance = cards.balance;
    vip1.membershipCardClassName = cards.membershipCardClassName;
    vip1.cardNo = cards.cardNo;
    vip1.name = vips.name;
    //
    detailVc.mcid = cards.mcId;
    detailVc.shoujiNO = vips.mobile;
    detailVc.yue = cards.balance;
    detailVc.jifen = cards.memberIntegral;
    detailVc.vip = vip1;
    NSLog(@"vips.mobile:%@",vip1.mobile);
    NSLog(@"vip1.balance:%@",vip1.balance);
    NSLog(@"vip1.membershipCardClassName:%@",vip1.membershipCardClassName);
    NSLog(@"vip1.cardNo:%@",vip1.cardNo);
    NSLog(@"vip1.name:%@",vip1.name);
    
    [kKeyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (NSArray *)VipStatusArr{
    
    if (_VipStatusArr == nil) {
        _VipStatusArr = [NSArray array];
    }
    return _VipStatusArr;
}

-(void)huiYunaGuanLiQuXiao:(DetailVipViewController *)quxiao;
{
    [self.view removeFromSuperview];
}

-(void)shuaxin{
 
    
    [self  requestVipStates];
    [self.tableView  reloadData];

}
-(void)dealloc
{
[[NSNotificationCenter defaultCenter]removeObserver:self name:KshuaxinVIP object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sousuo:(id)sender {
    
    if (self.sousuo.text.length) {
//        NSLog(@"111%@",[NSString stringWithFormat:@"%@/canyin-frontdesk/member/ajax/member/list?kewWords=%@&returnJson=json",ceshiIP,self.sousuo.text]);
        NSDictionary *dic = @{@"kewWords":self.sousuo.text,@"returnJson":@"json"};
        NSLog(@"%@",dic);
        [HttpTool GET:[NSString stringWithFormat:@"%@/canyin-frontdesk/member/ajax/member/list",ceshiIP] parameters:dic success:^(id responseObject) {
            NSDictionary *sousuoDic = responseObject[@"restMemberInfos"];
            NSArray *sousuoArr = sousuoDic[@"content"];
            NSArray *sousuoArr1 = [VipStates objectArrayWithKeyValuesArray:sousuoArr];
            if (sousuoArr1.count) {
                
                self.VipStatusArr = [NSArray arrayWithArray:sousuoArr1];
                [self.tableView reloadData];
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有搜索结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                [alert show];
            
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else{
        [self requestVipStates];
    }
}
@end
