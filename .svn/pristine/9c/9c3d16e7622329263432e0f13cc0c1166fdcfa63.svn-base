//
//  ReserveViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ReserveViewController.h"
#import "YuDingCell.h"
#import "CreatReserveController.h"
#import "ZhuanTaiViewController.h"
#import "YuDingFirstViewController.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "MBProgressHUD.h"
#import "MainViewController.h"

@interface ReserveViewController ()<zhuantaiDelegate,CreatReserveControllerDelegate>{
    NSInteger _allPageCount;
    YuDingFirstViewController *_first;
}


@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIButton *chuangjianyudingBTN;
//
@property (copy,nonatomic) NSString *tabNo;
@property (copy,nonatomic)NSString *peopleCount;
//@property (copy,nonatomic) NSString *orderId;
@property (copy,nonatomic) NSString *tabId;
@property (copy,nonatomic) NSString *diancanforwardUrl;
//
@property (weak,nonatomic) IBOutlet UIButton *quxiaoyudingBTN;

@property (weak, nonatomic) IBOutlet UILabel *yudingGLLable;

@property (nonatomic, strong) ZhuanTaiViewController *zhuantaiVc;
@property (nonatomic, strong) YuDingFirstViewController *yudingFirstVc;
@property (nonatomic, strong) CreatReserveController *creatReserveVc;

@property (nonatomic, strong) NSMutableArray *quanbuArr;

//选择框的圆角
@property (weak, nonatomic) IBOutlet UILabel *shaixuan;
@property (weak, nonatomic) IBOutlet UIButton *quanbu;
@property (weak, nonatomic) IBOutlet UIButton *yudingzong;
@property (weak, nonatomic) IBOutlet UIButton *yiquxiao;
@property (weak, nonatomic) IBOutlet UIButton *yiwanjie;
@property (weak, nonatomic) IBOutlet UIButton *yiguoqi;
@property (strong,nonatomic)NSString *orderId;
@property (weak, nonatomic) IBOutlet UIButton *diancan;
//添加只能预订中才能点餐 wjy

@property(strong,nonatomic)NSString *orderStatusDesc;


@end

@implementation ReserveViewController
#define CanSelectColor [UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1]


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Yesbutton:) name:Kquxiaoyudingbutton object:nil];
    

    
    
    //选项圆角
    self.chuangjianyudingBTN.layer.cornerRadius=5;
    self.quxiaoyudingBTN.layer.cornerRadius=5;
    self.shaixuan.layer.cornerRadius=5;
    self.quanbu.layer.cornerRadius=5;
    self.yudingzong.layer.cornerRadius=5;
    self.yiquxiao.layer.cornerRadius=5;
    self.yiwanjie.layer.cornerRadius=5;
    self.yiguoqi.layer.cornerRadius=5;
    self.diancan.layer.cornerRadius=5;
    
//button颜色
   self.quanbu.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
    self.yudingzong.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
    self.yiquxiao.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
    self.yiwanjie.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
    self.yiguoqi.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
    self.diancan.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
    
    // Do any additional setup after loading the view from its nib.

//    self.chuangjianyudingBTN.userInteractionEnabled = YES;
//    self.chuangjianyudingBTN.backgroundColor = CanSelectColor;
//    self.quxiaoyudingBTN.userInteractionEnabled = YES;
    [self setBtnCanSelect:self.chuangjianyudingBTN];
    [self setBtnCanNotSelect:self.quxiaoyudingBTN];
    [self setBtnCanNotSelect:self.diancan];
    
    [self setUpFirstViewController];

}




//设置btn可以点击
- (void)setBtnCanSelect:(UIButton *)btn{
    
//    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.userInteractionEnabled = YES;
    btn.backgroundColor = CanSelectColor;
    //whiteColor
}

//设置btn不可以点击
- (void )setBtnCanNotSelect:(UIButton *)btn{
    
    btn.userInteractionEnabled = NO;
    btn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];//灰色
    [btn setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];//灰色字
    //btn.userInteractionEnabled = YES;

   
//    btn.titleLabel.textColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ];
   // [btn setTitleColor:CanSelectColor forState:UIControlStateNormal];
}

