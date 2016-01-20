//
//  JYMainViewController.m
//  G2TestDemo
//
//  Created by tencrwin on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYMainViewController.h"
#import "NDLBusinessConfigure.h"
#import "lhScanQCodeViewController.h"
#import "JYSaoMaXiaDanViewController.h"

#import "NDLFrameWindowDelegate.h"
//购物车
#import "JYGouWuCheViewController.h"
#import "JYOrderViewController.h"
#import "JYJiaoYiJiLuViewController.h"
#import "JYJiaoYiJiLuViewController.h"
#import "JySetingViewController.h"
#import "NDLSettingDelegate.h"
#import "JYSettingManager.h"
@interface JYMainViewController ()

@end

@implementation JYMainViewController


-(void)setUpBottomView{
    [super setUpBottomView];
    NSArray *arr = @[@"商品下单",@"扫码下单",@"购物车"];
    BottomView *bottomView = [[BottomView alloc] initWithArr:arr];
    self.bottomView = bottomView;
    bottomView.delegate = self;
    [self.view addSubview:bottomView];
}
-(void)bottomViewWithButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr{
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
    }
    if (btn.tag == 1){
        
        //  扫码下单
        JYOrderViewController *usedVc = [[JYOrderViewController alloc] init];
        [self MainViewInsertSubviewWith:usedVc];
    }

    if (btn.tag == 2){
            
          //  主页
            JYSaoMaXiaDanViewController *usedVc = [[JYSaoMaXiaDanViewController alloc] init];
            [self MainViewInsertSubviewWith:usedVc];
        }
    if (btn.tag == 3){
        
        //  购物车
        JYGouWuCheViewController *GWC = [[JYGouWuCheViewController alloc] init];
        [self MainViewInsertSubviewWith:GWC];
    }

    
    

}

-(void)didChickMenuCell:(NSInteger)index{
    
    
    

    if (index != 5) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.view.transform = CGAffineTransformIdentity;
            self.isHidden = YES;
            self.cover.hidden = YES;
        }completion:^(BOOL finished) {
            self.menuVC.view.hidden = YES;
        }];
    }
    
    if (index == 2) {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"会员管理" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];

        
    }else if (index == 3) {
        JYJiaoYiJiLuViewController *JYJL=[[JYJiaoYiJiLuViewController alloc]init];
        [self MainViewInsertSubviewWith:JYJL];
    }else if (index == 4){
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据报告" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];

    }else if (index == 5){
        id<NDLSettingDelegate> settingDelegate = [[JySetingViewController alloc]init];
        JYSettingManager *settingManager=[JYSettingManager settingManager];
        SetingViewController *settingVC = [[SetingViewController alloc]init];
        settingVC.settingDelegate = settingDelegate;
        settingVC.settingManager=settingManager;
        [self MainViewInsertSubviewWith:settingVC];
        
    }else if (index == 6){
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"打样" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [alertView show];
    }
        
    



}

- (void)MenuViewController:(MenuViewController *)menuVC DidChickMenuCell:(NSInteger)index{
    
    [self didChickMenuCell:(NSInteger)index];
}

-(void)setUpMenuView{
    
    [super setUpMenuView];
    MenuViewController *localMenuVC = [[MenuViewController alloc] init];
    localMenuVC.view.frame = CGRectMake(0, 0,193, [UIScreen mainScreen].bounds.size.height);
    
    localMenuVC.view.hidden = NO;
    self.menuVC = localMenuVC;
    self.menuVC.delegate = self;
    self.menuVC.arr = @[@"会员管理",@"交易记录",@"数据报告",@"设置",@"打样"];
    [[UIApplication sharedApplication].keyWindow addSubview:self.menuVC.view];
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
