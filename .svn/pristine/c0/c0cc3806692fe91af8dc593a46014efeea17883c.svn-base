//
//  OrderViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/7/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "OrderViewController.h"
#import "FoodCell.h"
#import "OrderTool.h"
#import "HttpTool.h"
#import "topRG.h"
#import "MJExtension.h"
#import "FoodMenuCell.h"
#import "tableSPG.h"
#import "SaveOrderViewController.h"
#import "SavedViewController.h"
#import "FoodMenuDetilCell.h"
#import "FoodMenuDetilCell2.h"
#import "ChangeFoodController.h"
#import "TaoCanPG.h"
#import "TaoCanUpPG.h"
#import "ZhiFuViewController.h"
#import "UsedViewController.h"
#import "MainViewController.h"
#import "MJRefresh.h"
#import "XiaoFeiSuccessController.h"
#import "UIUtils.h"
#import "CaiPG.h"
#import "TimeTool.h"
#import "AddWaiMaiPG.h"
#import "BluetoothConnectionViewController.h"
#import "CustomAlertView.h"

#define topViewMargin

@interface OrderViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,SavedViewControllerDelegate,UsedViewControllerDelegate,SaveOrderViewControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate,ShiJiaDleGate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIButton *xiadanBtn;

@property (weak, nonatomic) IBOutlet UIButton *jiezhangBtn;
@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UILabel *zongjine; //总金额
@property (weak, nonatomic) IBOutlet UILabel *tableName;
@property (weak, nonatomic) IBOutlet UILabel *kaitaishijian;
@property (weak, nonatomic) IBOutlet UILabel *caozuoyuan;
@property (weak, nonatomic) IBOutlet UILabel *jiucanrenshu;
@property (weak, nonatomic) IBOutlet UILabel *dingdanhao;
@property (weak, nonatomic) IBOutlet UIView *dingdanView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dingdanHeight;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic, strong) NSMutableArray *topArr;//菜品类别

@property (nonatomic, strong) NSMutableArray *caiArr;

@property (nonatomic,strong) NSMutableArray *foodMenuArr;
@property (strong,nonatomic) NSMutableArray *foodMenuArrCopy;
@property (strong,nonatomic) NSMutableArray *foodMenuInfoArr;
@property (strong,nonatomic) NSMutableArray *foodMenuInfoArrCopy;
@property (strong,nonatomic) NSMutableArray *addFoodMenuArr;
@property (strong,nonatomic) NSMutableArray *deleteFoodMenuArr;


@property (nonatomic, assign) CGFloat sum;
@property (nonatomic, assign) BOOL dingdanHidden;
@property (nonatomic, strong) NSMutableArray *taocanArr;

@property (nonatomic, assign) NSInteger SectionsNum;

@property (nonatomic, copy) NSString *dsId;
@property (nonatomic, strong) NSMutableArray *taocanDianJiArr;
@property (nonatomic, strong) NSMutableArray *putongcanpinArr;

@property (nonatomic, strong) NSMutableDictionary *countDict;
    //接受从订单信息界面返回的数据
@property (nonatomic, copy) NSString *billID;
@property (nonatomic, copy) NSString *tabID;
@property (copy,nonatomic) NSString *orderId;
@property (copy,nonatomic) NSDictionary *dicOrder;
@property (nonatomic, strong) NSIndexPath *replaceIndex;
@property (nonatomic, strong) UIScrollView *topScrollView;

//@property (nonatomic, strong) CaiPG *caipg;
@property (nonatomic, assign) NSInteger shanchuIndex;

@property (nonatomic, strong) NSIndexPath *SChuindexPath;


@property(strong,nonatomic)XiaoFeiSuccessController *xiaofeiVc;
@property (nonatomic, strong) UIButton *selectTopViewBtn;

//
@property (weak, nonatomic) IBOutlet UIButton *shanchudingdan;
@property (weak, nonatomic) IBOutlet UIButton *baocundingdan;
@property (weak, nonatomic) IBOutlet UIButton *tuichudingdan;



//搜索框的自定义
@property (weak, nonatomic) IBOutlet UITextField *souSuoText;
//
@property (copy,nonatomic) NSString *categoryId1;
@property (weak, nonatomic) IBOutlet UIView *shangfangBigView;
@property (weak, nonatomic) IBOutlet UILabel *tableNumber; //

@property (weak, nonatomic) IBOutlet UIImageView *sousuo;

@property (weak, nonatomic) IBOutlet UITextField *customSearchBar;

@property (weak, nonatomic) IBOutlet UIView *orderListTopView;

@property(strong,nonatomic)NSMutableString *diancanforwardUrl;

@property(strong,nonatomic)NSString *diancanbillType;


@property (strong ,nonatomic) DeskState *deskState; //餐座

@property (strong,nonatomic)SaveOrderViewController *saveOrderViewController;
//WHC
@property (copy,nonatomic)NSString *billId;
@property (strong,nonatomic)NSMutableArray *dishInfoArr;
@property (copy,nonatomic)NSString *jikou;
@property (strong,nonatomic) NSIndexPath *index;
@property (strong,nonatomic)NSMutableArray *jkouArr;


@property (assign,nonatomic)BOOL isSuccess;


@property (nonatomic)BOOL needSendLastShowData;
@end

@implementation OrderViewController

SingletonM(OrderView)

- (IBAction)querenxiadan:(id)sender
{
    NSString *billID = [[NSUserDefaults standardUserDefaults] objectForKey:KBillID];

    NSString *urlstring = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/xiadan/%@?enterType=0&returnJson=json",ceshiIP,billID];

    [HttpTool POST:urlstring parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
//当才当中没有菜的时候关闭删除订单

- (IBAction)shanchudingdan:(id)sender
{
    
    [self deleteOrderWithClosedNoItems];
}

//shanchudingdan
-(void)deleteOrderWithClosedNoItems{
    [self.baocundingdan setImage:[UIImage imageNamed:@"wenjianjia"] forState:UIControlStateNormal];
    [self.tuichudingdan setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [self.shanchudingdan setImage:[UIImage imageNamed:@"shanchu-1"] forState:UIControlStateNormal];
    
    
    
    [self.baocundingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.shanchudingdan setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    [self.tuichudingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    _sum = 0;
    self.whereFromStr = @"";
    [self.foodMenuArr removeAllObjects];
    [self.putongcanpinArr removeAllObjects];
    [self.taocanDianJiArr removeAllObjects];
    self.zongjine.text = @"0";
    self.sum = 0.0;//总计金额
    [self setJieZhangBtnisEnable:NO];
    [self.tableView reloadData];
    
}

-(void)saveOrderItems{
    //点击button是照片颜色为蓝色
    [self.baocundingdan setImage:[UIImage imageNamed:@"wenjianjia-1"] forState:UIControlStateNormal];
    [self.tuichudingdan setImage:[UIImage imageNamed:@"chahao"] forState:UIControlStateNormal];
    [self.shanchudingdan setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    
    
    [self.baocundingdan setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.shanchudingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    [self.tuichudingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    // 点击保存有两个选择
    // first 出现保存订单页面
    if (self.foodMenuArr.count == 0)
    {
        NSLog(@" step into here   save View Controller ...");
        SavedViewController *savedView = [[SavedViewController alloc] init];
        //savedView.view.frame = CGRectMake(0, -22, 768, 750);
        savedView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        savedView.modalPresentationStyle = UIModalPresentationPageSheet;
        savedView.delegate = self;
        [kKeyWindow.rootViewController presentViewController:savedView animated:YES completion:nil];
        
    }
    // second 保存订单  上传菜品
    else
    {
        NSLog(@" step into here ...");
        [self wuzhuozibaocundingdan:self.foodMenuArr];
        
        //        [self jumpToSaveOrder];
    }

}
// 保存订单BUG
- (IBAction)baocundingdan:(id)sender
{
    [self saveOrderItems];
}

- (void)jumpToSaveOrder
{
    SaveOrderViewController *saveOrder = [[SaveOrderViewController alloc] init];
    saveOrder.whereCome = self.whereFromStr;
    saveOrder.delegate = self;
    saveOrder.OrderList = self.foodMenuArr;
    saveOrder.taocanList = self.taocanDianJiArr;
    saveOrder.jiKouArr = self.jkouArr;
    //saveOrder.view.backgroundColor = [UIColor greenColor];
    //saveOrder.view.frame = CGRectMake(0, 0, 20, 20);
    //saveOrder.view.alpha = 0;
    saveOrder.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    saveOrder.modalPresentationStyle = UIModalPresentationPageSheet;//UIModalPresentationCustom;//UIModalPresentationPageSheet;//UIModalPresentationCustom;//UIModalPresentationPageSheet;

    //UIViewController *vc = [[UIViewController alloc]init];
    
    //[kKeyWindow.rootViewController presentViewController:vc animated:YES completion:nil];

    //[self.view addSubview:self.saveOrderViewController.view];
    [self presentViewController:saveOrder animated:YES completion:nil];

}

//显示订单
-(void)showOrderInfo2:(NSMutableArray* )foodMenuArr
{
    
    NSString *G2RestarantName =  [[NSUserDefaults standardUserDefaults] stringForKey:KG2RestarantName];
    NSString *G2RestarantAddress = [[NSUserDefaults standardUserDefaults]stringForKey:kG2RestarantAddress];
    
    MiniPosSDKShow(0, 1, 1, "", 0);
    MiniPosSDKShow(1, 0x44, 1, "", 1);
    MiniPosSDKShow(1, 2, 3,        [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@",G2RestarantName]], 1);
    MiniPosSDKShow(2, 5, 1,        [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"菜肴名称                数量            单价            金额"]], 1);
    int row=3;
    double totals = 0;
    for (CaiPG *caipg in foodMenuArr)
    {
        int maxLen = 7;
        
        NSString *name = caipg.dishesName;
        NSMutableString *str = [NSMutableString string];
        
        if ([name length] <maxLen)
        {
            
            str = [NSMutableString stringWithString:name];
            int i = maxLen-[name length];
            while (i>0)
            {
                [str appendString:@"    "];
                i--;
            }
            
        }else
        {
            str = [NSMutableString stringWithString:[name substringToIndex:maxLen]];
        }
        
        
        int num = caipg.unitNumStr.intValue;
        double price = caipg.oriCostStr.doubleValue;
        double total = num * price;
        totals +=total;
        

        
        MiniPosSDKShow(row++, 11, 1, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@    %2d                %4.2f             %5.2f",str,num,price,total]], 1);
        
        NSLog(@"row:%d,name:%@,num:%d,price:%f,total:%f",row,name,num,price,total);
        
    }
    
    
    MiniPosSDKShow(row++, 9, 0x83,     [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"消费合计：%.2f元",totals]], 1);
    MiniPosSDKShow(row++, 10,0x83,     [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"优惠折扣：%.2f元",0.0]], 1);
    MiniPosSDKShow(row++,11,0x83,      [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"应付金额：%.2f元",totals]], 1);
    
    MiniPosSDKShow(row++, 10, 0x83, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"欢迎光临%@就餐",G2RestarantName]], 1);
//  MiniPosSDKShow(row++, 10, 0x83, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"订餐电话：010-66669999"]], 1);
    MiniPosSDKShow(row++, 10, 0x83, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"地址：%@",G2RestarantAddress]], 1);
    MiniPosSDKShow(row++, 1, 1,     [UIUtils UTF8_To_GB2312:@""], 2);
    
}


//显示订单
-(void)showOrderInfo:(NSMutableArray* )foodMenuArr
{
    
    MiniPosSDKShow(0, 1, 0, "", 0);
    MiniPosSDKShow(1, 2, 3,        [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"真功夫大兴店"]], 1);
    MiniPosSDKShow(2, 3, 0,        [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"台号：%@            人数：%@",self.deskState.tabNo,self.deskState.peopleCount]], 1);
    MiniPosSDKShow(3, 4, 0,        [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"时间：%@",self.deskState.openTableTime]], 1);
    MiniPosSDKShow(4, 5, 0,        [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"菜肴名称                    数量   单价   金额"]], 1);
    int row=5;
    double totals = 0;
    for (CaiPG *caipg in foodMenuArr)
    {
            
            NSString *name = caipg.dishesName;
            int num = caipg.unitNumStr.intValue;
            double price = caipg.oriCostStr.doubleValue;
            double total = num * price;
            totals +=total;
            MiniPosSDKShow(row++, 0, 0, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@                   %d    %.2f     %.2f",name,num,price,total]], 1);
            
            NSLog(@"row:%d,name:%@,num:%d,price:%f,total:%f",row,name,num,price,total);
        
    }
    
    
    MiniPosSDKShow(row++, 9, 3,     [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"消费合计：%.2f元",totals]], 1);
    MiniPosSDKShow(row++, 10,3,     [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"优惠折扣：0元"]], 1);
    MiniPosSDKShow(row++,11,3,      [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"应付金额：%.2f元",totals]], 1);
    
    
    MiniPosSDKShow(row++, 10, 0x83, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"欢迎光临真功夫大兴店就餐"]], 1);
    MiniPosSDKShow(row++, 10, 0x83, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"订餐电话：010-66669999"]], 1);
    MiniPosSDKShow(row++, 10, 0x83, [UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"地址：北京市大兴区xx号"]], 1);
    MiniPosSDKShow(row++, 1, 0,     [UIUtils UTF8_To_GB2312:@""], 2);
    
}

