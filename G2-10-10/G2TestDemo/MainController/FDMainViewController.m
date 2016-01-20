//
//  FDMainViewController.m
//  G2TestDemo
//
//  Created by NDlan on 6/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FDMainViewController.h"

#import "NDLCoreBusincessHeader.h"
#import "HttpTool.h"
#import "DaYangTable.h"
#import "MJExtension.h"
#import "OrderViewController.h"
#import "ReserveViewController.h"
#import "VIPViewController.h"
#import "JiaoYiJiLuViewController.h"
#import "SetingViewController.h"
#import "ZhuZhuangViewController.h"
#import "GuQingViewController.h"
#import "ReserveViewController.h"
#import "TransfreViewController.h"
#import "MBProgressHUD.h"
#import "BottomView.h"

#import "Common.h"
#import "NDLBusinessConfigure.h"



@implementation FDMainViewController
//@dynamic cover;

- (void)setUporderVc{
    [super setUporderVc];
    //跳入点单控制器
    OrderViewController *orderVc = [[OrderViewController alloc] init];
    self.OrderVc = orderVc;
    [self.view addSubview:orderVc.view];
}
-(void)bottomViewWithButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr{
    NSLog(@"bottomTag%ld",btn.tag);
    //0  菜单
    if (btn.tag == 0) {
        self.menuVC.view.hidden = NO;
        if (self.isHidden) {
            [UIView animateWithDuration:0.3 animations:^{
                CoverView *cover = [CoverView showWithRect:CGRectMake(193, 0, kScreenWidth, kScreenHeight)];
                self.cover = cover;
                self.cover.delegate = self;
                self.view.transform = CGAffineTransformMakeTranslation(193, 0);
            }];
            
            self.isHidden = NO;
            self.cover.hidden = NO;
        }else{
            
            [UIView animateWithDuration:0.3 animations:^{
                self.view.transform = CGAffineTransformIdentity;
            }];
            
            self.isHidden = YES;
            self.cover.hidden = YES;
        }
    } // 点单
    else if (btn.tag == 1){
        
        
        [btn setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
        
        OrderViewController *orderVC = [[OrderViewController alloc] init];
        orderVC.whereFromStr = whereFromStr;
        self.OrderVc = orderVC;
        [self MainViewInsertSubviewWith:orderVC];
    }//餐台状态
    else if (btn.tag == 2){
        UsedViewController *usedVc = [[UsedViewController alloc] init];
        
        self.usedVc = usedVc;
        self.usedVc.delegate = self.OrderVc;
        [self MainViewInsertSubviewWith:usedVc];
    }
    
}



-(void)didChickMenuCell:(NSInteger)index{
    if (index != 8) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.view.transform = CGAffineTransformIdentity;
            self.isHidden = YES;
            self.cover.hidden = YES;
        }completion:^(BOOL finished) {
            self.menuVC.view.hidden = YES;
        }];
    }
    
    if (index == 2) {
        
        ReserveViewController *resrverVc = [[ReserveViewController alloc] init];
        [self MainViewInsertSubviewWith:resrverVc];
    }else if (index == 3) {
        
        VIPViewController *vipVC = [[VIPViewController alloc] init];
        [self MainViewInsertSubviewWith:vipVC];
    }else if (index == 4){
        
        JiaoYiJiLuViewController *jiaoyiVc = [[JiaoYiJiLuViewController alloc] init];
        [self MainViewInsertSubviewWith:jiaoyiVc];
    }else if (index == 7){
        
        SetingViewController *setingVc = [[SetingViewController alloc] init];
        [self MainViewInsertSubviewWith:setingVc];
    }else if (index == 5){
        
        ZhuZhuangViewController *tiaoxing = [[ZhuZhuangViewController alloc] init];
        [self MainViewInsertSubviewWith:tiaoxing];
        
    }else if (index == 6){
        
        GuQingViewController *guqing = [[GuQingViewController alloc] init];
        [self MainViewInsertSubviewWith:guqing];
        
    }else if (index == 8)
    {
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.hud.labelText = @"请稍后";
        self.hud.dimBackground = YES;
        [self.hud show:YES];
        [self checkTable];
        
    }
    
}
//餐饮的左边按钮
-(void)setUpMenuView{
    [super setUpMenuView];
    
    MenuViewController *localMenuVC = [[MenuViewController alloc] init];
    localMenuVC.view.frame = CGRectMake(0, 0,193, [UIScreen mainScreen].bounds.size.height);
    
    localMenuVC.view.hidden = NO;
    self.menuVC = localMenuVC;
    self.menuVC.delegate = self;
    self.menuVC.arr = @[@"预定管理",@"会员管理",@"交易记录",@"数据报告",@"沽清",@"设置",@"打样"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.menuVC.view];
}
- (void)checkTable{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/logoutCheck?returnJson=json",ceshiIP];
    //    NSLog(@"+++%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        [self.hud hide:YES];
        NSDictionary *dict = [responseObject objectForKey:@"ajax"];
        NSString *value = [dict objectForKey:@"value"];
        
        NSArray *arr = [responseObject objectForKey:@"table"];
        arr = [DaYangTable objectArrayWithKeyValuesArray:arr];
        if ([value isEqualToString:@"false"]) {
            DaYangAlertViewController *dayangAlert = [[DaYangAlertViewController alloc] init];
            self.dayangAlertVc = dayangAlert;
            dayangAlert.delegate = self;
            dayangAlert.view.frame = CGRectMake(317,162,429, 405);
            dayangAlert.arr = arr;
            
//            
//            UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
//            backgroundView.backgroundColor = [UIColor blackColor];
//            backgroundView.alpha = 0.2;
//            self.dayangBackView = backgroundView;
            
            // add by manman start of line
            // 修改  点击打烊 ，再点击其他功能按钮，打烊界面不收回
            UIView *backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
            backgroundView.backgroundColor = [UIColor blackColor];
            backgroundView.alpha = 0.2;
            self.dayangBackView = backgroundView;
            
            
            
            
            // end of line
            
            
            
            [kKeyWindow addSubview:backgroundView];
            
            
            [kKeyWindow addSubview:dayangAlert.view];
            
            
        }else{
            
            TransfreViewController *transfre = [[TransfreViewController alloc] init];
            transfre.isDaYang = YES;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:transfre animated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)toTransfreViewController{
     TransfreViewController *transfre = [[TransfreViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:transfre animated:YES completion:nil];

}
-(void)setUpBottomView{
    [super setUpBottomView];
    NSArray *arr = @[@"点单",@"餐台状态"];
    BottomView *bottomView = [[BottomView alloc] initWithArr:arr];
    self.bottomView = bottomView;
    
    [self.view addSubview:bottomView];
}
@end
