//
//  JiaoYiJiLuViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "JiaoYiJiLuViewController.h"
#import "ZhiFuViewController.h"
#import "SaveOrderViewController.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "JiaoYiPG.h"
#import "JiaoYiJiLuCell.h"
#import "MJRefresh.h"
#import "OriginalContentView.h"
#import "MBProgressHUD.h"
#import "ZhiFuChuanDiPG.h"
#import "FSCalendar.h"
#import "NSDate+FSExtension.h"




@interface JiaoYiJiLuViewController ()<UITableViewDataSource,UITableViewDelegate,OriginalContentViewDelegate,FSCalendarDataSource,FSCalendarDelegate>{
    
    BOOL isHidden;
}
//日历
@property (weak, nonatomic) FSCalendar *calendar;
@property (strong,nonatomic) UIView * riliView;
@property (weak, nonatomic) IBOutlet UIButton *jintian;
@property (weak, nonatomic) IBOutlet UIButton *jinqitian;
@property (weak, nonatomic) IBOutlet UIButton *riliNoOne;
@property (weak, nonatomic) IBOutlet UIButton *riliNoTwo;
@property (weak, nonatomic) IBOutlet UITextField *riliOne;
@property (weak, nonatomic) IBOutlet UIView *bigView;

@property (weak, nonatomic) IBOutlet UITextField *riliTwo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITableView *jiluTableView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (assign,nonatomic) BOOL riqiXuanze;

@property (nonatomic, strong) UIViewController *tmpViewController;

@property (nonatomic, strong) NSMutableArray *jiluArr;

@property (nonatomic, assign) NSInteger pageCount;
@property (nonatomic, assign) NSString *allPage;
@property (nonatomic, copy) NSString *RiQiUrlStr;
@property (nonatomic, copy) NSString *statusUrlStr;

@property (nonatomic, strong) OriginalContentView *originalVc;

@property (nonatomic, strong) UIButton *coverView;

@property (nonatomic, strong) MBProgressHUD *hud;

@property(nonatomic,strong)UIView *maskScreen;
@property (nonatomic,strong) UIView *bigbigView;



- (IBAction)riqichaxun:(id)sender;

- (IBAction)riqixuanze1:(id)sender;

@end

@implementation JiaoYiJiLuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //王洪昌 
    self.riliOne.backgroundColor = [UIColor clearColor];
    self.riliTwo.backgroundColor = [UIColor clearColor];
    [self.riliOne resignFirstResponder];
    [self.riliTwo resignFirstResponder];
    [self.bigView bringSubviewToFront:self.riliNoOne];
    [self.bigView bringSubviewToFront:self.riliNoTwo];
    //
    self.riliOne.userInteractionEnabled = NO;
    self.riliTwo.userInteractionEnabled = NO;
    
    isHidden = YES;
    //WHC 创建日历
    [self riqijianli];
    
    //获取当前时间
    //获取当前时间
    //设置上方时间按钮的默认时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:now];
    int year = [dateComponent year];
    int month = [dateComponent month];
    int day = [dateComponent day];
    NSString *day1 = nil;
    if (day <10) {
        day1 = [NSString stringWithFormat:@"0%d",day];
    }else{
        day1  = [NSString stringWithFormat:@"%d",day];
    }
    NSString *date01111 = [NSString stringWithFormat:@"%d-%d-%@",year,month,day1];
   
    [self.riliNoOne setTitle:date01111 forState:UIControlStateNormal];
    [self.riliNoTwo setTitle:date01111 forState:UIControlStateNormal];
    [self.riliNoOne setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.riliNoTwo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tag = 1;
    
    self.jiluTableView.delegate = self;
    self.jiluTableView.dataSource = self;
    self.jiluTableView.tableFooterView = [[UIView alloc] init];
    self.jiluTableView.tag = 2;
    self.jiluTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.jiluTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    
    self.jintian.layer.cornerRadius = 15;
    self.jintian.layer.masksToBounds = YES;
    
    self.jinqitian.layer.cornerRadius = 15;
    self.jinqitian.layer.masksToBounds = YES;
    
    [self jintian:nil];
    
    [self setUpOriginalView];
    [self requestMore];
    
//    self.maskScreen = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 624, self.view.height)];
//    self.maskScreen.backgroundColor = [UIColor blackColor];
//    self.maskScreen.alpha = 0.4;
//    self.maskScreen.hidden = YES;
//    [self.view addSubview:self.maskScreen];


}