#pragma mark - 预定右下点击切换事件
- (IBAction)zhuangTaiXuanYue:(UIButton *)sender {
    NSString *url = @"canyin-frontdesk/order/ajax/order/list?returnJson=json&sortCol=createTime&direction=desc";
    //&search_EQ_orderStatus=2
    
    
    /**
     *  点击 选项按钮之后 将搜索框清空 以待下次搜索
     */
    // 11-17 start of line for add
    
    self.yudingFirstVc.searbar.text = @"";
    
    
    // the day is fine day 
    
    // end of line
    
    
    switch (sender.tag) {
        case 21://全部
        {
            NSString *url1 = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/order/list?returnJson=json",ceshiIP];
            url = [url1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
            /**
             *  将这个URL接口  传递到第一响应者中
             */
            self.yudingFirstVc.getUrl = url1;
          
            
            
            //全部button点击后为灰色
            self.quanbu.backgroundColor=[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
            
            
          
            self.yudingzong.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiquxiao.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiwanjie.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiguoqi.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];

        }
            
            break;
        case 22://预定中2
            url = [NSString stringWithFormat:@"%@/%@&search_EQ_orderStatus=2",ceshiIP,url];
            self.yudingFirstVc.getUrl = url;
//            NSLog(@"124355678123677%@",url);
            //预定button点击后为灰色
            self.yudingzong.backgroundColor=[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
            
            self.quanbu.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
            self.yiquxiao.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiwanjie.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiguoqi.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            
            
            
            break;
        case 23://已取消5
            url = [NSString stringWithFormat:@"%@/%@&search_EQ_orderStatus=5",ceshiIP,url];
            self.yudingFirstVc.getUrl = url;

            self.yiquxiao.backgroundColor=[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
            

            
            self.quanbu.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
            self.yudingzong.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiwanjie.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiguoqi.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            
            break;
        case 24://已完结4
            url = [NSString stringWithFormat:@"%@/%@&search_EQ_orderStatus=4",ceshiIP,url];
            self.yudingFirstVc.getUrl = url;

            self.yiwanjie.backgroundColor=[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
            

            self.quanbu.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
            self.yudingzong.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiquxiao.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            
            self.yiguoqi.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            break;
        case 25://已过期7
            url = [NSString stringWithFormat:@"%@/%@&search_EQ_orderStatus=7",ceshiIP,url];
            self.yudingFirstVc.getUrl = url;
            self.yiguoqi.backgroundColor=[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1];
            

            self.quanbu.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
            self.yudingzong.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiquxiao.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            self.yiwanjie.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            
            break;
        default:
            break;
    }
    [self showHUD:@"拼命加载中..."];

    
    
    [HttpTool POST:url parameters:nil success:^(id responseObject) {
        NSLog(@"%@",url);
        [self hideHUD];
        self.quanbuArr = [NSMutableArray alloc];
        NSDictionary *dict = [responseObject objectForKey:@"tableOrders"];
        NSArray *arr = [dict objectForKey:@"content"];
        self.quanbuArr = [YuDingList objectArrayWithKeyValuesArray:arr];
        self.yudingFirstVc.dataArr = self.quanbuArr;
        if (self.quanbuArr.count == 0)
        {
            
            NSString *message = [NSString stringWithFormat:@"没有%@的了",sender.titleLabel.text];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alertView show];
            
        }
    } failure:^(NSError *error) {
        
    }];
    
//    [HttpTool POST:url parameters:nil success:^(id responseObject) {
//        self.quanbuArr = [NSMutableArray alloc];
//        NSDictionary *dict = [responseObject objectForKey:@"tableOrders"];
//        NSLog(@"__%@",dict);
//        _allPageCount = [dict objectForKey:@"totalPages"];
//        NSArray *arr = [dict objectForKey:@"content"];
//        self.quanbuArr = [YuDingList objectArrayWithKeyValuesArray:arr];
//    } failure:^(NSError *error) {
//        
//    }];
    
    
}


- (void)setUpFirstViewController{
    
    YuDingFirstViewController *yudingFirst = [[YuDingFirstViewController alloc] init];
    
    
    self.yudingFirstVc = yudingFirst;
    [self.contentView addSubview:yudingFirst.view];
}

//- (IBAction)zhuantai:(id)sender {
//    
//    self.zhuantaiBTN.userInteractionEnabled = NO;
//    self.chuangjianyudingBTN.userInteractionEnabled = NO;
//    self.quxiaoyudingBTN.userInteractionEnabled = NO;
//    ZhuanTaiViewController *zhuantaiVc = [[ZhuanTaiViewController alloc] init];
//    _zhuantaiVc = zhuantaiVc;
//    zhuantaiVc.delegate = self;
//    [self.contentView addSubview:zhuantaiVc.view];
//    
//}


#pragma mark - 文字转换代理方法
- (void)ChangeLabelText{
    _yudingGLLable.text = @"预定管理";
}


- (IBAction)chuangjianyuding:(id)sender {
    
    if (self.chuangjianyudingBTN.selected == YES) {
        self.chuangjianyudingBTN.userInteractionEnabled = NO;
    }
    

//    self.quanbu.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    [self.quanbu setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
//    self.quanbu.userInteractionEnabled=NO;
//    
//    self.yudingzong.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    [self.yudingzong setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
//    self.yudingzong.userInteractionEnabled=NO;
//    
//    self.yiquxiao.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    [self.yiquxiao setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
//    self.yiquxiao.userInteractionEnabled=NO;
//    
//    self.yiwanjie.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    [self.yiwanjie setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
//    self.yiwanjie.userInteractionEnabled=NO;
//    
//    self.yiguoqi.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
//    [self.yiguoqi setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
//    self.yiguoqi.userInteractionEnabled=NO;
    
    
    self.yudingGLLable.text = @"预定选项";
    [self setBtnCanNotSelect:self.quxiaoyudingBTN];
    [self setBtnCanNotSelect:self.diancan];
    [self setBtnCanNotSelect:self.chuangjianyudingBTN];

    CreatReserveController *creatVc = [[CreatReserveController alloc] init];
    _creatReserveVc = creatVc;
    creatVc.delegate = self;
    [self.contentView addSubview:creatVc.view];
    
}
- (IBAction)diancai:(id)sender {
    
//    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"fffffff" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//    [alertView show];
    //点餐事件跳转
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.tabNo,@"table.tabNo",self.tabId,@"table.tabId",self.tabNo,@"tableNo",self.orderId,@"orderId", nil];
    if (self.peopleCount != nil) {
        [dict setObject:self.peopleCount forKey:@"peopleCount"];
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ReaerToOrder" object:nil userInfo:dict];
    //        self.diancanforwardUrl = [responseObject objectForKey:@"forwardUrl"];
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 1;
    //    [NSNotificationCenter defaultCenter]
    [[MainViewController sharedMainView] BottomViewDidChick:nil withButton:btn whereFromStr:@"yuding"];
    if ([self.delegate respondsToSelector:@selector(sendMeggage)]) {
        [self.delegate sendMeggage];
    }


//    NSString *tableUrlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/kaitai/create",ceshiIP];
//    [HttpTool GET:tableUrlStr parameters:dict success:^(id responseObject) {
//    if ([[responseObject objectForKey:@"message"] isEqualToString:@"1"]) {
//        //通知传旨
//      }
//    else if([[responseObject objectForKey:@"message"] isEqualToString:@"2"]){
//        [self alert:@"开台失败,无此餐台"];
//    }
//    else if([[responseObject objectForKey:@"message"] isEqualToString:@"6"]){
//        [self alert:@"开台失败,此餐台已被预订锁定"];
//    }
//    else if([[responseObject objectForKey:@"message"] isEqualToString:@"7"]){
//        [self alert:@"开台失败,此餐台状态非空闲"];
//    }
//        
//} failure:^(NSError *error) {
////    [self showAlertViewMessage:@"下单失败"];
//}];
}
//弹窗
-(void)alert:(NSString *)str{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];

}
- (IBAction)cancle:(id)sender {

    NSString *url1 = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/cancle/%@",ceshiIP,self.orderId];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"73ecdca0-f54f-11e4-af9a-02004c4f4f50",@"reaId",@"",@"cancleReason", nil];
    
    NSLog(@"%@",url1);
   
    
    [HttpTool POST:url1 parameters:dict success:^(id responseObject) {
        
        
        NSString *str=[responseObject objectForKey:@"message"];
        if ([str isEqualToString:@"取消成功"]) {
            
            
            self.quxiaoyudingBTN.userInteractionEnabled=NO;
            self.diancan.userInteractionEnabled=NO;
            self.diancan.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
            [self.diancan setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.quxiaoyudingBTN.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
            

            [self.quxiaoyudingBTN setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"取消成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertView show];
            
           self.yudingzong.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
            [self.yudingFirstVc.tableView reloadData];
        }
        NSLog( @"%@",responseObject);
        NSLog(@"%@",url1);
        
    } failure:^(NSError *error) {
        
        
        
    }];
    
    
//
//        [HttpTool GET:url1 parameters:nil success:^(id responseObject) {
//            
//            
//            //[self setUpFirstViewController];
//            //[self reloadInputViews];
//            NSLog(@"成功");
//        } failure:^(NSError *error) {
//            NSLog( @"失败");
//        }];
//    
//
//    [self setBtnCanNotSelect:self.quxiaoyudingBTN];
//    [self setBtnCanSelect:self.chuangjianyudingBTN];
    
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    [self setUpFirstViewController];

}

//- (void)setUpContentViewWithViewController:(UIViewController *)vc{
//    
//    for (UIView *view in self.contentView.subviews) {
//        [view removeFromSuperview];
//    }
//    _tmpVc = vc;
//    [self.contentView addSubview:vc.view];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button能被点击

//预定中才能点击取消订单和点餐
-(void)Yesbutton:(NSNotification *) aNotification
{
    NSDictionary *dic = [aNotification  userInfo];
    NSLog(@"%@",dic);
   // orderStatusDesc
    self.orderStatusDesc=[dic objectForKey:@"orderStatusDesc"];
    if ([self.orderStatusDesc isEqualToString:@"预定中"]) {
        self.orderId = [dic  objectForKey:@"orderId"];
        
        NSLog(@"%@",self.orderId);
        self.quxiaoyudingBTN.userInteractionEnabled=YES;
        self.diancan.userInteractionEnabled=YES;
        self.diancan.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
        [self.diancan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.quxiaoyudingBTN.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
        [self.quxiaoyudingBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.orderId = dic[@"orderId"];
        self.tabId = dic[@"tabId"];
        self.tabNo = dic[@"tabNo"];
        self.peopleCount = dic[@"peopleNum"];
    

    } else {
        
        
        self.quxiaoyudingBTN.userInteractionEnabled=NO;
        self.diancan.userInteractionEnabled=NO;
        self.quxiaoyudingBTN.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self.quxiaoyudingBTN setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
        self.diancan.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self.diancan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ] forState:UIControlStateNormal];
       
        
    }
    //结束 wjy
    
    
    
//    self.orderId = [dic  objectForKey:@"orderId"];
//    
//    NSLog(@"%@",self.orderId);
//    self.quxiaoyudingBTN.userInteractionEnabled=YES;
//     self.diancan.userInteractionEnabled=YES;
//    self.diancan.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
//    [self.diancan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    self.quxiaoyudingBTN.backgroundColor=[UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1 ];
//    [self.quxiaoyudingBTN setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    self.orderId = dic[@"orderId"];
//    self.tabId = dic[@"tabId"];
//    self.tabNo = dic[@"tabNo"];
    
    //删除通知
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:Kquxiaoyudingbutton object:nil];
    

}
-(void)dealloc{
    
    //删除通知
       [[NSNotificationCenter defaultCenter]removeObserver:self name:Kquxiaoyudingbutton object:nil];
    
}



#pragma mark - 转台的代理方法
- (void)zhuantaiViewDidDismissWith:(ZhuanTaiViewController *)zhuantaiVc{
    
//    self.zhuantaiBTN.userInteractionEnabled = YES;
    self.chuangjianyudingBTN.userInteractionEnabled = NO;
    self.quxiaoyudingBTN.userInteractionEnabled = YES;
}

#pragma mark - 创建预定的代理方法
- (void)CreatReserveControllerDidDismiss:(CreatReserveController *)creatVc{
    
//    self.zhuantaiBTN.userInteractionEnabled = YES;
//    self.chuangjianyudingBTN.userInteractionEnabled = YES;
//    self.quxiaoyudingBTN.userInteractionEnabled = YES;
    [self setBtnCanSelect:self.chuangjianyudingBTN];
    [self setBtnCanNotSelect:self.quxiaoyudingBTN];
    [self setBtnCanNotSelect:self.diancan];
    
    
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
