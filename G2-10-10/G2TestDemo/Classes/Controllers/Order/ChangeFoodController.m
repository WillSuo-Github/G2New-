//
//  ChangeFoodController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/7.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ChangeFoodController.h"
#import "TTSwitch.h"
#import "ShiJiaController.h"
#import "TiHuanController.h"
#import "OrderViewController.h"
#import "HttpTool.h"


@interface ChangeFoodController ()<TiHuanControllerDelegate,ShiJiaControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *zengsongView;
@property (weak, nonatomic) IBOutlet UIView *tihuanView;
@property (weak, nonatomic) IBOutlet UIView *shijiaView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, strong) TiHuanController *tihuanVc;
@property (weak, nonatomic) IBOutlet UILabel *caiLable;
@property (weak, nonatomic) IBOutlet UITextField *shuliangText;




@property (nonatomic, strong) TTSwitch *sq;
@property (nonatomic, strong) TTSwitch *sq1;
@property (nonatomic, strong) TTSwitch *sq2;

@property (strong,nonatomic) ShiJiaController *shijiaVc;


@property (nonatomic, strong) UIViewController *tmpVc;

@property (nonatomic, copy) NSString *jieshouTaocanID;
@property (nonatomic, strong) replacePG *jieshouReplacePG;

@property (nonatomic, copy) NSString *caiCount;
//huo获得输入的市价
@property (copy,nonatomic) NSString *shijia;
@property (copy,nonatomic) NSString *jiKou;
@end

@implementation ChangeFoodController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self panduanLaiyuan];
    NSLog(@"----%@",self.atOnceMoney);
    //  接受所点击菜品的名字
    self.caiLable.text = self.caiName;
    self.caiCount = self.number;
    self.shuliangText.text = self.caiCount;
    [self setUpSwichView];
    [self panDuanJiKou];
    [self creatJiKou];

}
-(void)panDuanJiKou{
    for (JiKou *ji in self.jiKouArr) {
        if ([self.caiName isEqualToString:ji.dishesName]) {
            self.jiKou = ji.avoidfoodIdArray;
        }
    }
}
-(void)creatJiKou{
    TiHuanController *tihuanVc = [[TiHuanController alloc] init];
    //            NSLog(@"%@---%@",weakSelf.dedishID,weakSelf.taocanID);
    
    tihuanVc.taocanID = self.taocanID;
    tihuanVc.dedishID = self.dedishID;
    tihuanVc.jikou = self.jiKou;
    tihuanVc.delegate = self;
//    [self.contentView addSubview:tihuanVc.view];
    [self contentViewAddSubView:tihuanVc];
//    self.tihuanVc = tihuanVc;
}
-(void)panduanLaiyuan{
    
    if ([self.atOnceMoney isEqualToString:@"0"] ) {
        self.shijiaView.userInteractionEnabled = NO;
    }
    else{
        self.shijiaView.userInteractionEnabled = YES;

    }
    if (self.panDuanStr.length) {
        self.addBtn.userInteractionEnabled = YES;
        self.jianBtn.userInteractionEnabled = YES;
        self.zengsongView.userInteractionEnabled = YES;
        self.contentView.userInteractionEnabled = YES;

    }
    else{
        self.addBtn.userInteractionEnabled = NO;
        self.jianBtn.userInteractionEnabled = NO;
        self.zengsongView.userInteractionEnabled = NO;
        self.contentView.userInteractionEnabled = NO;
    }
}



- (IBAction)jia:(id)sender {
    
    NSInteger count = self.caiCount.integerValue;
    count += 1;
    self.caiCount = [NSString stringWithFormat:@"%ld",count];
    self.shuliangText.text = self.caiCount;
}
- (IBAction)jian:(id)sender {
    
    NSInteger count = self.caiCount.integerValue;
    count -= 1;
    if (count != 0) {
        self.caiCount = [NSString stringWithFormat:@"%ld",count];
        self.shuliangText.text = self.caiCount;
    }
    
}