- (void)setUpOriginalView{
    
    UIButton *coverView = [[UIButton alloc] initWithFrame:self.view.bounds];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.1;
    [coverView addTarget:self action:@selector(coverViewChick) forControlEvents:UIControlEventTouchUpInside];
    coverView.hidden = YES;
    coverView.frame = CGRectMake(0, 0, kScreenWidth - koriginalWidth, self.view.height);
    _coverView = coverView;
    [self.view addSubview:coverView];
    

    
//    OriginalContentView *originalV = [[OriginalContentView alloc] initWithFrame:CGRectMake(kScreenWidth - koriginalWidth, 0, koriginalWidth, kScreenHeight - kBottomHeight)];
//    originalV.hidden = YES;
    
//    originalV.transform = CGAffineTransformMakeTranslation(kScreenWidth, 0);
//    originalV.frame = CGRectMake(kScreenWidth, 0, koriginalWidth, kScreenHeight - kBottomHeight);
    

}

- (void)showOriginalContentView{
    
    OriginalContentView *originalV = [[OriginalContentView alloc] init];
    originalV.frame = CGRectMake(kScreenWidth - koriginalWidth, 0, koriginalWidth, kScreenHeight);
    self.originalVc = originalV;
    self.coverView.hidden = YES;
    originalV.delegate = self;
    [self.view addSubview:originalV];
}
- (void)hideOriginalContentView{
    
    [self.originalVc removeFromSuperview];
}

- (void)coverViewChick{
    self.coverView.hidden = YES;
//    self.originalVc.hidden = YES;
    [self hideOriginalContentView];
    isHidden = YES;
//    [UIView animateWithDuration:0.3 animations:^{
////        self.originalVc.x = kScreenWidth;
////        self.originalVc.transform = CGAffineTransformMakeTranslation(koriginalWidth, 0);
////        self.originalVc.transform = CGAffineTransformIdentity;
//        
//        isHidden = YES;
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSIndexPath *index =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:index];

}

