//
//  MenuViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/7/21.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuHeadView.h"
#import "MenuViewCell.h"
#import "NDLBusinessConfigure.h"
//#import "TransfreViewController.h"
#import "UIImageView+WebCache.h"
#import "MainViewController.h"
#import "AFNetworking.h"

@interface MenuViewController ()

@property (nonatomic, strong) UIPopoverController *popVC;
@property (weak, nonatomic) IBOutlet UIButton *storeState;
- (IBAction)storeState:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *xiaoYuanDian;

@property (nonatomic, strong) UIView *xiaoyuanView;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantAddressLabel;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    NSLog(@"restarantNameStr:%@",restarantNameStr);
    NSLog(@"restarantLogoImagePathStr:%@",restarantLogoImagePathStr);
    NSLog(@"restarantAddressStr:%@",restarantAddressStr);
    self.restaurantNameLabel.text = [NSString stringWithFormat:@"%@",restarantNameStr];
    self.restaurantAddressLabel.text = [NSString stringWithFormat:@"%@",restarantAddressStr];
    
    
    self.popVC.backgroundColor=[UIColor colorWithRed:106 / 255.0 green:202 / 255.0 blue:107 / 255.0 alpha:1];
    
    
    _xiaoYuanDian.layer.masksToBounds = YES;
    _xiaoYuanDian.layer.cornerRadius = _xiaoYuanDian.bounds.size.width/2;
    
    
    [self setUpBackGroundImage];
    
    self.tableView.tableFooterView  = [[UIView alloc] init];
    self.tableView.scrollEnabled = NO;
    
    self.popVC.delegate = self;
    StoreStateViewController *stateVc = (StoreStateViewController *)self.popVC.contentViewController;
    stateVc.delegate = self;
    self.storeState.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.storeState setTitle:@"" forState:UIControlStateNormal];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIImageView *restaurantLogoImageView = [UIImageView new];
    [restaurantLogoImageView sd_setImageWithURL:[NSURL URLWithString:restarantLogoImagePathStr]];
    
    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/5555"];
    [self.storeState setBackgroundImage:[UIImage imageWithContentsOfFile:str] forState:UIControlStateNormal];
    
    
//    NSURL *url = [NSURL URLWithString:restarantLogoImagePathStr];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    // 2
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    NSString *str = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/55"];
//    
//    operation.inputStream = [NSInputStream inputStreamWithURL:url];
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:str append:NO];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        
//    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//
//        
//    }];
    

    

}


- (void)setUpBackGroundImage{//62  69  80
    self.view.backgroundColor = [UIColor colorWithRed:62/255.0 green:69/255.0 blue:80/255.0 alpha:1];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    MenuViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        
        //自定义单元格 在这注册 ？
        // 在viewDidload  有问题吗？
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MenuViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"q_mainbac2"]];
      
        /**
         *  现在隐藏 第三方外卖 和排队管理
         */
        switch (indexPath.row +2) {
//            case 0:
//                cell.image = [UIImage imageNamed:@"q_dsf"];
//                cell.title = @"第三方外卖";
//                break;
//            case 1:
//                cell.image = [UIImage imageNamed:@"hlk_pdgl"];
//                cell.title = @"排队管理";
//                break;
            case 2:
                cell.image = [UIImage imageNamed:@"hlk_ydgl"];
                cell.title = self.arr[0];
                cell.badgeNum = @"2";
                break;
            case 3:
                cell.image = [UIImage imageNamed:@"hlk_hygl"];
                cell.title =self.arr[1];
                break;
            case 4:
                cell.image = [UIImage imageNamed:@"hlk_jyjl"];
                cell.title = self.arr[2];
                break;
            case 5:
                cell.image = [UIImage imageNamed:@"hlk_sjbg"];
                cell.title = self.arr[3];
                break;
            case 6:
                cell.image = [UIImage imageNamed:@"hlk_gq"];
                cell.title =self.arr[4];
                break;
            case 7:
                cell.image = [UIImage imageNamed:@"hlk_sz"];
                cell.title = self.arr[5];
                break;
            case 8:
                cell.image = [UIImage imageNamed:@"hlk_dy"];
                cell.title = self.arr[6];
                break;
                
            default:
                break;
        }
        
    
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:86/255.0 green:93/255.0 blue:103/255.0 alpha:1 ];
    
    if ([self.delegate respondsToSelector:@selector(MenuViewController:DidChickMenuCell:)]) {
        /**
         *  现在隐藏 第三方外卖 和排队管理
         */
        [self.delegate MenuViewController:self DidChickMenuCell:indexPath.row+2];
        
    }
}


- (IBAction)storeState:(id)sender {

    CGRect storeBounds = self.storeState.bounds;
    storeBounds.origin.x -= 32;
    storeBounds.origin.y += 15;
    [self.popVC presentPopoverFromRect:storeBounds inView:self.storeState permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    
}

- (UIPopoverController *)popVC{
    
    if (_popVC == nil) {
        StoreStateViewController *stateVC = [[StoreStateViewController alloc] init];
        _popVC = [[UIPopoverController alloc] initWithContentViewController:stateVC];
    }
    return _popVC;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}
#pragma mark - StoreStateViewController代理方法

- (void)StoreStateViewController:(StoreStateViewController *)stateVc DidChickStates:(NSInteger)index{
    if (index == 0) {

        [self.storeState setTitle:@"" forState:UIControlStateNormal];
    }else{

        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 1;
        MainViewController *sharedMainView =[MainViewController sharedMainView];
        [sharedMainView BottomViewDidChick:nil withButton:btn whereFromStr:@""];
       
        if ([sharedMainView.frameWindowDelegate respondsToSelector:@selector(toTransfreViewController)]){
            [sharedMainView.frameWindowDelegate toTransfreViewController];
        }
           
    }
}


@end