//打印订单
-(void)printOrderInfo:(NSMutableArray*)foodMenuArr
{
    //MiniPosSDKGetG2DeviceInfo("\x01");
    //return;
    NSString *G2RestarantName =  [[NSUserDefaults standardUserDefaults] stringForKey:KG2RestarantName];
    NSString *G2RestarantAddress = [[NSUserDefaults standardUserDefaults]stringForKey:kG2RestarantAddress];
    
    
    NSString *time = [UIUtils stringFromDate:[NSDate date] formate:@"yyyy/MM/dd"];
    
    
    MiniPosSDKPrinter(1,10,"",0);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"      %@",G2RestarantName]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"台号:%@           人数:%@",self.deskState.tabNo,self.deskState.peopleCount]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"单号:%@ 收银员:01",self.deskState.billNo]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"时间:%@",self.deskState.openTableTime]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"菜肴名称  数量  单价  金额"]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
    double totals = 0;
    for (CaiPG *caipg in foodMenuArr)
    {
        
        NSString *name = caipg.dishesName;
        NSMutableString *str = [NSMutableString string];
   
        if ([name length] <5)
        {
            
            str = [NSMutableString stringWithString:name];
            int i = 5-[name length];
            while (i>0)
            {
                [str appendString:@"  "];
                i--;
            }
            
        }else
        {
            str = [NSMutableString stringWithString:[name substringToIndex:5]];
        }
        
        
        int num = caipg.unitNumStr.intValue;
        double price = caipg.oriCostStr.doubleValue;
        double total = num * price;
        totals +=total;

        MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"%@%2d  %4.2f %4.2f",str,num,price,total]],1);
        
    }
    
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"消费合计:%6.2f元",totals]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"优惠折扣:%6.2f元",0.0]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"应付金额:%6.2f元",totals]],1);
    MiniPosSDKPrinter(3,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"---------------------------------------------"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"欢迎再次光临%@",G2RestarantName]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"定餐电话:010-66669999"]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"地址:%@",G2RestarantAddress]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"技术支持By腾势股份  "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:[NSString stringWithFormat:@"                      "]],1);
    MiniPosSDKPrinter(2,5,[UIUtils UTF8_To_GB2312:@""],2);
    return;
    //MiniPosSDKPrinter(0,50,[UIUtils UTF8_To_GB2312:@"终端号       10700027"],2);

}

-(void)payCash{
    //没有餐桌 是走外卖接口 填写  默认值
    if (!self.tabID)
    {
        
        [self takeoutOrder];
        
       // [self jumpToSaveOrder];
        
    }
    else
    {
        
        NSLog(@"self.billId%@",self.billID);
       //有桌台
        if (self.billID == nil)
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请下单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
        NSLog(@"%@",self.deskState.tabNo);
        NSLog(@"%@",self.deskState.peopleCount);
        NSLog(@"%@",self.deskState.openTableTime);
        
        
        NSMutableArray *arr = [NSMutableArray array];
        
        for (CaiPG *caipg in self.foodMenuArr)
        {
            if (!caipg.isTaoCanCaiPin)
            {
                
                [arr addObject:caipg];
            }
        }
        NSLog(@" tableID:%@",self.tabID);
        ZhiFuViewController *zhifuVc = [[ZhiFuViewController alloc] init];
        
        ZhiFuChuanDiPG *chuandiPg = [[ZhiFuChuanDiPG alloc] init];
        
        
        chuandiPg.billID = self.billID;
        chuandiPg.whereFrom = @"正常消费";
        chuandiPg.tabID = self.tabID;
        chuandiPg.count = self.zongjine.text;
        zhifuVc.chuandiPG = chuandiPg;
        
        NSLog(@"----------%@",self.zongjine.text);
        NSLog(@"----------%@",zhifuVc.chuandiPG.count);
        
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:zhifuVc];
        navController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
        
        [kKeyWindow.rootViewController presentViewController:navController animated:YES completion:nil];
    }
 
}
//结账
- (IBAction)jiezhang:(id)sender
{
    [self payCash];
}


-(void)takeoutOrder
{
    
   
    
    AddWaiMaiPG *waimaiPG = [[AddWaiMaiPG alloc] init];
    waimaiPG.ccdId = @"";
    waimaiPG.sendAtOnce = @"1";
    waimaiPG.sendAddress = @"自取";
    waimaiPG.contactName = @"外带";
    waimaiPG.invoiceTitle = @"否";
    
    NSLog(@"%@",waimaiPG.mj_keyValues);
    
    NSLog(@"%@",self.foodMenuArr.mj_keyValues);
     NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/takeout/saveTakeout",ceshiIP];
    [HttpTool POST:urlStr parameters:waimaiPG.mj_keyValues success:^(id responseObject) {
        NSLog(@"takeout responseObject %@",responseObject);
        NSString *dishNum = @"";
        
        for (int i = 0; i < self.foodMenuArr.count; ++i)
        {
            CaiPG *caipg = self.foodMenuArr[i];
            if (dishNum.length == 0) {
                dishNum = caipg.unitNumStr;
            }else{
                
                dishNum = [NSString stringWithFormat:@"%@,%@",dishNum,caipg.unitNumStr];
            }
        }
        
        NSString *dishID = @"";
        for (int i = 0; i < self.foodMenuArr.count; ++i)
        {
            CaiPG *caipg = self.foodMenuArr[i];
            if (dishID.length == 0) {
                dishID = caipg.dishesId;
            }else{
                
                dishID = [NSString stringWithFormat:@"%@,%@",dishID,caipg.dishesId];
            }
        }
        
        NSString *tId = responseObject[@"value"];
        NSLog(@"%@",tId);
        NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/jiacai/2/%@?unitNumStr=%@&tId=%@",ceshiIP,dishID,dishNum,tId];
        NSLog(@"%@",urlStr);
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
            
                   NSLog(@"takeout    %@",responseObject);
            NSString *billId = [responseObject objectForKey:@"billId"];
           
            self.deskState = [[DeskState alloc]init];
            //self.deskState.billNo = [NSString stringWithFormat:@"%@",[note.userInfo objectForKey:@"billNo"]];
            self.deskState.billNo = [NSString stringWithString:[responseObject objectForKey:@"forwardUrl"]];
            self.deskState.tabNo = @"外带";
            self.deskState.peopleCount = @"0";
            self.deskState.openTableTime = [TimeTool getCurrentDateStr:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld"];

           ZhiFuViewController* zhiFuViewController = [[ZhiFuViewController alloc]init];
            
            UINavigationController *navigationC = [[UINavigationController alloc]initWithRootViewController:zhiFuViewController];
            navigationC.modalPresentationStyle = UIModalPresentationPageSheet;
            ZhiFuChuanDiPG *chuandipg = [[ZhiFuChuanDiPG alloc] init];
            chuandipg.count = [NSString stringWithFormat:@"%.2f",self.sum];
            chuandipg.billID = [NSString stringWithString:billId];
            chuandipg.whereFrom = kWaiMaiJieZhangFromStr;
            self.isSuccess = YES;
            zhiFuViewController.chuandiPG = chuandipg;
            
            [self presentViewController:navigationC animated:YES completion:nil];
            
            
        } failure:^(NSError *error) {
            //                    [self showAlertViewWithMessage:@"下单失败"];
            //                    [self.hud hide:YES];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加外卖失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
        }];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



-(void)didOrderItems{
    if ([self.whereFromStr isEqualToString:@"emptyused"]) {
        
      
        self.xiadanBtn.userInteractionEnabled = NO;
        self.xiadanBtn.backgroundColor = [UIColor lightGrayColor];
        [self uploadEmptyDeskBill];
        self.xiadanBtn.userInteractionEnabled = YES;
        self.xiadanBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1];
       
        
      
        return;
        
    }
    
    // end of line
    
    // add by manman for start of line
    // 删除菜品
    
    //`[self VerifyWhetherTheBillChanges];
    
    if (self.billID != nil)
    {
        
        
        if (self.deleteFoodMenuArr.count >0)
        {
            
            NSMutableString *bdidStr = [NSMutableString string];
            for (CaiPG *tmpDish in self.deleteFoodMenuArr)
            {
                [bdidStr appendString:tmpDish.bdId];
                [bdidStr appendString:@","];
                NSLog(@"delete dishname:%@ bdid:%@",tmpDish.dishesName,tmpDish.bdId);
            }
            
            NSRange range =  [bdidStr rangeOfString:@"," options:NSBackwardsSearch];
            NSString *bdidStrS = [bdidStr stringByReplacingCharactersInRange:range withString:@""];
            NSString *deleteUrl = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/dishDeletes/%@/%@?isSet=0&returnJson=json",ceshiIP,self.billID,bdidStrS];
            NSLog(@"deleteUrl:%@",deleteUrl);
            [HttpTool GET:deleteUrl parameters:nil success:^(id responseObject) {
                NSLog(@"delete dishMenu response:%@",responseObject);
                // NSString *responseMessage = [responseObject objectForKey:@"message"];
                NSString *statusCode = [responseObject objectForKey:@"statusCode"];
                if (statusCode.integerValue == 200) {
                    [self showAlertViewMessage:@"修改菜单成功"];
                    
                    
                    [self xiadanqingtai];
                    
                }
                
                
            } failure:^(NSError *error) {
                NSLog(@" delete dishMenu error :%@",error.localizedDescription);
            }];
            
            [self clearBillChangeRecordList];
            return;
            
        }
    }
    
    // end of line
    // 王洪昌    bug 1123 2015 11 25
    if ([self.whereFromStr isEqualToString:@"yuding"])
    {
        
        if (self.foodMenuArr.count==0)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先点餐" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            return;
            
        }
        else
        {
            
            NSRange range = [self.tableNumber.text rangeOfString:@"餐台"];
            
            
            NSString *tabNoS = [self.tableNumber.text stringByReplacingOccurrencesOfString:@"餐台" withString:@""];
            
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:tabNoS,@"table.tabNo",self.tabID,@"table.tabId",tabNoS,@"tableNo",self.orderId,@"orderId", nil];
            NSString *str1 = self.dicOrder[@"tableNo"];
            NSString *str2 = self.dicOrder[@"orderId"];
            NSString *str3 = self.dicOrder[@"table.tabNo"];
            NSString *str4 = self.dicOrder[@"table.tabId"];
            NSLog(@"self.dicOrder Info ?:%@",self.dicOrder.mj_keyValues);
            NSString *tableUrlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/kaitai/create?tableNo=%@&orderId=%@&table.tabNo=%@&table.tabId=%@",ceshiIP,str1,str2,str3,str4];
            NSLog(@"yuding order  dic %@",self.dicOrder.mj_keyValues);
            self.deskState = [[DeskState alloc]init];
            self.deskState.tabNo = [NSString stringWithString:str1];
            [HttpTool GET:tableUrlStr parameters:nil success:^(id responseObject) {
                
                NSLog(@"yuding order responseObject:%@",responseObject);
                
                if ([[responseObject objectForKey:@"message"] isEqualToString:@"1"])
                {
                    
                    self.diancanforwardUrl = [responseObject objectForKey:@"forwardUrl"];
                    
                    [self getInfo];
                    //                [self xiadanqingtai];
                    
                
                }
                else if ([[responseObject objectForKey:@"message"] isEqualToString:@"2"]){
                    [self showAlertViewMessage:@"开台失败，无此餐台"];
                }
                else if ([[responseObject objectForKey:@"message"] isEqualToString:@"6"]){
                    [self showAlertViewMessage:@"开台失败，此餐台已被预订锁定。"];
                }
                else if ([[responseObject objectForKey:@"message"] isEqualToString:@"7"]){
                    [self showAlertViewMessage:@"开台失败，此餐台状态非空闲"];
                }
                else
                {
                   [self showAlertViewMessage:@"下单失败"]; 
                }
            } failure:^(NSError *error) {
                [self showAlertViewMessage:@"下单失败"];
            }];
            return;
        }
    }
    
    if ([self.whereFromStr isEqualToString:@"used"])
    {
        
        //直接下订单
        NSMutableArray *redArr = [NSMutableArray array];
        for (CaiPG *cai in self.foodMenuArr)
        {
            if ([cai.isRed isEqualToString:@"1"])
            {
                [redArr addObject:cai];
            }
        }
        //[self showOrderInfo:redArr];
        //[self printOrderInfo:redArr];
        [self shangchuanXinZengCaiPinWith:redArr];
    }
    //添加判断如果没用点餐不能点击下单
    else if (self.foodMenuArr.count==0)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请先点餐" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }
    else
    {
        [self jumpToSaveOrder];
        //  [self xiadanqingtai];
        
    }

}

