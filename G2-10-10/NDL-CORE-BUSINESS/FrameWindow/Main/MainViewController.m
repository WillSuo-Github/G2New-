//
//  MainViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/7/20.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "MainViewController.h"
#import "BottomView.h"
#import "MenuHeadView.h"
#import "NDLBaseOrderViewController.h"
#import "CustomAlertView.h"
//#import "UsedViewController.h"
//#import "UnUsedViewController.h"

//#import "VIPViewController.h"
//#import "SetingViewController.h"
//#import "JiaoYiJiLuViewController.h"
//#import "GuQingViewController.h"

//#import "TransfreViewController.h"
//#import "OrderViewController.h"
//#import "MBProgressHUD.h"

//#import "ReserveViewController.h"
//#import "ZhuZhuangViewController.h"
//#import "HardwareInterface.h"

//#import "BluetoothConnectionViewController.h"

#import "NDLBusinessConfigure.h"

@interface MainViewController (){
    BottomView *_bottomView;
}

@end

@implementation MainViewController
@synthesize menuVC;
@synthesize usedVc;
@synthesize OrderVc;
@synthesize imageV;
@synthesize tmpVc;
@synthesize cover;
@synthesize mainVC;


SingletonM(MainView)

- (void)viewDidLoad {
    [super viewDidLoad];
    self.frameWindowDelegate=self;
    self.isHidden = YES;
    [self setUpMenuView];
    [self setUporderVc];//点单控制器的设置
    [self setUpBottomView];//底部工具条
    [self.view bringSubviewToFront:self.view];
    
    self.bottomView.delegate = self;
    self.hardwareInterface = [[HardwareInterface alloc]init];
    [self setUpMenuView];

}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

    //[self setUpMenuView];
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 1;
    [self BottomViewDidChick:nil withButton:btn whereFromStr:@""];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSLog(@"......");
    
}

-(void)viewDidAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    [super viewDidAppear:animated];
    NSLog(@"MainViewController viewDidAppear");
    


}


- (void)setUporderVc{
    NSLog(@"MainViewController setUporderVc");

}

- (void)setUpBottomView{
    BottomView *bottomView = [[BottomView alloc] init];
    _bottomView = bottomView;
    
    [self.view addSubview:bottomView];
  
}


- (void)setUpMenuView{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BottomViewDelegate方法
- (void)BottomViewDidChick:(BottomView *)bottomView withButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr{
    [self bottomViewWithButton:btn whereFromStr:whereFromStr];
}

- (void)removeSomeViews{
    
    for (UIView *view in self.view.subviews) {
        if (![view isMemberOfClass:[BottomView class]]) {
            
            [view removeFromSuperview];
        }
    }
}

#pragma mark - MenuView经常调用的方法

- (void)MainViewInsertSubviewWith:(UIViewController *)ViewVC{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    for (UIView *view in self.view.subviews) {
        if (![view isMemberOfClass:[BottomView class]]) {
            
            [view removeFromSuperview];
        }
        
        self.tmpVc = ViewVC;
        // [self.view addSubview:UnusedVC.view];
        [self.view insertSubview:ViewVC.view atIndex:0];//set this view front
    }
    
}

#pragma mark - MenuViewController代理方法
- (void)MenuViewController:(MenuViewController *)menuVC DidChickMenuCell:(NSInteger)index{

    [self didChickMenuCell:(NSInteger)index];
}


#pragma mark - CoverView的代理方法
- (void)coverViewChick:(CoverView *)coverView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    self.isHidden = YES;
}

#pragma mark - 打样界面的代理方法
- (void)DaYangAlertViewControllerDidChickQuDing:(DaYangAlertViewController *)dayangVc{
    
   [self.dayangAlertVc.view removeFromSuperview];
    [self.dayangBackView removeFromSuperview];
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 2;
    [self BottomViewDidChick:nil withButton:btn whereFromStr:@""];
    
}
-(void)dayangquxiao:(DaYangAlertViewController *)dayang{

    [self.dayangAlertVc.view removeFromSuperview];
    [self.dayangBackView removeFromSuperview];
 
}


- (void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    if ([self.statusStr isEqualToString:@"显示成功"]) {
        
    }
    self.statusStr = @"";
}

-(void)bottomViewWithButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr{
//    if (btn.tag == 2){
//        JYSaoMaXiaDanViewController *usedVc = [[JYSaoMaXiaDanViewController alloc] init];
//        
//        [self MainViewInsertSubviewWith:usedVc];
//    }
    
}

-(void)didChickMenuCell:(NSInteger)index{
    NSLog(@"MainViewController didChickMenuCell%ld",index);
    
}


@end
