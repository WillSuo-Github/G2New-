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
#import "SetingViewController.h"
#import "SettingAboutViewController.h"
#import "CaoZuoViewController.h"
#import "XiuGaiMiMaViewController.h"
#import "HelpDocumentViewController.h"
#import "HttpTool.h"

#import "NDLBusinessConfigure.h"
#import "NDLFrameworkHeader.h"


Boolean dianji;


@interface SetingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IQKeyboardReturnKeyHandler  *returnKeyHandler;


@property (nonatomic, strong)UITableViewCell *selectCell;
@end

@implementation SetingViewController
@synthesize  tableView;
@synthesize contentView;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (self.settingDelegate == nil) {
        self.settingDelegate = self;
       
    }
    
    
    // 代理更换  数据源
    if ([self.settingDelegate respondsToSelector:@selector(setSettingMenu:)]){
        self.settingMenuArray = [NSArray arrayWithArray:[self.settingDelegate setSettingMenu:self]];
        
    }
    if (self.tableView==nil) {
        self.tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 100, 180, 677) style:UITableViewStylePlain];
        //self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        [self.view addSubview: self.tableView];
       
        

    }
    self.tableView.separatorInset = UIEdgeInsetsZero;
    if(self.contentView == nil)
    {
        self.contentView = [[UIView alloc]initWithFrame:CGRectMake(182, 101, 842, 578)];
        [self.view addSubview:self.contentView];
        
    }
    
    
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
    [self tableView:self.tableView didSelectRowAtIndexPath:index];
    
    if (self.settingManager==nil) {
       self.settingManager= [NDLSettingManager settingManager];
    }
    
    
    [self requestSetingInfo];
    
}

#pragma  NDLSettingDelegate

-(NSArray *)SetSettingMenu
{

     return [NSArray arrayWithObjects:@"预定设置",@"打印设置",@"修改密码",@"帮助",@"关于", nil];
}
-(NSArray *)setSettingMenu:(SetingViewController *)setingViewController{
    return [self SetSettingMenu];
}
-(void)DidSelectMenuIndex:(NSInteger)index
{
    
    NSLog(@" did select index row:%ld",index);
    
    if (index == 0 ) {
        YuDingViewController *yuding = [[YuDingViewController alloc] init];
        self.label.text=@"预定设置";
        //[self SetUpContentViewWithViewController:yuding];
        if ([self.settingDelegate respondsToSelector:@selector(didSelectMenuIndex:target:)]) {
            [self.settingDelegate didSelectMenuIndex:self target:yuding];
        }
        
    }else if (index == 1){
        //cell.backgroundColor = [UIColor redColor];
        PrintViewController *print = [[PrintViewController alloc] init];
        self.label.text=@"打印设置";
        //[self SetUpContentViewWithViewController:print];
        if ([self.settingDelegate respondsToSelector:@selector(didSelectMenuIndex:target:)]) {
            [self.settingDelegate didSelectMenuIndex:self target:print];
        }
    }else if (index== 2){
        //cell.backgroundColor = [UIColor redColor];
        XiuGaiMiMaViewController *xiugai = [[XiuGaiMiMaViewController alloc] init];
        self.label.text=@"修改密码";
        //[self SetUpContentViewWithViewController:xiugai];
        if ([self.settingDelegate respondsToSelector:@selector(didSelectMenuIndex:target:)]) {
            [self.settingDelegate didSelectMenuIndex:self target:xiugai];
        }
        
    }else if (index == 3)
    {
        HelpDocumentViewController *helpDoc = [[HelpDocumentViewController alloc]init];
        self.label.text = @"帮助";
        //[self SetUpContentViewWithViewController:helpDoc];
        if ([self.settingDelegate respondsToSelector:@selector(didSelectMenuIndex:target:)]) {
            [self.settingDelegate didSelectMenuIndex:self target:helpDoc];
        }
        
    }
    else if (index == 4)
    {
        //cell.backgroundColor = [UIColor redColor];
        SettingAboutViewController *settingAboutVC = [[SettingAboutViewController alloc] init];
        self.label.text=@"关于";
        NSLog(@" setting about 。。。");
        if ([self.settingDelegate respondsToSelector:@selector(didSelectMenuIndex:target:)]) {
            [self.settingDelegate didSelectMenuIndex:self target:settingAboutVC];
        }
        //[self SetUpContentViewWithViewController:settingAboutVC];
    }
    
    
    
}


- (void)requestSetingInfo{
    [self.settingManager requestSetingInfo:nil block:^(NSObject *response,ErrorMessage *errorMessage){
        // 手动调用点击第一行，显示预定设置
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:self.tableView didSelectRowAtIndexPath:index];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView的数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.settingMenuArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
             }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.settingMenuArray[indexPath.row];
    NSLog(@"index.row:%@ row:%ld",self.settingMenuArray[indexPath.row],indexPath.row);

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectCell.backgroundColor = [UIColor whiteColor];
    self.selectCell.textLabel.textColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
    
    //更改设置点击背景变蓝
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectCell = cell;
    //cell.backgroundColor = [UIColor whiteColor];
    //cell.textLabel.textColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
//    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
//    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
    cell.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.highlighted = NO;
    NSLog(@" did select index row:%ld",indexPath.row);
    [self DidSelectMenuIndex:indexPath.row];

}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
       NSLog(@"deselect index:%ld",indexPath.row);
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor grayColor];
    
    
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

-(void)didSelectMenuIndex:(UIViewController *)setingViewController target:(UIViewController *)controller
{
    
    SetingViewController *setingView=setingViewController;
    for (UIView *view in setingView.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    _tmpViewController = controller;
    [setingView.contentView addSubview:controller.view];
}
@end