//下单
- (IBAction)xiadanChick:(id)sender
{

    [self didOrderItems];
    
    
}

-(void)VerifyWhetherTheBillChanges
{

    if(self.billID)
    {
        // 查找 新增菜品
        //现在 菜单中存在的【菜品】
//        for (CaiPG *baseCaiPin in self.foodMenuArr)
//        {
//            
//            for (NSDictionary *tmpDic in  self.foodMenuInfoArr)
//            {
//                if ([baseCaiPin.dishesName isEqualToString:[tmpDic objectForKey:@"dishesName"]])
//                {
//                    //菜单中存在的菜品
//                    break;
//                }
// 
//            }
//            
//            [self.addFoodMenuArr addObject:baseCaiPin];//没有找到的既是新添加的
//        }
        
        // 查找 删除菜品
        for (NSDictionary *tmpDic in self.foodMenuInfoArr)
        {
            BOOL flag = NO;
            for (CaiPG *caipin in self.foodMenuArr)
            {
                
                if ([caipin.dishesName isEqualToString:[tmpDic objectForKey:@"dishesName"]])
                {
                    flag = YES;break;
                }

            }
            if (!flag) [self.deleteFoodMenuArr addObject:tmpDic];
            
        }

    }

}

//外卖成功预定后删除订单
-(void)Wmshanchudingdan:(NSNotification *)note
{
    NSLog(@"billNo:%@",[note.userInfo objectForKey:@"billNo"]);
    NSLog(@"billNo:%@",self.deskState.mj_keyValues);
    self.deskState = [[DeskState alloc]init];
    self.deskState.billNo = [NSString stringWithFormat:@"%@",[note.userInfo objectForKey:@"billNo"]];
    self.deskState.tabNo = @"外卖";
    self.deskState.peopleCount = @"0";
    self.deskState.openTableTime = [TimeTool getCurrentDateStr:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld"];
    [self printOrderInfo:self.foodMenuArr];
    
    [self tuichudingdanChick:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:KWaiMaiXiaDan object:nil];

}
- (IBAction)tuichudingdanChick:(id)sender
{
    
    [self.baocundingdan setImage:[UIImage imageNamed:@"wenjianjia"] forState:UIControlStateNormal];
    [self.tuichudingdan setImage:[UIImage imageNamed:@"chahao-1"] forState:UIControlStateNormal];
    [self.shanchudingdan setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    
    
    
    [self.tuichudingdan setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    [self.baocundingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    [self.shanchudingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];

    self.tableNumber.text=@"";
    self.tabID = nil;
    self.billID = nil;
    _sum = 0;
    self.whereFromStr = @"";
    [self.foodMenuArr removeAllObjects];
    [self.putongcanpinArr removeAllObjects];
    [self.taocanDianJiArr removeAllObjects];
    self.zongjine.text = @"0";
    [self setJieZhangBtnisEnable:NO];
    [self.tableView reloadData];
    

}


//下单清台wjy
-(void)xiadanqingtai
{
    
    NSLog(@"reset clear ...");
    self.tableNumber.text=@"";
    self.tabID = nil;
    self.billID = nil;
    
    _sum = 0;
    self.whereFromStr = @"";
    [self.foodMenuArr removeAllObjects];
    [self.putongcanpinArr removeAllObjects];
    [self.taocanDianJiArr removeAllObjects];
    self.zongjine.text = @"";
    [self setJieZhangBtnisEnable:NO];
    [self.tableView reloadData];
   

}


-(void)clearBillChangeRecordList
{
    NSLog(@"into  clearBillChangeRecordList");
    if (self.deleteFoodMenuArr.count>0)
    {
        [self.deleteFoodMenuArr removeAllObjects];
        
    }
    if (self.addFoodMenuArr.count >0 )[self.addFoodMenuArr removeAllObjects];
    
    if (self.foodMenuInfoArr.count >0)
    {
        [self.foodMenuInfoArr removeAllObjects];
        
    }
    if (self.foodMenuInfoArrCopy.count >0)
    {
        [self.foodMenuInfoArrCopy removeAllObjects];
        
    }
    
    
}


- (IBAction)chetai:(id)sender
{
    
    
    NSString *billID = [[NSUserDefaults standardUserDefaults] objectForKey:KBillID];
    NSString *tabId = self.ST.tabId;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:billID forKey:@"id"];
    [dict setObject:tabId forKey:@"table.tabId"];
    [dict setObject:@"111" forKey:@"cancelReasonId"];


    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/pop/chedan/update",ceshiIP];
    [HttpTool GET:urlString parameters:dict success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // 搜索时间
    [self caiPinsousuo];
    
    self.isSuccess = NO;
    
//   //餐台没有菜的时候结账按钮不能被点击  王京阳
//    if (self.foodMenuArr)
//    {
//        //结账按钮不能被点击
//        self.jiezhangBtn.userInteractionEnabled=NO;
//        //退出订单按钮不能点击
//        self.tuichudingdan.userInteractionEnabled=NO;
//        
//    }
//    else
//    {
//        //结账按钮能被点击
//        self.jiezhangBtn.userInteractionEnabled=YES;
//        //保存订单能被点击
//        self.baocundingdan.userInteractionEnabled=YES;
//        //删除订单能被点击
//        self.shanchudingdan.userInteractionEnabled=YES;
//        
//    }

    
    
    //接受保存订单按钮被点击时删除和退订按钮可以点击
   // [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shanchuAndtuichu) name:Kanniudianji object:nil];
    
    
    //退出订单按钮
    //self.tuichudingdan.userInteractionEnabled=NO;
   // self.shanchudingdan.userInteractionEnabled=NO;
    
    
        // Do any additional setup after loading the view from its nib.
   // [[NSNotificationCenter defaultCenter]removeObserver:self name:KxianjinxiaofeiSuccess object:nil];
    
    //三个按钮初始颜色
    [self.baocundingdan setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState: UIControlStateNormal];
    [self.tuichudingdan setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState: UIControlStateNormal];
    [self.shanchudingdan setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState: UIControlStateNormal];

    //外卖订单成功后删除订单  王京阳
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Wmshanchudingdan:) name:KWaiMaiXiaDan object:nil];
    
    
    //消费成功的代理
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(xianjinXiaofeiSuccessWith) name:KxianjinxiaofeiSuccess object:nil];

    //modify start
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(extraMealInfo:) name:@"extraMeal" object:nil];
    
    //Reser界面传递的zhi
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReaerToOrder1:) name:@"ReaerToOrder" object:nil];
    
    
    
    
    self.tableNumber.textColor = [UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1];
   
    
    //end of line
    
    self.customSearchBar.layer.borderColor = [[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1]CGColor];
    self.customSearchBar.layer.borderWidth = 1;
    
    
    // [btn setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateSelected];
    self.orderListTopView.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
    self.xiadanBtn.layer.cornerRadius = 4;
    self.jiezhangBtn.layer.cornerRadius = 4;
    
    self.xiadanBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
    self.jiezhangBtn.backgroundColor = [UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ];
    
    
//    self.whereFromStr = @"";
    self.canReplace = YES;
    self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kBottomHeight);
    [self setJieZhangBtnisEnable:NO];
    
    [self SetUpCollectView];
    //手动调用点击订单按钮 让订单详情的部分隐藏
    
//    /**
//     *  给foodMenuArr添加数据源来判断结账按钮是否能被点击
//     */
//        //                [self.foodMenuArr addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew context:nil];
//    [self addObserver:self forKeyPath:@"foodMenuArr" options:NSKeyValueObservingOptionNew context:nil];
    
    [self dingdan:nil];
    [self RequestTopView];
    self.SectionsNum = 1;
    
//    [self RequestTableStates];

   

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.foodMenuInfoArr = [NSMutableArray array];
    self.foodMenuInfoArrCopy = [NSMutableArray array];
    
    
}

//通知代理方法
-(void)shanchuAndtuichu

{

    self.shanchudingdan.userInteractionEnabled=YES;
   // self.shanchudingdan.backgroundColor=[UIColor greenColor];
    [self.shanchudingdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.tuichudingdan.userInteractionEnabled=YES;
    //self.tuichudingdan.backgroundColor=[UIColor greenColor];
    [self.tuichudingdan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //删除通知
    //  [[NSNotificationCenter defaultCenter]removeObserver:self name:Kanniudianji object:nil];
}

#pragma  mark 通知
//Reser界面传递
-(void)ReaerToOrder1 :(NSNotification *)noti
{

    self.dicOrder = [noti userInfo];
    self.tableNumber.text = [NSString stringWithFormat:@"%@餐台",self.dicOrder[@"tableNo"]];
    if (self.dicOrder[@"peopleCount"] != nil) {
           self.deskState.peopleCount = [NSString stringWithString:self.dicOrder[@"peopleCount"]];
    }
 
    [self.foodMenuArr removeAllObjects];
    [self.tableView reloadData];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ReaerToOrder" object:nil];
}

-(void)Caitai :(NSNotification *)noti
{
    NSDictionary *dic = [noti userInfo];
    
    NSString *str = [NSString stringWithFormat:@"%@餐台",dic[@"tabNo"]];
    self.tabID = noti.userInfo[@"tabId"];
    self.orderId = noti.userInfo[@"orderId"];
    self.tableNumber.text = str;
    [self.foodMenuArr removeAllObjects];
    [self.tableView reloadData];



}
- (void)SetUpCollectView
{
    
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.allowsMultipleSelection = NO;
    self.collectView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refrishCollectionView)];


}

- (void)refrishCollectionView
{
    
    if (self.selectTopViewBtn) {
        
    }
    
    if (self.selectTopViewBtn.tag - 10 >= (self.topArr.count - self.taocanArr.count))
    {
        
//        [self taoCanBtnChick:self.selectTopViewBtn];
        [self taoCanBtnChickS:self.selectTopViewBtn];
    }
    else
    {
//        [self topButtonChick:self.selectTopViewBtn];
        [self topButtonChickS:self.selectTopViewBtn];
        
    }
    
}

-(void)SwipingCardConsumeSuccess{
    [self xiadanqingtai];
}


- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SwipingCardConsumeSuccess) name:kSwipingCardConsumeSuccess object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(print) name:kPrintOrder object:nil];
    
    
    self.jkouArr = [NSMutableArray arrayWithCapacity:100];
    [super viewWillAppear:animated] ;
    
        //判断是否删除了全部
    if (self.foodMenuArr.count == 0)
    {
        [self setJieZhangBtnisEnable:NO];
    }
    else
    {
        
        [self setJieZhangBtnisEnable:YES];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Caitai:) name:Kquxiaoyudingbutton object:nil];
    if (self.foodMenuInfoArr == nil)
    {
        [self.foodMenuInfoArr removeAllObjects];
        
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.foodMenuArrCopy = [NSMutableArray array];
    self.deleteFoodMenuArr = [NSMutableArray array];

    // add by manman for start of line
    // 页面消失的时候  清空  菜品 变化 记录
    
    [self clearBillChangeRecordList];
    
    // end of line
     //MiniPosSDKRemoveDelegate((__bridge void*)self);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    
    BOOL isNewDevice = [[NSUserDefaults standardUserDefaults]boolForKey:kMposG2IsNewDevice];
    //isNewDevice = true;
    if (isNewDevice) {
        [self activateG2];
    }
    
}