- (void)setUpSwichView{
    
    TTSwitch *squareThumbSwitch = [[TTSwitch alloc] initWithFrame:(CGRect){ {0.0f,0.0f}, { 76.0f, 27.0f } }];
    _sq = squareThumbSwitch;
    squareThumbSwitch.trackImage = [UIImage imageNamed:@"square-switch-track"];
    squareThumbSwitch.overlayImage = [UIImage imageNamed:@"square-switch-overlay"];
    squareThumbSwitch.thumbImage = [UIImage imageNamed:@"square-switch-thumb"];
    squareThumbSwitch.thumbHighlightImage = [UIImage imageNamed:@"square-switch-thumb-highlight"];
    squareThumbSwitch.trackMaskImage = [UIImage imageNamed:@"square-switch-mask"];
    squareThumbSwitch.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    squareThumbSwitch.thumbInsetX = -3.0f;
    squareThumbSwitch.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [self.zengsongView addSubview:squareThumbSwitch];
    
    TTSwitch *squareThumbSwitch1 = [[TTSwitch alloc] initWithFrame:(CGRect){ {0.0f,0.0f}, { 76.0f, 27.0f } }];
    _sq1 = squareThumbSwitch1;
    squareThumbSwitch1.trackImage = [UIImage imageNamed:@"square-switch-track"];
    squareThumbSwitch1.overlayImage = [UIImage imageNamed:@"square-switch-overlay"];
    squareThumbSwitch1.thumbImage = [UIImage imageNamed:@"square-switch-thumb"];
    squareThumbSwitch1.thumbHighlightImage = [UIImage imageNamed:@"square-switch-thumb-highlight"];
    squareThumbSwitch1.trackMaskImage = [UIImage imageNamed:@"square-switch-mask"];
    squareThumbSwitch1.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    squareThumbSwitch1.thumbInsetX = -3.0f;
    squareThumbSwitch1.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [self.tihuanView addSubview:squareThumbSwitch1];
    
    
    TTSwitch *squareThumbSwitch2 = [[TTSwitch alloc] initWithFrame:(CGRect){ {0.0f,0.0f}, { 76.0f, 27.0f } }];
    _sq2 = squareThumbSwitch2;
    squareThumbSwitch2.trackImage = [UIImage imageNamed:@"square-switch-track"];
    squareThumbSwitch2.overlayImage = [UIImage imageNamed:@"square-switch-overlay"];
    squareThumbSwitch2.thumbImage = [UIImage imageNamed:@"square-switch-thumb"];
    squareThumbSwitch2.thumbHighlightImage = [UIImage imageNamed:@"square-switch-thumb-highlight"];
    squareThumbSwitch2.trackMaskImage = [UIImage imageNamed:@"square-switch-mask"];
    squareThumbSwitch2.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    squareThumbSwitch2.thumbInsetX = -3.0f;
    squareThumbSwitch2.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [self.shijiaView addSubview:squareThumbSwitch2];
    
    
    
    __weak ChangeFoodController *weakSelf = self;
    _sq.changeHandler = ^(BOOL on){
        
        if (on) {
            [weakSelf.sq1 setOn:NO];
            [weakSelf.sq2 setOn:NO];
            //让时价变0WHC
            /////////////
            self.shijia = @"0";
            }
        else{
            
        }
    };
    
    _sq1.changeHandler = ^(BOOL on){
        
        if (on) {
            [weakSelf.sq setOn:NO];
            [weakSelf.sq2 setOn:NO];

            
        }
    };
    ;
     self.shijiaVc = [[ShiJiaController alloc] init];
    self.shijiaVc.delegate = weakSelf;
     __block UIView *view = self.shijiaVc.view;
    _sq2.changeHandler = ^(BOOL on){
       
        if (on) {
            [weakSelf.sq setOn:NO];
            [weakSelf.sq1 setOn:NO];
            [self.contentView addSubview: view];
            [weakSelf contentViewAddSubView:weakSelf.shijiaVc];
        }
        else{
            
//            self.shijia = self.shijiaVc.textField.text;
            [self.shijiaVc.view removeFromSuperview];
        }
    };
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.sq1 setOn:YES];
    
    [self.sq setOn:NO];
    [self.sq2 setOn:NO];