- (IBAction)jintian:(id)sender {
    
    [self showLoding];
    self.jinqitian.backgroundColor = [UIColor clearColor];
    [self.jinqitian setTitleColor:[UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    [self.jintian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jintian.backgroundColor = [UIColor colorWithRed:87/255.0 green:160/255.0 blue:243/255.0 alpha:1];
    [self.jiluArr removeAllObjects];
    [self.jiluTableView reloadData];
    
    
   
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/listBillsContent?returnJson=json&pageType=today",ceshiIP];
    self.RiQiUrlStr = urlStr;
    [self requestJiLuWithUrl:urlStr];
    
    NSIndexPath *index =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:index];
}

- (IBAction)jinqitian:(id)sender {
    
    
    [self showLoding];
    self.jinqitian.backgroundColor = [UIColor colorWithRed:87/255.0 green:160/255.0 blue:243/255.0 alpha:1];
    [self.jinqitian setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jintian.backgroundColor = [UIColor clearColor];
    [self.jintian setTitleColor:[UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    [self.jiluArr removeAllObjects];
    [self.jiluTableView reloadData];
    
    
    
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/listBillsContent?returnJson=json&pageType=7day",ceshiIP];
    self.RiQiUrlStr = urlStr;
    [self requestJiLuWithUrl:urlStr];
    
    NSIndexPath *index =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:index];
}
- (IBAction)firstData:(id)sender {
    
    
}
- (IBAction)lastData:(id)sender {
    
    
}



#pragma mark - tableView的数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return 6;
    }else if (tableView.tag == 2){
        
        return self.jiluArr.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 1) {
        static NSString *ID = @"MenuCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"全部";
                break;
            case 1:
                cell.textLabel.text = @"已下单";
                break;
            case 2:
                cell.textLabel.text = @"已结账";
                break;
                //王洪昌  扯淡没有做 2015 11 25
            case 3:
                cell.textLabel.text = @"撤单";
                break;
//            case 4:
//                cell.textLabel.text = @"已并台";
//                break;
            case 4:
                cell.textLabel.text = @"派送中";
                break;
            case 5:
                cell.textLabel.text = @"外卖单";
                break;
//            case 7:
//                cell.textLabel.text = @"外带";
//                break;
                
            default:
                break;
        }
        return cell;

    }else if (tableView.tag == 2){
        
        static NSString *ID = @"MenuCell";
        
        JiaoYiJiLuCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell1 == nil) {
            NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"JiaoYiJiLuCell" owner:nil options:nil];
            cell1 = [nibArr lastObject];
        }
        if (indexPath.row % 2) {
            cell1.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        }
        JiaoYiPG *jiaoyipg = self.jiluArr[indexPath.row];
        cell1.pg = jiaoyipg;
        
        return cell1;
    }
    
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
        
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    
    if (tableView.tag == 1) {
        if (indexPath.row == 0) {
            //全部
            NSString *urlStr = [NSString stringWithFormat:@"%@&billStatus=",self.RiQiUrlStr];
            
            NSLog(@"%@",urlStr);
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
            
            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
            cell.textLabel.highlightedTextColor=[UIColor whiteColor];

            self.statusUrlStr = urlStr;
            [self requestJiLuWithUrl:urlStr];
        }else if (indexPath.row == 1){
            /**
             *  已下单的url
             */
            NSString *urlStr = [NSString stringWithFormat:@"%@&billStatus=2",self.RiQiUrlStr];
            
            NSLog(@"%@",urlStr);
            self.statusUrlStr = urlStr;
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
            cell.textLabel.highlightedTextColor=[UIColor whiteColor];

            [self requestJiLuWithUrl:urlStr];
        }else if (indexPath.row == 2){
            /**
             * 已结账url
             */
            NSString *urlStr = [NSString stringWithFormat:@"%@&billStatus=3",self.RiQiUrlStr];
            NSLog(@"%@",urlStr);
            
            self.statusUrlStr = urlStr;
            [self requestJiLuWithUrl:urlStr];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
            cell.textLabel.highlightedTextColor=[UIColor whiteColor];
            
            [self requestJiLuWithUrl:urlStr];

        }else if (indexPath.row == 3){
            
//            /**
//             *  外卖单
//             */
//            NSString *urlStr = [NSString stringWithFormat:@"%@&billType=2",self.RiQiUrlStr];
//            self.statusUrlStr = urlStr;
//            [self requestJiLuWithUrl:urlStr];
//            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
//            cell.textLabel.highlightedTextColor=[UIColor whiteColor];
            

            //撤单没做  WHC 2015 11 25
            /**
             *  撤单url
             */
            NSString *urlStr = [NSString stringWithFormat:@"%@&billStatus=8",self.RiQiUrlStr];
            self.statusUrlStr = urlStr;
            [self requestJiLuWithUrl:urlStr];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
            cell.textLabel.highlightedTextColor=[UIColor whiteColor];
        }

//        }else if (indexPath.row == 4){
            /**
             *  已并台
             */
//            NSString *urlStr = [NSString stringWithFormat:@"%@&billStatus=10",self.RiQiUrlStr];
//            self.statusUrlStr = urlStr;
//            [self requestJiLuWithUrl:urlStr];
//            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
//            cell.textLabel.highlightedTextColor=[UIColor whiteColor];

    // }
    else if (indexPath.row == 4){
        // 派送未做
            /**
             *  派送中
             */
            NSString *urlStr = [NSString stringWithFormat:@"%@&billStatus=11",self.RiQiUrlStr];
            self.statusUrlStr = urlStr;
            [self requestJiLuWithUrl:urlStr];
            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
            cell.textLabel.highlightedTextColor=[UIColor whiteColor];

    }else if (indexPath.row == 5){
        /**
         *  外卖单     
         */
        NSString *urlStr = [NSString stringWithFormat:@"%@&billType=2",self.RiQiUrlStr];
        self.statusUrlStr = urlStr;
        [self requestJiLuWithUrl:urlStr];
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
        cell.textLabel.highlightedTextColor=[UIColor whiteColor];
        
    }
        }