- (void)setJieZhangBtnisEnable:(BOOL)enable
{
    
    if (enable)
    {
        
        self.jiezhangBtn.userInteractionEnabled = YES;
        self.jiezhangBtn.backgroundColor = [UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];
    }
    else
    {

        self.jiezhangBtn.userInteractionEnabled = NO;
        self.jiezhangBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

- (void)RequestTopView
{
    
    NSLog(@"into here  RequestTopView ");
    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=&returnJson=json",ceshiIP];
    NSLog(@"into here  RequestTopView  URL: %@",urlString);
    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {

        NSLog(@"into here  RequestTopView  response  ");
        NSLog(@"***%@",responseObject);
        _topArr = [responseObject objectForKey:@"dishesCategorys"];
        _topArr = [topRG objectArrayWithKeyValuesArray:self.topArr];
        NSString *quanbu = [responseObject objectForKey:@"firstCategoryName"];
        //NSLog(@"test %@",quanbu);
        
        //全部菜品 类别
        topRG *t1 = [[topRG alloc] init];
        t1.categoryName = quanbu;
        t1.categoryId = @"";
        [self.topArr insertObject:t1 atIndex:0];
      
        
        NSMutableArray *arr = [responseObject objectForKey:@"dishesSetCategorys"];
        self.taocanArr = arr;
        for (int i = 0; i < arr.count; ++i)
        {
            NSDictionary *dic = arr[i];
            
            topRG *t2 = [[topRG alloc] init];
            t2.categoryName = [dic objectForKey:@"categoryName"];
            t2.categoryId = [dic objectForKey:@"dsCategoryId"];
            [self.topArr addObject:t2];
        }
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 0;
//        _selectTopViewBtn = btn;

        if (_topArr.count==0) return ;
        [self topButtonChick:btn];
        [self setUpTopViewWithCount:_topArr.count];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//- (void)RequestTableStates{
//    NSString *tableName = [[NSUserDefaults standardUserDefaults] objectForKey:KTableName];
//    NSString *billID = [[NSUserDefaults standardUserDefaults] objectForKey:KBillID];
//    
//    self.tableName.text = tableName;
//
//    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?returnJson=json&billId=%@&billType=1",ceshiIP,billID];
//    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {
//        NSDictionary *dict = [responseObject objectForKey:@"newBill"];
//        tableSPG *spg = [tableSPG objectWithKeyValues:dict];
//        self.kaitaishijian.text = spg.billTime;
//        self.jiucanrenshu.text = spg.peopleNum;
//        self.dingdanhao.text = spg.billNo;
//        self.caozuoyuan.text = spg.salesmanId;
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
//}

#define PNZITI    [UIColor colorWithRed:85.0 / 255.0 green:90.0 / 255.0 blue:96.0 / 255.0 alpha:1.0f]

- (void)setUpTopViewWithCount:(NSInteger)count
{
    
    
    
    CGFloat btnx;
    CGFloat btnY;
    CGFloat btnW = 80;
    CGFloat btnH;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.topView.bounds];
    self.topScrollView = scrollView;
    [self.topView addSubview:scrollView];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(btnW * count, self.topView.height);
    
    CGRect btnFrame = CGRectMake(0,0, 50, 40);
    for (int i = 0; i < count; ++i)
    {
        UIButton *btn = [[UIButton alloc] init];
//        btnW = self.topView.width / count;
        btnH = self.topView.height -2 ;
        btnx = i * btnW;
        btnY = 6;
        btn.frame = CGRectMake(btnx, btnY, btnW
                               + 50, btnH);
        topRG *topPg = self.topArr[i];
        
        
        //start of line
        
       UIButton *TmpButton = [self createUIButtonAutoLayoutSizeWithTitle:topPg.categoryName AndOriginalFramePosition:btnFrame];
        btnFrame = TmpButton.frame;
        btnFrame.origin.x += TmpButton.size.width;
        TmpButton.tag = i+10;
//        if (i == 0)
//        {
//            TmpButton.selected = YES;
//            self.selectBtn = TmpButton;
//            self.selectTopViewBtn = TmpButton;
//        }
        
        if (i >= (count - self.taocanArr.count))
        {
            
            [TmpButton addTarget:self action:@selector(taoCanBtnChickS:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            
            [TmpButton addTarget:self action:@selector(topButtonChickS:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [self.topScrollView addSubview:TmpButton];
        
        
        //end of line
        
        /*
        btn.tag = i;
        if (i == 0) {
            btn.selected = YES;
            self.selectBtn = btn;
            self.selectTopViewBtn = btn;
        }
        [btn setTitleColor:PNZITI forState:UIControlStateNormal];
        [btn setFont:[UIFont systemFontOfSize:18]];
        [btn setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateSelected];

        [btn setBackgroundImage:[UIImage imageNamed:@"dck"] forState:UIControlStateSelected];

        btn.clipsToBounds = YES;
        btn.contentMode = UIViewContentModeScaleAspectFill;
        
        [btn setTitle:topPg.categoryName forState:UIControlStateNormal];
        if (i >= (count - self.taocanArr.count)) {
            
            [btn addTarget:self action:@selector(taoCanBtnChick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            
            [btn addTarget:self action:@selector(topButtonChick:) forControlEvents:UIControlEventTouchUpInside];
        }

        [self.topScrollView addSubview:btn];
        */
    }
    
    UIButton *wholeButton = (UIButton *)[self.view viewWithTag:10];
    [self topButtonChickS:wholeButton];
    
    
    
}
//topView Button布局 设置


// button 按钮标题的自适应大小  设置button按钮的大小
-(UIButton *)createUIButtonAutoLayoutSizeWithTitle:(NSString *)titleStr AndOriginalFramePosition:(CGRect) btnFrame
{
//    NSLog(@"frame:x:%f y:%f w:%f h:%f",btnFrame.origin.x,btnFrame.origin.y,btnFrame.size.width,btnFrame.size.height);
    //NSString *str = @"这是按钮的标题";
    //NSString *str = @"标题";
    //创建一个指定的类型的button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置button标题的字体
    //btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [btn setTitleColor:[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] forState:UIControlStateSelected];
    //[btn setTitleColor:[UIColor redColor]   forState:UIControlStateSelected];
    
    
    //对按钮的外形做了设定，不喜可删~
    //btn.layer.masksToBounds = YES;
    //btn.layer.borderWidth = 1;
    //btn.layer.borderColor = [[UIColor blackColor] CGColor];
    // btn.layer.cornerRadius = 3;
    
    //******
    
    [btn setTitleColor:PNZITI forState:UIControlStateNormal];
    //[btn setFont:[UIFont systemFontOfSize:18]];
    //[btn setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateSelected];
   // [btn setBackgroundImage:[UIImage imageNamed:@"dck"] forState:UIControlStateSelected];
    btn.clipsToBounds = YES;
    //btn.contentMode = UIViewContentModeScaleAspectFill;
    
    
    //*****
    
    //设置标题的颜色 状态
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:titleStr forState:UIControlStateNormal];
    
    //重要的是下面这部分哦！
    //获得标题的字体样式和大小 即标题的大小的属性
    CGSize titleSize = [titleStr sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:btn.titleLabel.font.fontName size:btn.titleLabel.font.pointSize]}];
    
//    NSLog(@"titleSize:w:%f,h:%f",titleSize.width,titleSize.height);
//    
//    NSLog(@"titleStr:%@",titleStr);
    //标题的高度不变 宽度变化
    titleSize.height = 30;
    //titleSize.width += 20;
    
    btn.frame = CGRectMake(btnFrame.origin.x +10 ,btnFrame.origin.y, titleSize.width +20,titleSize.height);
    
   
    
    //[self.topScrollView  addSubview:btn];
    return btn;
  
}

- (void)topButtonChickS:(UIButton *)sender
{
    
    self.selectTopViewBtn = sender;
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.selectBtn.selected = YES;
    topRG *topPg = self.topArr[sender.tag - 10];
    self.categoryId1 = topPg.categoryId;
    //王洪昌 搜索  2015 11 24
    if (self.souSuoText.text.length)
    {
        for (UIView *view in self.topScrollView.subviews)
        {
            //        if ([view isKindOfClass:[UIButton class]]) {
            //        NSLog(@"%@",view);
            view.layer.borderWidth = 0;
            //view.layer.borderColor = [[UIColor redColor] CGColor];
            //        }
        }
        sender.layer.masksToBounds = YES;
        sender.layer.borderWidth = 1;
        sender.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
        [self requstCai];
    }
    else
    {
    
        for (UIView *view in self.topScrollView.subviews)
        {
            //        if ([view isKindOfClass:[UIButton class]]) {
            //        NSLog(@"%@",view);
            view.layer.borderWidth = 0;
            //view.layer.borderColor = [[UIColor redColor] CGColor];
            //        }
        }
        sender.layer.masksToBounds = YES;
        sender.layer.borderWidth = 1;
        sender.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
        
      
        [OrderTool GETNormal:topPg.categoryId parameters:nil success:^(NSArray *responseObject) {
            self.caiArr = responseObject;
            
            [self.collectView reloadData];
            [self.collectView.header endRefreshing];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            
        }];

    }
    
//    for (int i = 0; i<self.topArr.count; i++) {
//        UIButton *temp = (UIButton *) [self.view viewWithTag:i];
//        //sender.layer.masksToBounds = YES;
//        temp.layer.borderWidth = 0;
//        
//    }
}





- (void)taoCanBtnChickS:(UIButton *)sender
{
    
    self.selectTopViewBtn = sender;
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.selectBtn.selected = YES;
    

    
    for (UIView *view in self.topScrollView.subviews)
    {
        //        if ([view isKindOfClass:[UIButton class]]) {
        view.layer.borderWidth = 0;
        //view.layer.borderColor = [[UIColor redColor] CGColor];
        //        }
    }
    
//    sender.layer.masksToBounds = YES;
//    sender.layer.borderWidth = 1;
//    sender.layer.borderColor = [[UIColor blackColor] CGColor];
    
    sender.layer.masksToBounds = YES;
    sender.layer.borderWidth = 1;
    sender.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1] CGColor];
    
    
    topRG *topPg = self.topArr[sender.tag];
    [OrderTool GETTaoCan:topPg.categoryId parameters:nil success:^(id responseObject) {
        self.caiArr = responseObject;
        
        [self.collectView reloadData];
        [self.collectView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)topButtonChick:(UIButton *)sender
{
    
    self.selectTopViewBtn = sender;
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.selectBtn.selected = YES;
    

    topRG *topPg = self.topArr[sender.tag];
    self.categoryId1 = topPg.categoryId;
    [OrderTool GETNormal:topPg.categoryId parameters:nil success:^(NSArray *responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        self.caiArr = responseObject;
       
        
        [self.collectView reloadData];
        [self.collectView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"get dish info %@",error.localizedDescription);
        
    }];
}




- (void)taoCanBtnChick:(UIButton *)sender
{
    
    self.selectTopViewBtn = sender;
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.selectBtn.selected = YES;
    
    topRG *topPg = self.topArr[sender.tag];
    [OrderTool GETTaoCan:topPg.categoryId parameters:nil success:^(id responseObject) {
        self.caiArr = responseObject;
        
        [self.collectView reloadData];
        [self.collectView.header endRefreshing];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (IBAction)dingdan:(id)sender
{
    
    if (!self.dingdanHidden)
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.dingdanHeight.constant = 0;
         
            self.dingdanHidden = YES;
            [self.view layoutIfNeeded];
        }];
    }
    else
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.dingdanHeight.constant = 44;
            self.dingdanHidden = NO;
            [self.view layoutIfNeeded];
        }];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getTaoCanInfoWithDishID:(CaiPG *)caipg taocanID:(NSString *)taocanID
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/pop/addDishesSet?billId=&dsId=%@&type=addSet&returnJson=json",ceshiIP,caipg.dishesId];
//    NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"dishesSet"];
        self.dsId = [dict objectForKey:@"dsId"];
        NSMutableArray *arr = [dict objectForKey:@"dishesSetDishes"];
//        NSLog(@"%@",arr);

        arr = [CaiPG objectArrayWithKeyValuesArray:arr];
        
            //添加识别套餐的表示
        for (CaiPG *cai in arr)
        {
            cai.isTaoCanCaiPin = @"1";
            cai.taocanID = taocanID;
        }
        
        [self.countDict setObject:[NSString stringWithFormat:@"%ld",arr.count] forKey:caipg.dishesId];

        NSMutableArray *taocanUpArr = [NSMutableArray array];
        for (int i = 0; i < arr.count; ++i)
        {
            CaiPG *cpg = arr[i];
            TaoCanUpPG *taocanup = [[TaoCanUpPG alloc] init];
            taocanup.dsDishesId = cpg.dsDishesId;
            taocanup.dishesId = cpg.dishesId;
            taocanup.dishesName = cpg.dishesName;
            taocanup.unitNum = cpg.unitNum;
            taocanup.unitName = cpg.unitName;
            taocanup.dishesCode = cpg.dishesCode;
            taocanup.mr_dishesId = cpg.dishesId;
            taocanup.mr_dishesName = cpg.dishesName;
            taocanup.mr_unitNum = cpg.unitNum;
            taocanup.mr_unitName = cpg.unitName;
            taocanup.mr_dishesCode = cpg.dishesCode;
//            NSLog(@"%@",taocanup);
            [taocanUpArr addObject:taocanup];
        }
   
        TaoCanPG *taocanPg = [[TaoCanPG alloc] init];
        taocanPg.dishID = caipg.dishesId;
        taocanPg.caipinArr = taocanUpArr;
        [self.taocanDianJiArr addObject:taocanPg];
//        NSLog(@"%@",self.taocanDianJiArr);
//        NSLog(@"%@",arr);
        
        [self.foodMenuArr addObjectsFromArray:arr];
        [self.tableView reloadData];

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setReplaceInfo:(replacePG *)replaceInfo
{
    
    _replaceInfo = replaceInfo;
    CaiPG *selectCaipg = self.foodMenuArr[self.replaceIndex.row];
//    NSLog(@"*****%@",c.dishesName);
//    NSLog(@"__%@____%ld",replaceInfo.dishesName,self.replaceIndex.row);
    [self.foodMenuArr removeObjectAtIndex:self.replaceIndex.row];
    [self.tableView deleteRowsAtIndexPaths:@[self.replaceIndex] withRowAnimation:UITableViewRowAnimationLeft];
    CaiPG *cai = [[CaiPG alloc] init];
    cai.isTaoCanCaiPin = @"1";
    cai.dishesName = replaceInfo.dishesName;
    cai.dishesId = replaceInfo.replaceId;
    [self.foodMenuArr insertObject:cai atIndex:self.replaceIndex.row];
    [self.tableView insertRowsAtIndexPaths:@[self.replaceIndex] withRowAnimation:UITableViewRowAnimationRight];
    
    for (TaoCanPG *taocanPG in self.taocanDianJiArr)
    {
//        NSLog(@"%@___%@",taocanPG.dishID,self.replaceTaoCanID);
        if ([taocanPG.dishID isEqualToString:self.replaceTaoCanID])
        {            //判断是否是一个套餐id
            for (TaoCanUpPG *UpPG in taocanPG.caipinArr)
            {                       //遍历套餐里边的菜品
//                NSLog(@"++++++%@++++%@",taocanUpPG.dishesName,replaceInfo.dishesName);
                if ([UpPG.dishesName isEqualToString:selectCaipg.dishesName])
                {  //判断遍历出来的菜品名字是否和点击菜品的名字一样
                    [taocanPG.caipinArr removeObject:UpPG];
                    TaoCanUpPG *rPG = [[TaoCanUpPG alloc] init];
                    /**
                     @property (nonatomic, copy) NSString *unitName;
                     @property (nonatomic, copy) NSString *dishesId;
                     @property (nonatomic, copy) NSString *unitNum;
                     @property (nonatomic, copy) NSString *dishesName;
                     @property (nonatomic, copy) NSString *dsDishesId;   //1
                     @property (nonatomic, copy) NSString *dishesCode;
                     @property (nonatomic, copy) NSString *mr_dishesId;
                     @property (nonatomic, copy) NSString *mr_dishesName;
                     @property (nonatomic, copy) NSString *mr_unitNum;
                     @property (nonatomic, copy) NSString *mr_unitName;
                     @property (nonatomic, copy) NSString *mr_dishesCode;
                     */
                    rPG.unitName = self.replaceInfo.unitName;
                    rPG.dishesId = self.replaceInfo.replaceId;
                    rPG.unitNum = self.replaceInfo.unitNum;
                    rPG.dishesName = self.replaceInfo.dishesName;
                    rPG.dsDishesId = self.replaceInfo.dsId;
                    rPG.dishesCode = self.replaceInfo.dishesCode;
                    rPG.mr_dishesId = self.replaceInfo.replaceId;
                    rPG.mr_dishesName = self.replaceInfo.dishesName;
                    rPG.mr_unitNum = self.replaceInfo.unitNum;
                    rPG.mr_unitName = self.replaceInfo.unitName;
                    rPG.dishesCode = self.replaceInfo.dishesCode;
                    [taocanPG.caipinArr addObject:rPG];
//                    rPG.
                    return;
                }
                
            }
            

        }
//        for (TaoCanUpPG *uppg in taocanPG.caipinArr) {
//            NSLog(@"*******%@",uppg.dishesName);
//        }
    }
    
}



#pragma mark - collectionView的数据源及代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.caiArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"collectCell";
    
    UINib *nib = [UINib nibWithNibName:@"FoodCell" bundle:nil];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    

    FoodCell *food = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    food.caipg = self.caiArr[indexPath.row];
    NSString *dishName = [NSString stringWithFormat:@"%@&%lu",food.caipg.dishesName,indexPath.row];
    

    return food;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.needSendLastShowData = YES;
    
    CaiPG *caipg = self.caiArr[indexPath.row];
    caipg.isRed = @"0";
    //whc
    caipg.unitNumStr = @"1";

    NSString *_isred = @"0";
    
//    NSString *str  = [NSString stringWithFormat:@"%@",caipg.dishesId];
//    
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
    
    if ([self.whereFromStr isEqualToString:@"used"])
    {
        
        _isred = @"1";
//     caipg.isRed = @"1";
    }
    if (caipg.estimate)
    {
        if ([caipg.estimate isEqualToString:@"0"])
        {
            return;
        }
        else
        {
            
            caipg.estimate = [NSString stringWithFormat:@"%ld",caipg.estimate.integerValue - 1];
            [self.collectView reloadItemsAtIndexPaths:@[indexPath]];
        }
    }
    
    if ([caipg.dishAndSetDiv isEqualToString:@"2"])
    {

        [self setJieZhangBtnisEnable:YES];
        
        /**
         *  判断新点击的菜品是否在之前点过
         */
        BOOL isHave = NO;
        
        for (CaiPG *yicunrudeCai in self.foodMenuArr)
        {
            if ([yicunrudeCai.dishesId isEqualToString:caipg.dishesId])
            {
                
                isHave = YES;
                caipg.unitNumStr = [NSString stringWithFormat:@"%ld",caipg.unitNumStr.integerValue + 1];
            }
        }
        if (!isHave)
        {
            
            [self.foodMenuArr addObject:caipg];
            [self getTaoCanInfoWithDishID:caipg taocanID:caipg.dishesId];
        }
        
        
        
//    if (caipg.isDishesSet) {
//        
//        NSLog(@"----%@",caipg.dishesSetDesc);
//        [self.foodMenuArr addObject:caipg];
  
    }else
    {
        [self setJieZhangBtnisEnable:YES];
        
        /**
         *  判断新点击的菜品是否在之前点过
         */
        
        /**
         *  判断新点击的菜品是否与最后点击的一个菜品相同
         */
        CaiPG *lastCaiPg = [self.foodMenuArr lastObject];
        

        if ([caipg.dishesId isEqualToString:lastCaiPg.dishesId] && [lastCaiPg.isRed isEqualToString:_isred])
        {
            
            
            lastCaiPg.unitNumStr = [NSString stringWithFormat:@"%ld",lastCaiPg.unitNumStr.integerValue + 1];

        }
        else
        {
            CaiPG *tmpCai = [CaiPG new];
            tmpCai.dishesName = caipg.dishesName;
            tmpCai.dishesCode = caipg.dishesCode;
            tmpCai.dishesId = caipg.dishesId;
            tmpCai.unitNumStr = caipg.unitNumStr;
            tmpCai.oriCostStr = caipg.oriCostStr;
            tmpCai.isRed = _isred;
            tmpCai.isRulingPrice = caipg.isRulingPrice;
 
            if (!tmpCai)
            {
                [self.foodMenuArr addObject:caipg];
            }else
            {
                [self.foodMenuArr addObject:tmpCai];
            }
        }
        
     }
    
    
    
    /**
     *  处理部分菜品的价格有可能不是整数
     */
    if([caipg.oriCostStr rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
    {
    _sum = _sum + caipg.oriCostStr.floatValue;
    }
    else
    {
    _sum =_sum + caipg.oriCostStr.integerValue;
    }
    // x修改掉以前修改的  王洪昌
    
    if (![[NSString stringWithFormat:@"%.2f",_sum] floatValue])
    {
        self.zongjine.text = @"0";
    }
    else
    {
        //王京阳  保留到分
         self.zongjine.text = [NSString stringWithFormat:@"%.2f",_sum];
    }
   
    
    [self.tableView reloadData];
    
    
    
    if ([self.whereFromStr isEqualToString:@"used"])
    {
        
        NSMutableArray *redArr = [NSMutableArray array];
        for (CaiPG *cai in self.foodMenuArr)
        {
            if ([cai.isRed isEqualToString:@"1"])
            {
                [redArr addObject:cai];
            }
        }

        [self showOrderInfo2:redArr];
        
    }
    else
    {
        [self showOrderInfo2:self.foodMenuArr];
    }
 
    
//    CaiPG *caipg = self.caiArr[indexPath.row];
//    [self.foodMenuArr addObject:caipg];
//    
//    self.caipinshuliang.text = [NSString stringWithFormat:@"%ld",self.foodMenuArr.count];
//    
//
//    if([caipg.price rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
//        {
//        _sum = _sum + caipg.price.floatValue;
//        }
//    else
//        {
//        _sum =_sum + caipg.price.integerValue;
//        }
//    
//    self.zongjine.text = [NSString stringWithFormat:@"%.1f",_sum];
//    [self.tableView reloadData];
    
}

#pragma mark - tableView的数据源和代理方法


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return self.SectionsNum;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.foodMenuArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    static NSString *ID2 = @"cell2";
    static NSString *ID3 = @"cell3";

    CaiPG *caipg = self.foodMenuArr[indexPath.row];
    NSLog(@"++++983978%@",caipg.isRulingPrice);

    if ([caipg.dishAndSetDiv isEqualToString:@"2"] || caipg.dishesSetDesc)
    {//套餐菜品
        FoodMenuDetilCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (cell == nil)
        {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FoodMenuDetilCell" owner:nil options:nil];
            cell = [arr lastObject];
        }
        
        if (![caipg.unitNumStr isEqualToString:@"1"])
        {
            cell.name.text = [NSString stringWithFormat:@"%@    X %@",caipg.dishesName,caipg.unitNumStr];
        }else
        {
            
            cell.name.text = caipg.dishesName;
        }
            

        
        cell.price.text = @"11";//caipg.oriCostStr;
        
        if ([caipg.isRed isEqualToString:@"1"])
        {
            cell.name.textColor = [UIColor redColor];
            cell.price.textColor = [UIColor redColor];
        }
        
        return cell;
        
    }else if (caipg.isTaoCanCaiPin)
    {//套餐菜品的子菜品
        
        FoodMenuDetilCell2 *cell = [tableView dequeueReusableCellWithIdentifier:ID3];
        if (cell == nil) {
            NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FoodMenuDetilCell2" owner:nil options:nil];
            cell = [arr lastObject];
        }
        cell.name.text = caipg.dishesName;
        cell.price.text = caipg.oriCostStr;
        cell.contentView.userInteractionEnabled = NO;
        if ([caipg.isRed isEqualToString:@"1"])
        {
            cell.name.textColor = [UIColor redColor];
        }
        
        
        return cell;
        
    }else
    {//普通菜品
        
        FoodMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil)
        {
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"FoodMenuCell" owner:nil options:nil];
            cell = [nibs lastObject];
        }



        cell.caipg = caipg;
        
            //    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_qt"]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 32.f;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    

    if (editingStyle ==UITableViewCellEditingStyleDelete)
    {
        _SChuindexPath = indexPath;
        CaiPG *caipg = self.foodMenuArr[indexPath.row];
//        NSLog(@"___%@",caipg);
//        if (!caipg.isTaoCanCaiPin)
//        {
//            if (indexPath.row<[self.foodMenuArr count])
//            {
//
//                [self.foodMenuArr removeObjectAtIndex:indexPath.row];
//                    //判断是否删除了全部
//                if (self.foodMenuArr.count == 0)
//                {
//                    [self setJieZhangBtnisEnable:NO];
//                }
//            }
//        }
        
        if (!caipg.isTaoCanCaiPin)
        {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定删除？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                alert.tag = 1;
                alert.delegate = self;
                [alert show];
            
          
            
        }
        
        
//        // add by manman for start of line
//        // 在删除菜品的时候 小计 不变化
//        
//        if([caipg.oriCostStr rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
//        {
//            _sum = _sum - caipg.oriCostStr.floatValue;
//        }
//        else
//        {
//            _sum =_sum - caipg.oriCostStr.integerValue;
//        }
//        
//        self.zongjine.text = [NSString stringWithFormat:@"%.2f",_sum];
//        
//        
//        
//        
//        
//        // end of line
        
                /**
                 *  删除上传普通菜品的数据源
                 */
//                NSLog(@"%ld",self.putongcanpinArr.count);
        
        
//                for (int i = 0; i < self.putongcanpinArr.count; ++i) {
//                    CaiPG *c = self.putongcanpinArr[i];
//                    if ([c.dishesId isEqualToString:caipg.dishesId]) {
//                        [self.putongcanpinArr removeObject:c];
//                    }
//                }
//                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//                for (NSString *str in [self.countDict allKeys]) {
//                    if ([str isEqualToString:caipg.dishesId]) {
//                        NSString *count = [self.countDict objectForKey:str];
//                        NSRange range = NSMakeRange(indexPath.row, count.integerValue);
//                        [self.foodMenuArr removeObjectsInRange:range];
//                        
//                        [self.tableView reloadData];
        
//                        /**
//                         *  删除上传套餐的数据源
//                         */
//                        for (int i = 0; i < self.taocanDianJiArr.count; ++i)
                          //  {
//                            TaoCanPG *taocanpg = self.taocanDianJiArr[i];
//                            if ([taocanpg.dishID isEqualToString:str])
                             //   {
//                                [self.taocanDianJiArr removeObject:taocanpg];
//                              }
//                          }
//                     }
//                }
//                if([caipg.price rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
//                    {
//                    _sum = _sum - caipg.price.floatValue;
//                    }
//                else
//                    {
//                    _sum =_sum - caipg.price.integerValue;
//                    }
//                
     //           self.zongjine.text = [NSString stringWithFormat:@"%.2f",_sum];
//            }
     // }
   //}
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @" 删除 ";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    vc.modalPresentationStyle = UIModalPresentationPageSheet;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    
    UITableViewCell *cell = (UITableViewCell *) [tableView indexPathForCell:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    
    CaiPG *caipg = self.foodMenuArr[indexPath.row];
    self.replaceIndex = indexPath;
//    if (caipg.isTaoCanCaiPin && self.canReplace) {

        ChangeFoodController *changeFood = [[ChangeFoodController alloc] init];
        changeFood.taocanID = caipg.taocanID;
        changeFood.dedishID = caipg.dishesId;
        changeFood.indexPath = indexPath;
        changeFood.delegate = self;
        changeFood.number = caipg.unitNumStr;
        changeFood.zengsong = caipg.oriCostStr;
        changeFood.jiKouArr = self.jkouArr;
    //判断是否可市价  WHC 2015 11 30
    if ([self.whereFromStr isEqualToString:@"used"]) {
        CaiPG *cai = self.foodMenuArr[indexPath.row];
        if ([cai.isRed isEqualToString:@"1"]) {
            changeFood.panDuanStr = @"wang";
            changeFood.atOnceMoney = caipg.isRulingPrice;
        }
        else{
        changeFood.atOnceMoney = @"0";
        }
    }
      else{
     changeFood.panDuanStr = @"wang";

     changeFood.atOnceMoney = caipg.isRulingPrice;
      }
    
    NSLog(@"%@+++++",caipg.isRulingPrice);
    
    
   // NSLog(@"changeFood dish ID:%@",changeFood.dedishID);
        changeFood.caiName = caipg.dishesName;
        changeFood.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        changeFood.modalPresentationStyle = UIModalPresentationPageSheet;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:changeFood animated:YES completion:nil];
//    }
    
    
    
    
}
#pragma mark 时价的代理 WHC
-(void)sendMesage:(NSString *)number andWithPrice:(NSString *)price andWithIndex:(NSIndexPath *)index andWithJiKou:(JiKou *)jikoM
{
   
    
  
  //添加传递的模型
    int k = 0;
    if (self.jkouArr.count == 0) {
        [self.jkouArr addObject:jikoM];
        k = 1;
        
    }
    else{
        
        for (int i = 0; i < self.jkouArr.count; i ++) {
            JiKou *ji = self.jkouArr[i];
            if ([ji.dishesName isEqualToString: jikoM.dishesName]) {
                [self.jkouArr replaceObjectAtIndex:i withObject:jikoM];
                k = 1;
            }
        }
    }
    if (k == 0) {
        [self.jkouArr addObject:jikoM];
    }
    for (JiKou *ji in self.jkouArr) {
//        NSLog(@"11%@",ji.name);
//        NSLog(@"%@",ji.jikou);
    }
    //时价的代理
    CaiPG *cai = self.foodMenuArr[index.row];
    
   
    NSString *strZ1 = self.zongjine.text;
    int zongJine = [strZ1 intValue];
    int zongJineLast;
    if (number) {
        if (price) {
            int k = [cai.oriCostStr intValue] *[cai.unitNumStr intValue]-[price intValue]*[number intValue];
            zongJineLast = zongJine - k;
        }else{
            int k = [cai.oriCostStr intValue] *[cai.unitNumStr intValue]-[cai.oriCostStr intValue]*[number intValue];
            zongJineLast = zongJine - k;
        }
        
        
    }
    else{
        int k = [cai.oriCostStr intValue] *[cai.unitNumStr intValue]-[price intValue]*[number intValue];
        zongJineLast = zongJine - k;
    }
    if (price.length) {
        cai.oriCostStr = price;
    }
    
    cai.unitNumStr = number;
    [self.foodMenuArr replaceObjectAtIndex:index.row withObject:cai];
    [self.tableView reloadData];
    self.zongjine.text = [NSString stringWithFormat:@"%d",zongJineLast];
//  _sum = [[NSString stringWithFormat:@"%d",zongJineLast] floatValue];
    _sum = (CGFloat)zongJineLast;
    self.zongjine.text = [NSString stringWithFormat:@"%.2f",_sum];
    UIButton *btn = [[UIButton alloc]init];
    btn.tag = 0;
    [self topButtonChick:btn];
    
    
    
    if ([self.whereFromStr isEqualToString:@"used"])
    {
        
        NSMutableArray *redArr = [NSMutableArray array];
        for (CaiPG *cai in self.foodMenuArr)
        {
            if ([cai.isRed isEqualToString:@"1"])
            {
                [redArr addObject:cai];
            }
        }
        
        [self showOrderInfo2:redArr];
        
    }
    else
    {
        [self showOrderInfo2:self.foodMenuArr];
    }
    
    
}

/*
    此方法是实现 保存订单展开
 */
#pragma mark - saveViewController的代理方法
- (void)SavedViewControllerDidChickTableView:(SavedViewController *)saveOrderVc WithOrderList:(NSMutableArray *)orderDetil billId:(NSString *)billId tabID:(NSString *)tabID{
    
    
    self.canReplace = NO;
    self.billID = billId;
    
    self.tabID = tabID;
    //    self.foodMenuArr = orderDetil;
    [self.foodMenuArr removeAllObjects];
    NSInteger count = 0;
    for (int i = 0; i < orderDetil.count; ++i)
    {
        CaiPG *caipg = orderDetil[i];
        //        NSLog(@"%@",caipg.dishAndSetDiv);
        
        count = count + caipg.unitPrice.integerValue;
        
        //        if ([caipg.dishAndSetDiv isEqualToString:@"2"]) {
        //
        //            [self getTaoCanInfoWithDishID:caipg];
        //            [self.foodMenuArr addObject:caipg];
        if (caipg.dishesSetDesc)
        {
            
                [self.foodMenuArr addObject:caipg];
                //
                NSArray *arr = [CaiPG objectArrayWithKeyValuesArray:caipg.dishesSetDesc];
                //            NSLog(@"%@",arr);
                //            for (CaiPG *cai in arr) {
                //                cai.isTaoCanCaiPin = @"1";
                //            }
                //            NSLog(@"%ld",arr.count);
                for (int i = 0; i < arr.count; ++i)
                {
                    CaiPG *cai = arr[i];
                    cai.isTaoCanCaiPin = @"1";
                }
                [self.foodMenuArr addObjectsFromArray:arr];
                
            
            
            //            [self getTaoCanInfoWithDishID:caipg];
            //            [self.foodMenuArr addObject:caipg];
            
        }
        else
        {
            
            [self.foodMenuArr addObject:caipg];
            [self.putongcanpinArr addObject:caipg];
            
            
        }
    }
    
    //判断是否删除了全部
    if (self.foodMenuArr.count == 0)
    {
        [self setJieZhangBtnisEnable:NO];
    }
    else
    {
        
        [self setJieZhangBtnisEnable:YES];
    }
    //修改掉以前改的 王洪昌
    
    if (![[NSString stringWithFormat:@"%ld",count] floatValue])
    {
        self.zongjine.text = @"0";
    }
    else
    {
        self.zongjine.text = [NSString stringWithFormat:@"%ld",count];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UsedViewController的代理方法
- (void)UsedViewControllerDeskDidChick:(UsedViewController *)usedVc WithOrderList:(NSMutableArray *)orderListArr DeskStates:(DeskState *)deskState whereFrom:(NSString *)usedOrder{
    
    for (NSArray *arr in usedVc.dishInfoArr)
    {
        [self.foodMenuInfoArr addObject:arr];
        //add by manman  start of line
        [self.foodMenuInfoArrCopy addObject:arr];//拷贝一份  供删除 菜品使用
        
        // end of line
        
    }
    
   // self.foodMenuInfoArr = [usedVc.dishInfoArr copy];
    self.whereFromStr = usedOrder;
//    DLog(@"----------%@",orderListArr);
    if ([self.whereFromStr isEqualToString:@"used"]|| [self.whereFromStr isEqualToString:@"emptyused"])
    {
        self.tableNumber.text  =[NSString stringWithFormat:@"%@餐台",deskState.tabNo];
        
    }
    self.deskState  = deskState;
    NSLog(@"self deskState :%@",self.deskState.mj_keyValues);
    self.canReplace = NO;
    self.billID = deskState.billId;
    NSLog(@"self.billID:%@",self.billID);

    self.tabID = deskState.tabId;
    self.tableName.text = deskState.tabName;
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 1;
    [[MainViewController sharedMainView] BottomViewDidChick:nil withButton:btn whereFromStr:usedOrder];

    
    [self.foodMenuArr removeAllObjects];

    for (int i = 0; i < orderListArr.count; ++i)
    {

       // CaiPG *caipg = [CaiPG mj_objectWithKeyValues:orderListArr[i]];// orderListArr[i];
        CaiPG *caipg = orderListArr[i];
//        NSLog(@"%@",caipg.dishAndSetDiv);
//        NSLog(@"dish List :%@",caipg.dishesName);
        //套餐
        if (caipg.dishesSetDesc != nil)
        {

            [self.foodMenuArr addObject:caipg];
            NSArray *arr = [CaiPG mj_objectArrayWithKeyValuesArray:caipg.dishesSetDesc];
            for (int i = 0; i < arr.count; ++i)
            {
                CaiPG *cai = arr[i];
                cai.isTaoCanCaiPin = @"1";
            }
            
            [self.foodMenuArr addObjectsFromArray:arr];
        }
        else
        {
            if (self.foodMenuInfoArrCopy != nil) {
                if (self.foodMenuInfoArrCopy.count > 0) {
                    caipg.bdId = [NSString stringWithFormat:@"%@",[self.foodMenuInfoArrCopy[i] objectForKeyedSubscript:@"bdId"]];
                }
            }
            
            
            [self.foodMenuArr addObject:caipg];
            
            [self.putongcanpinArr addObject:caipg];
            // add by manman for start of line
            //将已点餐的订单 备份 以备删除校对
            
            [self.foodMenuArrCopy addObject:caipg];
            
        
            
            // end of line
            
            
        }
    }
    
    NSLog(@"food menu array :%@",self.foodMenuArr);

        //判断是否删除了全部
    if (self.foodMenuArr.count == 0)
    {
        [self setJieZhangBtnisEnable:NO];
    }
    else
    {
        
        [self setJieZhangBtnisEnable:YES];
    }
    _sum = deskState.totalPrice.floatValue;
    //修改掉以前改的 王洪昌
  
    if (![[NSString stringWithFormat:@"%@",deskState.totalPrice] floatValue])
    {
        self.zongjine.text = @"0";
    }
    else
    {
          self.zongjine.text = [NSString stringWithFormat:@"%@",deskState.totalPrice];
    }

    [self.tableView reloadData];
    

}
-(void)UsedViewControllerDeskDidChick:(NSMutableArray *)jiKou{
  
    self.jkouArr = jiKou;
    NSLog(@"11111%@",self.jkouArr);
}
#pragma mark -  SaveOrderViewControllerDelegate方法
- (void)SaveOrderViewControllerDidZhifu:(SaveOrderViewController *)saveOrderVc DeskState:(DeskState *)deskState billID:(NSString *)billID{
    
    
    self.deskState  = deskState;
    
    [self printOrderInfo:self.foodMenuArr];
    
    
    self.tabID = deskState.tabId;
    [self.foodMenuArr removeAllObjects];
    [self.tableView reloadData];
    self.zongjine.text = @"";
    self.tableName.text = @"";
    self.sum = 0.0;//总计 清零
    self.tabID = nil;
    self.billID = nil;
    
}


//#pragma mark - 监听右侧tableView的数据源属性的改变
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    
//    NSLog(@"%@",change);
//}


#pragma mark - AlertView的代理方法

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag == 1)
    {
        if (buttonIndex == 0)
        {
//            NSLog(@"123");
            //        CaiPG *caipg = self.foodMenuArr[indexPath.row];
            CaiPG *caipg = self.foodMenuArr[_SChuindexPath.row];
        
            NSLog(@"delete index:%ld",_SChuindexPath.row);
        
            // add by manman start of line
            // 删除服务器上记录的菜品
            //此菜品  与未上传的菜品的区别  是  上传的菜品 有一个特殊的属性bdId 
            if (caipg.bdId) {
                [self.deleteFoodMenuArr addObject:caipg];
            }
            
            // end of line
            
            /**
             *  如果删除菜品的时候判断该菜品是否被沽清，如果沽清了就尝试还原之前的沽清数量
             */
            for (CaiPG *cai in self.caiArr)
            {
                if ([caipg.dishesId isEqualToString:cai.dishesId])
                {
                    if (cai.estimate.length)
                    {
                        cai.estimate = [NSString stringWithFormat:@"%ld",cai.estimate.integerValue + caipg.unitNumStr.integerValue];
                        [self.collectView reloadData];
                    }
                }
            }
            
            //普通菜品
            if (!caipg.isTaoCanCaiPin)
            {
                if (_SChuindexPath.row<[self.foodMenuArr count])
                {
                   
                    
                    
                    
                    
                    [self.foodMenuArr removeObjectAtIndex:_SChuindexPath.row];
                    //判断是否删除了全部
                    if (self.foodMenuArr.count == 0)
                    {
                        [self setJieZhangBtnisEnable:NO];
                    }
                }
            }
            
            // 删除数据源
            for (int i = 0; i < self.putongcanpinArr.count; ++i)
            {
                CaiPG *c = self.putongcanpinArr[i];
                
                if ([c.dishesId isEqualToString:caipg.dishesId])
                {
                    [self.putongcanpinArr removeObject:c];
                }
            }
            // 删除 表格的数据显示
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_SChuindexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            for (NSString *str in [self.countDict allKeys])
            {
                
                
                if ([str isEqualToString:caipg.dishesId])
                {
                    NSString *count = [self.countDict objectForKey:str];
                    NSRange range = NSMakeRange(_shanchuIndex, count.integerValue);
                    [self.foodMenuArr removeObjectsInRange:range];
                    
                    [self.tableView reloadData];
                    
                    
                    /**
                     *  删除上传套餐的数据源
                     */
                    for (int i = 0; i < self.taocanDianJiArr.count; ++i)
                    {
                        TaoCanPG *taocanpg = self.taocanDianJiArr[i];
                        if ([taocanpg.dishID isEqualToString:str])
                        {
                            [self.taocanDianJiArr removeObject:taocanpg];
                        }
                    }
                }
            }
                if([caipg.oriCostStr rangeOfString:@"."].location !=NSNotFound)//_roaldSearchText
                {
                    _sum = _sum - caipg.oriCostStr.floatValue * caipg.unitNumStr.floatValue;
                }
                else
                {
                    _sum =_sum - caipg.oriCostStr.integerValue * caipg.unitNumStr.floatValue;
                }
                //修改掉以前改掉的
               
                if (![[NSString stringWithFormat:@"%.2f",_sum] floatValue])
                {
                    self.zongjine.text = @"0";
                }
                else
                {
                     self.zongjine.text = [NSString stringWithFormat:@"%.2f",_sum];
                }

                
                
                if ([self.whereFromStr isEqualToString:@"used"])
                {
                    
                    NSMutableArray *redArr = [NSMutableArray array];
                    for (CaiPG *cai in self.foodMenuArr)
                    {
                        if ([cai.isRed isEqualToString:@"1"])
                        {
                            [redArr addObject:cai];
                        }
                    }
                    
                    [self showOrderInfo2:redArr];
                    
                }
                else
                {
                    [self showOrderInfo2:self.foodMenuArr];
                }
            
        }
        else if (buttonIndex == 1)
        {
//            NSLog(@"456");
        }
        
        }
        else if (alertView.tag == 2)
        {
            
            [self.foodMenuArr removeAllObjects];
            [self.tableView reloadData];
        }
    
        
        if (alertView.tag == 199 )
        {
            if (buttonIndex == 0)
            {
    //            NSLog(@"OK");

                self.diancanforwardUrl = [[NSMutableString alloc]initWithCapacity:10];
                
                NSRange range = [self.tableNumber.text rangeOfString:@"餐台"];
                
                NSString *tabNo = [self.tableNumber.text substringWithRange:range];
                NSString *tabNoS = [self.tableNumber.text stringByReplacingOccurrencesOfString:@"餐台" withString:@""];


                  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:tabNoS,@"table.tabNo",self.tabID,@"table.tabId",tabNoS,@"tableNo", nil];

                NSString *tableUrlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/kaitai/create",ceshiIP];
                            [HttpTool GET:tableUrlStr parameters:dict success:^(id responseObject) {
                                
    //                            NSLog(@"responseObject:%@",responseObject);
                
                                if ([[responseObject objectForKey:@"message"] isEqualToString:@"1"]) {
                                    self.diancanforwardUrl = [responseObject objectForKey:@"forwardUrl"];
                
                                    [self getInfo];
                
                                }
                            } failure:^(NSError *error) {
                                [self showAlertViewMessage:@"下单失败"];
                            }];
                
                
                
            }
            else
            {
                //NSLog(@"failed");
                
                [self jumpToSaveOrder];
            }
        }

}


-(void)showAlertViewMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alertView show];
}


/**
 *  由餐台状态跳转至点餐页面   
 *   下单 上传菜品
 */

-(void)uploadEmptyDeskBill
{
    
    self.diancanforwardUrl = [[NSMutableString alloc]initWithCapacity:10];
    
    NSRange range = [self.tableNumber.text rangeOfString:@"餐台"];
    
    
   // NSString *tabNo = [self.tableNumber.text substringWithRange:range];
    NSString *tabNoS = [self.tableNumber.text stringByReplacingOccurrencesOfString:@"餐台" withString:@""];
   
    
    //self.deskState.tabNo = [NSString stringWithFormat:@"%@",tabNoS];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:tabNoS,@"table.tabNo",self.tabID,@"table.tabId",tabNoS,@"tableNo", nil];
    
    NSString *tableUrlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/kaitai/create",ceshiIP];
    [HttpTool GET:tableUrlStr parameters:dict success:^(id responseObject) {
        
        NSLog(@"responseObject:%@",responseObject);
        
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"1"]) {
            self.diancanforwardUrl = [responseObject objectForKey:@"forwardUrl"];
            
            [self getInfo];
            
        }
    } failure:^(NSError *error) {
        [self showAlertViewMessage:@"下单失败"];
    }];
    
    
    
    
    
}