//    TiHuanController *tihuanVc = [[TiHuanController alloc] init];
//        //            NSLog(@"%@---%@",weakSelf.dedishID,weakSelf.taocanID);
//    tihuanVc.delegate = self;
//    tihuanVc.taocanID = self.taocanID;
//    tihuanVc.dedishID = self.dedishID;
//    
//    self.tihuanVc = tihuanVc;
//    
//    [self contentViewAddSubView:tihuanVc];
    //WHC 关闭赠送
    if ([self.zengsong isEqualToString:@"0"]) {
        
        self.zengsongView.userInteractionEnabled = NO;
        [self.sq setOn:YES];
    }
    

}

- (void)contentViewAddSubView:(UIViewController *)subVc{
    //收回键盘后 下面界面消失
//    for (UIView *view in self.contentView.subviews) {
//        [view removeFromSuperview];
//    }
    self.tmpVc = subVc;
    [self.contentView addSubview:subVc.view];
}

- (IBAction)cancle:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)queding:(id)sender {
   //设置市价 
    NSString *dishID = self.dedishID;
    NSString *price = self.shijia;
    if ([self.shijia intValue]) {
        NSString *url = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/addRulingPrices/%@?billType=1&dishNum=1&price=%@",ceshiIP,dishID,price];
        NSLog(@"99999%@",url);
        [HttpTool GET:url parameters:nil success:^(id responseObject) {
            if ([self.delegate respondsToSelector:@selector(sendMesage:andWithPrice:andWithIndex:andWithJiKou:)]) {
                JiKou *jikou = [[JiKou alloc]init];
                jikou.dishesName = self.caiName;
                if (self.jiKou == nil) {
                    self.jiKou = @"";
                }
                jikou.avoidfoodIdArray = self.jiKou;
                [self.delegate sendMesage:self.shuliangText.text andWithPrice:self.shijia andWithIndex:self.indexPath andWithJiKou:jikou];
            }
            
        } failure:^(NSError *error) {
            
        }];

    }else{
//        if ([self.shijia isEqualToString:@"0"]) {
//            
//        }
        if ([self.delegate respondsToSelector:@selector(sendMesage:andWithPrice:andWithIndex:andWithJiKou:)]) {
            JiKou *jikou = [[JiKou alloc]init];
            jikou.dishesName = self.caiName;
            if (self.jiKou == nil) {
                self.jiKou = @"";
            }
            jikou.avoidfoodIdArray = self.jiKou;
            [self.delegate sendMesage:self.shuliangText.text andWithPrice:self.shijia andWithIndex:self.indexPath andWithJiKou:jikou];
        }
    
    }
    
     //发送通知忌口
    [[NSNotificationCenter defaultCenter]postNotificationName:Kjikou object:nil];

   
    
    
    
    if (self.jieshouReplacePG && self.jieshouTaocanID) {
        [OrderViewController sharedOrderView].replaceTaoCanID = self.jieshouTaocanID;
        [OrderViewController sharedOrderView].replaceInfo = self.jieshouReplacePG;
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无替换" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
     
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}




- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tihuanVc 的代理方法
- (void)TiHuanControllerDidChick:(TiHuanController *)tihuanVc replacePG:(replacePG *)replace taocanID:(NSString *)taocanID{
    
//    [OrderViewController sharedOrderView].replaceTaoCanID = self.taocanID;
//    [OrderViewController sharedOrderView].replaceInfo = replace;
    self.jieshouTaocanID = self.taocanID;
    self.jieshouReplacePG = replace;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//键盘的代理
-(void)numberKeyBoardShou:(NSString *)shijia
{
    self.shijia = shijia;
    NSLog(@"dfdf");
}
#pragma mark 忌口的代理
-(void)sendJiKou:(NSString *)jiKou{
    NSLog(@"111%@",jiKou);
    self.jiKou = jiKou;
}
@end