//        else if (indexPath.row == 7){
//            /**
//             *  外带
//             */
//            NSString *urlStr = [NSString stringWithFormat:@"%@&billType=4",self.RiQiUrlStr];
//            self.statusUrlStr = urlStr;
//            [self requestJiLuWithUrl:urlStr];
//            cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//            cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
//            cell.textLabel.highlightedTextColor=[UIColor whiteColor];
//
//        }
//        
    
    else if (tableView.tag == 2)
    {
        
        if (isHidden) {
//            self.originalVc.hidden = NO;
            [self showOriginalContentView];
            JiaoYiPG *jiaoyiPg = self.jiluArr[indexPath.row];
            self.originalVc.jiaoyiPG = jiaoyiPg;
            self.coverView.hidden = NO;
            isHidden = NO;
//            [UIView animateWithDuration:0.3 animations:^{
////                self.originalVc.x = kScreenWidth - self.originalVc.width;
////                self.originalVc.transform = CGAffineTransformMakeTranslation(kScreenWidth - self.originalVc.width, 0);
//                self.originalVc.hidden = NO;
//                isHidden = NO;
//                self.coverView.hidden = NO;
//                self.maskScreen.hidden = NO;
//            }];
        }else{
//            self.originalVc.hidden = YES;
            [self hideOriginalContentView];
            self.coverView.hidden = YES;
            isHidden = YES;
//            [UIView animateWithDuration:0.3 animations:^{
////                self.originalVc.x = kScreenWidth + self.originalVc.width;
////                self.originalVc.transform = CGAffineTransformMakeTranslation(kScreenWidth + self.originalVc.width, 0);
////                self.originalVc.transform = CGAffineTransformIdentity;
//                self.originalVc.hidden = YES;
//                isHidden = YES;
//                self.maskScreen.hidden = YES;
//                self.coverView.hidden = YES;
//            }];
        }
    }
}



/**
 *  请求交易记录 信息
 *
 *  @param urlStr 默认是今天的信息
 */
- (void)requestJiLuWithUrl:(NSString *)urlStr{
    
    
    [self.jiluArr removeAllObjects];
    [self.jiluTableView reloadData];
    NSLog(@"transcation record List URL :%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        [self hideLoding];
//        NSLog(@"___%@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"dinerBillList"];
        self.allPage = [dict objectForKey:@"totalPages"];
        NSArray *arr = [dict objectForKey:@"content"];
        self.jiluArr = [JiaoYiPG objectArrayWithKeyValuesArray:arr];
        NSLog(@"transcation record List:%@",self.jiluArr.keyValues);
        [self.jiluTableView.header endRefreshing];
        [self.jiluTableView reloadData];
        _pageCount = 2;
    } failure:^(NSError *error) {
        [self hideLoding];
        NSLog(@"%@",error);
    }];
}