- (void)getInfo{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/diancai?billId=%@&returnJson=json",ceshiIP,self.diancanforwardUrl];
//    NSLog(@"urlStr:%@",urlStr);//{"billType":"1","billPlaceEnterDeskOrPay":"0","billId":"0000000050bb9f4f0150bbde19c900d8"}
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        
        self.billId = responseObject[@"billId"];
        // add by manman  start of line
       // self.deskState.billNo = [NSString stringWithFormat:@"%@",self.billId];
        NSString *timeStr = [self getCurrentDateStr:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld"];
        self.deskState.openTableTime = [NSString stringWithFormat:@"%@",timeStr];
        NSLog(@"self.deskState:%@",self.deskState.mj_keyValues);
        // end of line
        if (self.foodMenuArr.count ) {
            
            [self shangchuanCaiPin];
        }
    } failure:^(NSError *error) {
        NSLog(@"++++%@",error);
    }];
}


- (void)wuzhuozibaocundingdan:(NSMutableArray *)xinzengArr{
    
    NSString *dishID = @"";
    NSString *dishNum = @"";

    //    NSLog(@"%@",self.OrderList);
    for (int i = 0; i < xinzengArr.count; ++i) {
        CaiPG *caipg = xinzengArr[i];
        if (dishID.length == 0) {
            dishID = caipg.dishesId;
        }else{
            
            dishID = [NSString stringWithFormat:@"%@,%@",dishID,caipg.dishesId];
            
        }
    }
    
    for (int i = 0; i < xinzengArr.count; ++i) {
        CaiPG *caipg = xinzengArr[i];
        if (dishNum.length == 0) {
            dishNum = caipg.unitNumStr;
        }else{
            
            dishNum = [NSString stringWithFormat:@"%@,%@",dishNum,caipg.unitNumStr];
        }
    }
    
   NSLog(@"%@----%@",dishID,dishNum);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/jiacai2/6/%@?unitNumStr=%@&billId=%@",ceshiIP,dishID,dishNum,self.billID];
   
    NSLog(@"%@",urlStr);
    
    
    
        [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//        [self XinZengTiJiaoDingDan];
        NSLog(@"%@",responseObject);

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存订单成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];

    } failure:^(NSError *error) {
        
        [self showAlertViewMessage:@"下单失败"];
    }];
    
    
}


