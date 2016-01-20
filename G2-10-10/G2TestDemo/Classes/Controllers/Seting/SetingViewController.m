//
//  SetingViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "SetingViewController.h"
#import "YuDingViewController.h"
#import "PrintViewController.h"
#import "CaoZuoViewController.h"
#import "XiuGaiMiMaViewController.h"
#import "HttpTool.h"
Boolean dianji;


@interface SetingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) UIViewController *tmpViewController;
@property (weak, nonatomic) IBOutlet UILabel *label;


@property (nonatomic, strong) IQKeyboardReturnKeyHandler  *returnKeyHandler;
@property (weak, nonatomic) IBOutlet UILabel *shezhi;

@property (nonatomic, strong)UITableViewCell *selectCell;
@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    
    
    //设置 label设置字体颜色
    self.label.textColor=[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1];
    self.shezhi.textColor=[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1];
    // Do any additional setup after loading the view from its nib.
    /**
     *  自动键盘
     */
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    
    self.tableView.scrollEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.tableFooterView  =[[UIView alloc] init];
 
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:nil didSelectRowAtIndexPath:index];
    [self.tableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self requestSetingInfo];
}


- (void)requestSetingInfo{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting?returnJson=json",ceshiIP];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {

        NSDictionary *dict = [responseObject objectForKey:@"cashierDeskSetting"];
        //开台后
        NSString *isStartEnterOrder = [dict objectForKey:@"isStartEnterOrder"];
        //预定后
        NSString *isOrderEnterDesk = [dict objectForKey:@"isOrderEnterDesk"];
        //下单确认后
        NSString *isShowPlaceBillConfirmWindow = [dict objectForKey:@"isShowPlaceBillConfirmWindow"];
        //下单后
        NSString *billPlaceEnterDeskOrPay = [dict objectForKey:@"billPlaceEnterDeskOrPay"];
        
        //锁屏时间
        NSString *leaveTime = [dict objectForKey:@"leaveTime"];


        //操作设置
        if ((NSNull *)isStartEnterOrder != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:isStartEnterOrder forKey:KKAITAIHOUINDEX];
        }
        if ((NSNull *)isOrderEnterDesk != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:isOrderEnterDesk forKey:KYUDINGHOUINDEX];
        }
        if ((NSNull *)isShowPlaceBillConfirmWindow != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:isShowPlaceBillConfirmWindow forKey:KXIANDANQUERENINDEX];
        }
        if ((NSNull *)billPlaceEnterDeskOrPay != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:billPlaceEnterDeskOrPay forKey:KXIADANHOUINDEX];
        }
        if ((NSNull *)leaveTime != [NSNull null]) {
            [[NSUserDefaults standardUserDefaults] setObject:leaveTime forKey:KSUOPINGINDEX];
        }
        
        
        //预定设置
        dict = [responseObject objectForKey:@"commonSettingCashierDeskSetting"];
        NSString *yujingshijian = [dict objectForKey:@"orderWarnTime"];
        NSString *suodingshijian = [dict objectForKey:@"orderLockTime"];
        NSString *daoqibaoliushijian = [dict objectForKey:@"orderLockTime"];
        
        [[NSUserDefaults standardUserDefaults] setObject:yujingshijian forKey:KYuJingShiJian];
        [[NSUserDefaults standardUserDefaults] setObject:suodingshijian forKey:KSuoDingShiJian];
        [[NSUserDefaults standardUserDefaults] setObject:daoqibaoliushijian forKey:KDaoQiBaoLiu];
        
       // 手动调用点击第一行，显示预定设置
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self tableView:self.tableView didSelectRowAtIndexPath:index];


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
    
    return 4;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
             }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"预定设置";
            break;
        case 1:
            cell.textLabel.text = @"打印设置";
            break;
        case 2:
            cell.textLabel.text = @"修改密码";
            break;
        case 3:
            cell.textLabel.text = @"帮助";
            break;
            
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.selectCell.backgroundColor = [UIColor whiteColor];
    self.selectCell.textLabel.textColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];

    //更改设置点击背景变蓝
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectCell = cell;
//    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
    cell.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.highlighted = NO;
    

//            NSLog(@"index:%ld",indexPath.row);
    
    if (indexPath.row == 0 ) {
        YuDingViewController *yuding = [[YuDingViewController alloc] init];
        self.label.text=@"预定设置";
        [self SetUpContentViewWithViewController:yuding];
    
    }else if (indexPath.row == 1){
        //cell.backgroundColor = [UIColor redColor];
        PrintViewController *print = [[PrintViewController alloc] init];
        self.label.text=@"打印设置";
        [self SetUpContentViewWithViewController:print];
    }else if (indexPath.row == 2){
        //cell.backgroundColor = [UIColor redColor];
        XiuGaiMiMaViewController *xiugai = [[XiuGaiMiMaViewController alloc] init];
        self.label.text=@"修改密码";
        [self SetUpContentViewWithViewController:xiugai];
    }
   }



-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
//        NSLog(@"deselect index:%ld",indexPath.row);
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
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
- (void)SetUpContentViewWithViewController:(UIViewController *)controller{
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    _tmpViewController = controller;
    [self.contentView addSubview:controller.view];
}
@end
