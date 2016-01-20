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
#import "UsedViewController.h"
#import "UnUsedViewController.h"
#import "CoverView.h"
#import "VIPViewController.h"
#import "SetingViewController.h"
#import "JiaoYiJiLuViewController.h"
#import "GuQingViewController.h"
#import "DaYangAlertViewController.h"
#import "TransfreViewController.h"
#import "OrderViewController.h"
#import "MBProgressHUD.h"
#import "HttpTool.h"
#import "DaYangTable.h"
#import "MJExtension.h"
#import "ReserveViewController.h"
#import "ZhuZhuangViewController.h"
#import "HardwareInterface.h"

#import "BluetoothConnectionViewController.h"
@interface MainViewController ()<BottomViewDelegate,MenuViewControllerDelegate,CoverViewDelegate,DaYangAlertViewControllerDelegate>{
    
    
    BottomView *_bottomView;

}



@property (nonatomic, strong) UsedViewController *usedVc;
@property (nonatomic, strong) OrderViewController *OrderVc;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIViewController *tmpVc;
@property (nonatomic, strong) CoverView *cover;
@property (nonatomic, strong) MBProgressHUD *hud;
@property(strong,nonatomic)MainViewController *mainVC;

@property (strong, nonatomic)DaYangAlertViewController *dayangAlertVc;

@property (strong, nonatomic)UIView *dayangBackView;
@property(strong,nonatomic)HardwareInterface *hardwareInterface;



@end

@implementation MainViewController

SingletonM(MainView)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isHidden = YES;
    [self setUpMenuView];
//    [self setUpUsedView];
    [self setUporderVc];//点单控制器的设置
    [self setUpBottomView];//底部工具条
    [self.view bringSubviewToFront:self.view];
    
    _bottomView.delegate = self;
    self.hardwareInterface = [[HardwareInterface alloc]init];
    [self setUpMenuView];

//    _bottomView.delegate = self.menuVC;
    
    //[self initBLESDK];

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
    [super viewWillAppear:animated];
    
    NSLog(@"viewDidAppear");
    
//    if (MiniPosSDKDeviceState() < 0) {
//        
//        BluetoothConnectionViewController *bcVC = [[BluetoothConnectionViewController alloc]init];
//        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:bcVC];
//        nc.modalPresentationStyle = UIModalPresentationFormSheet;
//        [kKeyWindow.rootViewController presentViewController:nc animated:YES completion:nil];
//    }
    

}



//- (void)setUpUsedView{
//    UsedViewController *usedVc = [[UsedViewController alloc] init];
//    _usedVc = usedVc;
//    [self.view addSubview:usedVc.view];
//    
//}

- (void)setUporderVc{
    
//    UnUsedViewController *UnUsedVC = [[UnUsedViewController alloc] init];
//    _UnUsedVc = UnUsedVC;
//    [self.view addSubview:UnUsedVC.view];
    
    //跳入点单控制器
    OrderViewController *orderVc = [[OrderViewController alloc] init];
    _OrderVc = orderVc;
    [self.view addSubview:orderVc.view];
}

- (void)setUpBottomView{
    
    BottomView *bottomView = [[BottomView alloc] init];
    _bottomView = bottomView;

    [self.view addSubview:bottomView];
}


- (void)setUpMenuView{
    

    MenuViewController *menuVC = [[MenuViewController alloc] init];
    menuVC.view.frame = CGRectMake(0, 0,193, [UIScreen mainScreen].bounds.size.height);
    //Test SVN LiuJQ
    NSLog(@"menuVC.view.hidden");
    menuVC.view.hidden = NO;
    self.menuVC = menuVC;
    menuVC.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:menuVC.view];
//    [self.view addSubview:menuVC.view];
//    [self.view insertSubview:menuVC.view belowSubview:self.view];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - BottomViewDelegate方法
- (void)BottomViewDidChick:(BottomView *)bottomView withButton:(UIButton *)btn whereFromStr:(NSString *)whereFromStr{
    
    NSLog(@"bottomTag%ld",btn.tag);
    //0  菜单
    if (btn.tag == 0) {
        self.menuVC.view.hidden = NO;
        if (self.isHidden) {
            [UIView animateWithDuration:0.3 animations:^{
                CoverView *cover = [CoverView showWithRect:CGRectMake(193, 0, kScreenWidth, kScreenHeight)];
                _cover = cover;
                cover.delegate = self;
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

//        UnUsedViewController *UnusedVc = [[UnUsedViewController alloc] init];
//        [self MainViewInsertSubviewWith:UnusedVc];
        [btn setBackgroundColor:[UIColor colorWithRed:62/225.0 green:69/225.0 blue:80/255.0 alpha:1]];
        
        OrderViewController *orderVC = [[OrderViewController alloc] init];
        orderVC.whereFromStr = whereFromStr;
        _OrderVc = orderVC;
        [self MainViewInsertSubviewWith:orderVC];
    }//餐台状态    
    else if (btn.tag == 2){

       
        UsedViewController *usedVc = [[UsedViewController alloc] init];
        
        _usedVc = usedVc;
        _usedVc.delegate = _OrderVc;
        //btn.backgroundColor = [UIColor redColor];
        [self MainViewInsertSubviewWith:usedVc];
    }
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
        
        _tmpVc = ViewVC;
        // [self.view addSubview:UnusedVC.view];
        [self.view insertSubview:ViewVC.view atIndex:0];//set this view front
    }
    
}


#pragma mark - MenuViewController代理方法
- (void)MenuViewController:(MenuViewController *)menuVC DidChickMenuCell:(NSInteger)index{
    
    

//    NSLog(@"test index did select %ld",index);
    
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
            //dayangAlert.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            //dayangAlert.modalPresentationStyle = UIModalPresentationFormSheet;
           
//            GuQingNumController *guqingNum = [[GuQingNumController alloc] init];
//            guqingNum.view.frame = CGRectMake(280, 90, 390, 445);
//            guqingNum.delegate = self;
//            
//            self.guqingVc = guqingNum;
//            
//            [kKeyWindow addSubview:guqingNum.view];
        // dayangAlert.modalPresentationStyle = UIModalPresentationFormSheet;
            
            
            //设置打样界面大小
//            MainViewController *mainView=[[MainViewController alloc]init];
//            mainView.view.frame=CGRectMake(280, 90, 200, 405);
            
        
           // self.mainVC=mainView;
            
           // [kKeyWindow addSubview:mainView.view];
            
            
            // modify start the line
            
            UIView *backgroundView = [[UIView alloc]initWithFrame:self.view.frame];
            backgroundView.backgroundColor = [UIColor blackColor];
            backgroundView.alpha = 0.2;
            self.dayangBackView = backgroundView;
            
            [kKeyWindow addSubview:backgroundView];
            
            
            [kKeyWindow addSubview:dayangAlert.view];
            
            
            
            
            
            
            
            
            //end of line
            
            
            
            
            
            
            
            
            //[kKeyWindow.rootViewController presentViewController:dayangAlert animated:YES completion:nil];
        }else{
            
            TransfreViewController *transfre = [[TransfreViewController alloc] init];
            transfre.isDaYang = YES;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:transfre animated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
    
    self.statusStr = @"";
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