- (void)shangchuanXinZengCaiPinWith:(NSMutableArray *)xinzengArr
{
    
    NSString *dishID = @"";
    NSString *dishNum = @"";
        //    NSLog(@"%@",self.OrderList);
    
    for (int i = 0; i < xinzengArr.count; ++i) {
        CaiPG *caipg = xinzengArr[i];
        if (dishID.length == 0) {
            dishID = caipg.dishesId;
        }else{
            
            dishID = [NSString stringWithFormat:@"%@,%@",dishID,caipg.dishesId];
        }
    }
    
    for (int i = 0; i < xinzengArr.count; ++i) {
        
        CaiPG *caipg = xinzengArr[i];
        if (dishNum.length == 0) {
            dishNum = caipg.unitNumStr;
        }else{
            
            dishNum = [NSString stringWithFormat:@"%@,%@",dishNum,caipg.unitNumStr];
        }
    }
//    NSLog(@"%@----%@",dishID,dishNum);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/jiacai/1/%@?unitNumStr=%@&billId=%@",ceshiIP,dishID,dishNum,self.billID];
    NSLog(@"加菜 request %@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"jiacai  response  %@",responseObject);
        // add by manman start of line
         // 打印时间处理
        
        self.deskState.billNo = [responseObject objectForKey:@"forwardUrl"];
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        NSString *currentDateStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld",[dateComponent year],[dateComponent month],[dateComponent day]];

        
        self.deskState.openTableTime = [NSString stringWithFormat:@"%@ %@",currentDateStr ,self.deskState.openTableTime];
        
        NSLog(@"self.deskState new %@",self.deskState.mj_keyValues);
        // end of line
        [self XinZengTiJiaoDingDan :xinzengArr];
        
        
    } failure:^(NSError *error) {
        
        
        [self showAlertViewMessage:@"下单失败"];
        
    }];
    
    
}