- (void)requestMore{
    //WHC 2015 11 23
//    if (self.pageCount == self.allPage.intValue + 1) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"别拖了" message:@"已经没有交易的记录了" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [self.jiluTableView.footer endRefreshing];
//        return;
//    }
//    NSLog(@"%@",self.tmpUrlStr);
    NSString *urlstr = [NSString stringWithFormat:@"%@&page=%d",self.statusUrlStr,self.pageCount + 1];
//    NSLog(@"%@",urlstr);
    [HttpTool GET:urlstr parameters:nil success:^(id responseObject) {
        NSDictionary *dict = [responseObject objectForKey:@"dinerBillList"];
        NSArray *arr = [dict objectForKey:@"content"];
        arr = [JiaoYiPG objectArrayWithKeyValuesArray:arr];
        [self.jiluArr addObjectsFromArray:arr];
        [self.jiluTableView reloadData];
        self.pageCount += 1;
        [self.jiluTableView.footer endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)SetUpContentViewWithViewController:(UIViewController *)controller{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _tmpViewController = controller;
    [self.contentView addSubview:controller.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OriginalContentView的代理方法
- (void)OriginalContentViewDidChickJieZhang:(OriginalContentView *)orderContent WithBillID:(NSString *)billID tableID:(NSString *)tableID count:(NSString *)count{
    
    ZhiFuViewController *zhifuVc = [[ZhiFuViewController alloc] init];
    ZhiFuChuanDiPG *chuandiPG = [[ZhiFuChuanDiPG alloc] init];
    
    chuandiPG.billID = billID;
    chuandiPG.whereFrom = @"正常消费";
    chuandiPG.tabID = tableID;
    chuandiPG.count = count;
    
    zhifuVc.chuandiPG = chuandiPG;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:zhifuVc];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    navController.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [kKeyWindow.rootViewController presentViewController:navController animated:YES completion:nil];
}


-(void)OriginalContentViewDidChickXiaDan:(OriginalContentView  *)orderContent
{
    
    SaveOrderViewController *saveOrderViewController = [[SaveOrderViewController alloc]init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:saveOrderViewController];
    navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    navController.modalPresentationStyle = UIModalPresentationPageSheet;
    
    [kKeyWindow.rootViewController presentViewController:navController animated:YES completion:nil];
    
    
    
    
    
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    NSLog(@"0000000000");
//}


#pragma mark - 弹出等待窗口
- (void)showLoding{
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = @"拼命加载中...";
    [self.hud show:YES];
}

- (void)hideLoding{
    
    [self.hud hide:YES];
}


- (NSMutableArray *)jiluArr{
    
    if (_jiluArr == nil) {
        _jiluArr = [NSMutableArray array];
    }
    return _jiluArr;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//WHC 日期查询日历
-(void)riqijianli{
    self.bigbigView = [[UIView alloc]init];
    self.bigbigView.frame = CGRectMake(0, 80, 1343,700-80 );
    self.bigbigView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bigbigView];
    self.riliView = [[UIView alloc]initWithFrame:CGRectMake(600, 80, 400, 320)];
    self.riliView.backgroundColor = [UIColor whiteColor];
    [self.bigbigView addSubview:self.riliView];
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, 400, 320)];
    calendar.dataSource = self;
    calendar.delegate = self;
    //获取当前时间
    NSDate *now = [NSDate date];
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:now];
    int year = [dateComponent year];
    int month = [dateComponent month];
    int day = [dateComponent day];
    //////////
    [calendar selectDate:[NSDate fs_dateWithYear:year month:month day:day]];
    [self.riliView addSubview:calendar];
    self.calendar = calendar;
    self.riliView.hidden = YES;
    self.bigbigView.hidden = YES;
}

- (IBAction)riqichaxun:(id)sender {
    //判断选择日期
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar1 = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar1 components:unitFlags fromDate:now];
    int year = [dateComponent year];
    int month = [dateComponent month];
    
    int day = [dateComponent day];
    NSString *day1 = nil;
    if (day <10) {
        day1 = [NSString stringWithFormat:@"0%d",day];
    }else{
        day1  = [NSString stringWithFormat:@"%d",day];
    }
    NSString *date01111 = [NSString stringWithFormat:@"%d%d%@",year,month,day1];
    int k =[[[self.riliNoOne.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue];
    int w = [[[self.riliNoTwo.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue];
    int h = [date01111 intValue];
    if ([[[self.riliNoOne.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue] > [[[self.riliNoTwo.titleLabel.text componentsSeparatedByString:@"-"] componentsJoinedByString:@""] intValue]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"时间选择不对" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if(w > h){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"时间选择不对" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
        
    }else{
    [self.jiluArr removeAllObjects];
    [self.jiluTableView reloadData];
    
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/listBillsContent?returnJson=json&pageType=&startDate=%@&endDate=%@",ceshiIP,self.riliNoOne.titleLabel.text,self.riliNoTwo.titleLabel.text];
    self.RiQiUrlStr = urlStr;
    [self requestJiLuWithUrl:urlStr];
    
    NSIndexPath *index =[NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:0];
    [self tableView:self.tableView didSelectRowAtIndexPath:index];

    }
    //
    
 
    
}

- (IBAction)riqixuanze1:(id)sender {
    self.riliNoOne.userInteractionEnabled = NO;
    self.riliNoTwo.userInteractionEnabled = NO;
    //日历View
    
    [self.bigbigView bringSubviewToFront:self.riliView];
    self.riliView.hidden = NO;
    self.bigbigView.hidden = NO;
    UIButton *btn = (UIButton *)sender;
    //    btn.userInteractionEnabled = NO;
    if (btn.tag == 520) {
        self.riqiXuanze = YES;
    }
    else
    {
        self.riqiXuanze = NO;
    }
}
#pragma mark FSCalender的代理
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    self.riliNoOne.userInteractionEnabled = YES;
    self.riliNoTwo.userInteractionEnabled = YES;
    self.riliView.hidden = YES;
    self.bigbigView.hidden = YES;
    if (self.riqiXuanze ) {
        [self.riliNoOne setTintColor:[UIColor grayColor]];
        
        [self.riliNoOne setTitle:[date fs_stringWithFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    } else {
        [self.riliNoTwo setTintColor:[UIColor grayColor]];
        [self.riliNoTwo setTitle:[date fs_stringWithFormat:@"yyyy-MM-dd"] forState:UIControlStateNormal];
    }
    
        NSLog(@"did select date %@",[date fs_stringWithFormat:@"yyyy-MM-dd"]);
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[calendar.currentPage fs_stringWithFormat:@"MMMM yyyy"]);
}

- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date
{
    return date.fs_day == 5;
}
//点击收回
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //王洪昌日历搜索
    self.riliNoOne.userInteractionEnabled = YES;
    self.riliNoTwo.userInteractionEnabled = YES;
    self.riliView.hidden = YES;
    self.bigbigView.hidden = YES;
}

@end