- (void)XinZengTiJiaoDingDan :(NSArray *)addArr{
    
    NSString *str = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/xiadan/%@?enterType=0&returnJson=json",ceshiIP,self.billID];
    [HttpTool GET:str parameters:nil success:^(id responseObject) {
       
        //WHC
        NSString *strBillID = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?billId=%@&billType=1&returnJson=json",ceshiIP,self.billID];
        [HttpTool GET:strBillID parameters:nil success:^(id responseObject) {
            NSLog(@"12345678%@",responseObject);
            NSMutableArray *arr =[NSMutableArray arrayWithArray:[responseObject objectForKey:@"dinerBillDishes"]] ;
            // add by manman for start of line
            //添加菜品部分信息
            // NSArray *tmpArra = [arr firstObject];
            int k = addArr.count;
            NSMutableArray *arrHoulaiJIade = [NSMutableArray array];
            while (k) {
               id arrlastOne= [arr lastObject];
                [arrHoulaiJIade addObject:arrlastOne];
                [arr removeLastObject];
                k --;
            }
            NSMutableString *zengping = [NSMutableString string];
            for (NSDictionary *tmpDic in arrHoulaiJIade) {
                
                NSString *bdid = [tmpDic objectForKeyedSubscript:@"bdId"];
                NSString *dishName = [tmpDic objectForKeyedSubscript:@"dishesName"];
                if (self.jkouArr.count) {
                    //遍历加几口 WHC
                    for (JiKou *jik in self.jkouArr) {
//                        NSLog(@"%@",jik.name);
                        if ([jik.dishesName isEqualToString:dishName]) {
                            NSString *url = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/dishCookingNotesd/update/%@",ceshiIP,bdid];
                           // 防止崩溃
                            if (jik.avoidfoodIdArray == nil ) {
                                jik.avoidfoodIdArray = @",  ";
                            }
                            NSDictionary *dic = @{@"avoidArray":jik.avoidfoodIdArray,@"tasteArray":@"",@"pungent":@"0",@"notes":@"",@"isSet":@"",@"return":@"json"};
                            [HttpTool POST:url parameters:dic success:^(id responseObject) {
                                NSLog(@"chenggong");
                                
                                
                            } failure:^(NSError *error) {
                                
                            }];
                        }
                    }
                }else{
                    
                }
                //WHC 忌口结束

                if ([self.whereFromStr isEqualToString:@"used"]) {
                    for (CaiPG *cai in addArr) {
                        if ([cai.dishesName isEqualToString:dishName]&&[cai.oriCostStr isEqualToString:@"0"]) {
                            zengping = [NSMutableString stringWithFormat:@"%@,%@",zengping,bdid];
                        }
                    }
                    
                }
            
                
                NSDictionary *dishInfo = [[NSMutableDictionary alloc]initWithObjectsAndKeys:bdid,@"bdId",dishName,@"dishesName", nil ];
                [self.dishInfoArr addObject:dishInfo];
                
            }
            if (zengping.length) {
                [zengping deleteCharactersInRange:NSMakeRange(0, 1)];
                //WHC 增加赠品
                NSString *urlZeng = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/zengcais/%@/%@",ceshiIP,zengping,self.billID];
                NSDictionary *dic = @{@"isSet":@"0",@"returnJson":@"json"};
                [HttpTool GET:urlZeng parameters:dic success:^(id responseObject) {
                    NSLog(@"chenggong");
                    [self showAlertViewMessage:@"下单成功"];
                    
                    NSMutableArray *redArr = [NSMutableArray array];
                    for (CaiPG *cai in self.foodMenuArr)
                    {
                        if ([cai.isRed isEqualToString:@"1"]) {
                            [redArr addObject:cai];
                        }
                    }
                    [self printOrderInfo:redArr];
                    
                    [self xiadanqingtai];
                    
                    
                } failure:^(NSError *error) {
                    
                }];
                //WHC end
            }
            else{
                [self showAlertViewMessage:@"下单成功"];
                
                //[self xiadanqingtai];
                NSMutableArray *redArr = [NSMutableArray array];
                for (CaiPG *cai in self.foodMenuArr)
                {
                    if ([cai.isRed isEqualToString:@"1"]) {
                        [redArr addObject:cai];
                    }
                }
                [self printOrderInfo:redArr];
                
                [self xiadanqingtai];
                

            }
            //WHC end 11 30 
            
            
            
            
        } failure:^(NSError *error) {
            
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

- (void)shangchuanCaiPin{
    
    NSString *dishID = @"";
    NSString *dishNum = @"";
    //    NSLog(@"%@",self.OrderList);
    
    for (int i = 0; i < self.foodMenuArr.count; ++i) {
        CaiPG *caipg = self.foodMenuArr[i];
        if (dishID.length == 0) {
            dishID = caipg.dishesId;
        }else{
            
            dishID = [NSString stringWithFormat:@"%@,%@",dishID,caipg.dishesId];
        }
    }
    
    for (int i = 0; i < self.foodMenuArr.count; ++i) {
        CaiPG *caipg = self.foodMenuArr[i];
        if (dishNum.length == 0) {
            dishNum = caipg.unitNumStr;
        }else{
            
            dishNum = [NSString stringWithFormat:@"%@,%@",dishNum,caipg.unitNumStr];
        }
    }
//    NSLog(@"%@----%@",dishID,dishNum);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/jiacai/%@/%@?unitNumStr=%@&billId=%@",ceshiIP,self.diancanbillType,dishID,dishNum,self.diancanforwardUrl];
//    NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSLog(@"加菜  response :%@",responseObject);
        self.deskState.billNo = [responseObject objectForKey:@"forwardUrl"];
        if (self.dicOrder[@"tableNo"] != nil) {
            self.deskState.tabNo = self.dicOrder[@"tableNo"];
        }
        
        if (self.dicOrder[@"peopleCount"] != nil) {
             self.deskState.peopleCount = [NSString stringWithString:self.dicOrder[@"peopleCount"]];
        }
       
        NSLog(@" print Info :%@ ",self.deskState.mj_keyValues);
        
            [self tiJiaoDingDan];

        
        
    } failure:^(NSError *error) {
        [self showAlertViewMessage:@"下单失败"];
    }];
    
    
}
- (void)tiJiaoDingDan{
    
    NSString *str = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/xiadan/%@?enterType=0&returnJson=json",ceshiIP,self.diancanforwardUrl];
    NSLog(@"str---%@",str);
    [HttpTool GET:str parameters:nil success:^(id responseObject) {
        NSLog(@"888888%@",responseObject);
        
        
        //WHC t添加赠菜
        NSString *strBillID = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?billId=%@&billType=1&returnJson=json",ceshiIP,self.billId];
        NSLog(@"strBillID---%@",strBillID);
        [HttpTool GET:strBillID parameters:nil success:^(id responseObject) {
                            NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
                // add by manman for start of line
                //添加菜品部分信息
                // NSArray *tmpArra = [arr firstObject];
            NSMutableString *zengping = [NSMutableString string];
                for (NSDictionary *tmpDic in arr) {
                    
                    NSString *bdid = [tmpDic objectForKeyedSubscript:@"bdId"];
                    NSString *dishName = [tmpDic objectForKeyedSubscript:@"dishesName"];
                   
                    if (self.jkouArr.count) {
                        //遍历加几口
                        for (JiKou *jik in self.jkouArr) {
//                            NSLog(@"%@",jik.name);
                            if ([jik.dishesName isEqualToString:dishName]) {
                                NSString *url = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/dishCookingNotesd/update/%@",ceshiIP,bdid];
                                NSDictionary *dic = @{@"avoidArray":jik.avoidfoodIdArray,@"tasteArray":@"",@"pungent":@"0",@"notes":@"",@"isSet":@"",@"return":@"json"};
                                [HttpTool POST:url parameters:dic success:^(id responseObject) {
                                    NSLog(@"chenggong");
                                  

                                } failure:^(NSError *error) {
                                    
                                }];
                            }
                        }
                    }else{
                        
                    }
                    if ([self.whereFromStr isEqualToString:@"used"]) {
                        for (CaiPG *cai in self.foodMenuArr) {
                            if ([cai.isRed isEqualToString:@"1"]&&[cai.dishesName isEqualToString:dishName]) {
                                zengping = [NSMutableString stringWithFormat:@"%@,%@",zengping,bdid];
                            }
                        }
                        
                        }
                    else{
                        
                        for (CaiPG *cai in self.foodMenuArr ) {
                            if ([cai.dishesName isEqualToString:dishName]&&[cai.oriCostStr isEqualToString:@"0"]) {
                                zengping = [NSMutableString stringWithFormat:@"%@,%@",zengping,bdid];
                               
                            }
                        }

                    }
                   
                    NSDictionary *dishInfo = [[NSMutableDictionary alloc]initWithObjectsAndKeys:bdid,@"bdId",dishName,@"dishesName", nil ];
                    [self.dishInfoArr addObject:dishInfo];
                    
                }
            if (zengping.length) {
                [zengping deleteCharactersInRange:NSMakeRange(0, 1)];
                
                //WHC 增加赠品
                NSString *urlZeng = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/zengcais/%@/%@?",ceshiIP,zengping,self.billId];
                NSDictionary *dic = @{@"isSet":@"0",@"returnJson":@"json"};
                NSLog(@"111%@",urlZeng);
                [HttpTool GET:urlZeng parameters:dic success:^(id responseObject) {
                    NSLog(@"chenggong");
                    //添加几口
                    
                    [self showAlertViewMessage:@"下单成功"];
                    
                    [self xiadanqingtai];
                    
                } failure:^(NSError *error) {
                    
                }];
                //WHC end 添加赠菜
            }
            else{
                
                [self showAlertViewMessage:@"下单成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [self printOrderInfo:self.foodMenuArr];
                    [self xiadanqingtai];
    
                });
                
                
                
            }
          
            
        } failure:^(NSError *error) {
            
        }];
        
        //选择餐台下单以后清除菜单      王京阳 该方法添加到增菜后
        
//        [self xiadanqingtai];
//        

        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
#pragma mark - 消费成功的通知方法
-(void)xianjinXiaofeiSuccessWith{

  //  [self.whereFrom isEqualToString:kWaiMaiJieZhangFromStr];
    
    [super viewWillAppear:YES];
    
    if (self.isSuccess) {
        
        [self printOrderInfo:self.foodMenuArr];
        self.isSuccess = NO;
    }
    
    [self tuichudingdanChick:nil];
    
    NSLog(@" clear list ...");
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:KxianjinxiaofeiSuccess object:nil];
}

#pragma mark - 懒加载
- (NSArray *)topArr{
    
    if (_topArr == nil) {
        _topArr = [NSMutableArray array];
    }
    return _topArr;
}

- (NSMutableArray *)caiArr{
    
    if (_caiArr == nil) {
        _caiArr = [NSMutableArray array];
    }
    return _caiArr;
}

- (NSMutableArray *)foodMenuArr{
    
    if (_foodMenuArr == nil) {
        _foodMenuArr = [NSMutableArray array];

    }
    return _foodMenuArr;
}




- (NSMutableArray *)taocanArr{
    
    if (_taocanArr == nil) {
        _taocanArr = [NSMutableArray array];
    }
    return _taocanArr;
}

- (NSMutableArray *)taocanDianJiArr{
    
    if (_taocanDianJiArr == nil) {
        _taocanDianJiArr = [NSMutableArray array];
    }
    return _taocanDianJiArr;
}

- (NSMutableArray *)putongcanpinArr{
    
    if (_putongcanpinArr == nil) {
        _putongcanpinArr = [NSMutableArray array];
    }
    return _putongcanpinArr;
}

- (NSMutableDictionary *)countDict{
    
    if (_countDict == nil) {
        _countDict = [NSMutableDictionary dictionary];
    }
    return _countDict;
}



-(void)extraMealInfo:(NSNotification *)notify
{
    //NSString *str  = [[notify object] objectForKey:@"test"];
    
//    NSLog(@"str:%@",[[notify userInfo] objectForKey:@"tabNo"]);
    
    self.tableNumber.text = [NSString stringWithFormat:@"%@餐台",[[notify userInfo] objectForKey:@"tabNo"]];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"extraMeal" object:nil];
    
}
#pragma mark 图片点击事件 搜索
-(void)caiPinsousuo
{
    [self.shangfangBigView sendSubviewToBack:self.customSearchBar];
    [self.shangfangBigView sendSubviewToBack:self.searchTextField];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    self.sousuo.userInteractionEnabled = YES;
    [self.sousuo addGestureRecognizer:tap];

}
#pragma mark 预定界面的代理方法

#pragma mark 手势tap方法
-(void)tap :(UITapGestureRecognizer *)tap
{
    
    [self requstCai];
   
    
}
//whc 搜索
-(void)requstCai
{
    
    if (self.souSuoText.text.length)
    {
        [self.caiArr removeAllObjects];
        
        NSString *urlsousuo = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=&returnJson=json&categoryId=%@",ceshiIP,self.categoryId1];
        NSString *str = self.souSuoText.text;
        NSDictionary *dic = @{@"keywords":str};
        NSLog(@"search condition:%@",urlsousuo);
        NSLog(@"search condition keyword :%@",dic);
        
        [HttpTool GET:urlsousuo parameters:dic success:^(id responseObject) {
            //归位 上方滑动框
//            self.categoryId1 = @"";
            NSArray *arr = responseObject[@"dishes"][@"content"];
            self.caiArr = [NSMutableArray arrayWithArray:[CaiPG mj_objectArrayWithKeyValuesArray:arr]] ;
            if (self.caiArr.count)
            {
                [self.collectView reloadData];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有搜索结果" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
                [self.caiArr removeAllObjects];
                [self.collectView reloadData];
            }
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }
    else
    {
        UIButton *bu = [[UIButton alloc]init];
        bu.tag = 10;
        [self topButtonChickS:bu];
        //        NSString *urlsousuo = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=&returnJson=json&keywords=",ceshiIP];
//        [HttpTool GET:urlsousuo parameters:nil success:^(id responseObject) {
//            NSLog(@"9888888%@",responseObject);
//            NSArray *arr = responseObject[@"dishes"][@"content"];
//            self.caiArr = [NSMutableArray arrayWithArray:[CaiPG objectArrayWithKeyValuesArray:arr]] ;
//            
//            //            NSLog(@"%@-------%@",self.caiArr,[CaiPG objectArrayWithKeyValuesArray:arr]);
//            [self.collectView reloadData];
//        } failure:^(NSError *error) {
//            
//        }];
        
        
    }


}



- (void)recvMiniPosSDKStatus
{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:@"显示成功"]) {
        
        if (self.needSendLastShowData) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                self.needSendLastShowData = NO;
                
                if ([self.whereFromStr isEqualToString:@"used"])
                {
                    
                    NSMutableArray *redArr = [NSMutableArray array];
                    for (CaiPG *cai in self.foodMenuArr)
                    {
                        if ([cai.isRed isEqualToString:@"1"])
                        {
                            [redArr addObject:cai];
                        }
                    }
                    
                    [self showOrderInfo2:redArr];
                    
                }
                else
                {
                    [self showOrderInfo2:self.foodMenuArr];
                }
            });
            
        }
        
 
        
    }
    
    if ([self.statusStr isEqualToString:@"签到成功"]) {
        [self  showTipView:self.statusStr];
        [self hideHUD];
    }
    
    self.statusStr = @"";
}



-(NSString *)getCurrentDateStr:(NSString *)format
{
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSString *currentDateStr = nil;
    if (format.length == 0) {
        currentDateStr = [NSString stringWithFormat:@"%ld%ld%ld%ld%ld%ld",[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    }
    else
    {
        currentDateStr = [NSString stringWithFormat:format,[dateComponent year],[dateComponent month],[dateComponent day],[dateComponent hour],[dateComponent minute],[dateComponent second]];
    }
    
    return currentDateStr;
    
}

@end
