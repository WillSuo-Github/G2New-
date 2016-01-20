//
//  OriginalContentView.m
//  G2TestDemo
//
//  Created by lcc on 15/7/22.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "OriginalContentView.h"
#import "MainViewController.h"
#import "OrderViewController.h"
#import "HttpTool.h"
#import "KaiTaiPG.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "JiLuCaiViewCell.h"
#import "CaiPG.h"
#import "newBill.h"
#import "TimeTool.h"
//#import "UIViewController+MBProgressHUD.h"


@interface OriginalContentView ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    NSString *isCanPlace;
    
    NSString *_billiId;
    NSString *_tableId;
    NSString *_count;
}

@property (weak, nonatomic) IBOutlet UIButton *tuikuan;
@property (nonatomic, strong) NSMutableArray *caiArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *cantaimingzi;
@property (weak, nonatomic) IBOutlet UILabel *dingdanbianhao;

@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *caozuoyuan;
@property (weak, nonatomic) IBOutlet UILabel *jiucanrenshu;
@property (weak, nonatomic) IBOutlet UILabel *caipinshuliang;
@property (weak, nonatomic) IBOutlet UILabel *zongjine;
@property (weak, nonatomic) IBOutlet UIButton *xiandan;
@property (weak, nonatomic) IBOutlet UIButton *jiezhang;
@property (weak, nonatomic) IBOutlet UILabel *jine;




@end


@implementation OriginalContentView


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"OriginalContentView" owner:nil options:nil];
        self =[nibView objectAtIndex:0];
        self.x = kScreenWidth - koriginalWidth;
//        self.x = 0;
        self.y = 0;
        self.width = koriginalWidth;
        self.height = kScreenHeight - kBottomHeight;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.topView.backgroundColor = [UIColor colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
        self.tuikuan.backgroundColor=[UIColor  colorWithRed:64/255.0 green:132/255.0 blue:221/255.0 alpha:1];
    }
    return self;
}


- (IBAction)xiadanChick:(id)sender {
    

    NSLog(@"place an order Button click....");
    
    if ([_delegate respondsToSelector:@selector(OriginalContentViewDidChickXiaDan:)]) {
        [self.delegate OriginalContentViewDidChickXiaDan:self];
    }
    
}

- (IBAction)jiezhangChick:(id)sender {

     NSLog(@" Button click....");
    
    if ([_delegate respondsToSelector:@selector(OriginalContentViewDidChickJieZhang:WithBillID:tableID:count:)]) {
        [self.delegate OriginalContentViewDidChickJieZhang:self WithBillID:_billiId tableID:_tableId count:_count];
    }
    
}



- (void)setJiaoyiPG:(JiaoYiPG *)jiaoyiPG{
    
    _jiaoyiPG = jiaoyiPG;
    [self requestOneJiLuWithBillNo:jiaoyiPG.billId];
}


- (void)requestOneJiLuWithBillNo:(NSString *)billId{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?returnJson=json&billId=%@",ceshiIP,billId];
   
    NSLog(@"jiaoyijilu request URL%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
       
        NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
        self.caiArr = [CaiPG mj_objectArrayWithKeyValuesArray:arr];
//        NSLog(@"---%@",_caiArr);
        self.caipinshuliang.text = [NSString stringWithFormat:@"%ld",self.caiArr.count];
        isCanPlace = [responseObject objectForKey:@"isCanPlace"];
        NSDictionary * dict = [responseObject objectForKey:@"newBill"];
//        NSLog(@"========%@",dict);
        newBill *newbill = [newBill mj_objectWithKeyValues:dict];
        self.zongjine.text = [NSString stringWithFormat:@"%.2f",newbill.oriCost.floatValue] ;
        self.cantaimingzi.text = newbill.tabNo;
        if ([newbill.billType isEqualToString:@"2"]) {
             self.cantaimingzi.text = @"外卖";
        }
        self.caozuoyuan.text = newbill.waiterName;
        self.shijian.text = [TimeTool JiaoYizhuanhuanshijian:newbill.createTime];
        self.jiucanrenshu.text = newbill.peopleNum;
        self.dingdanbianhao.text = newbill.billNo;
        _billiId = newbill.billId;
        _tableId = newbill.tableId;
        _count = [NSString stringWithFormat:@"%.2f",[[dict objectForKey:@"needMoney"] floatValue]] ;
        NSLog(@"===========%@",_count);
//        NSLog(@"billType--%@  billStatus---%@  iscanPlace----%@",newbill.billType,newbill.billStatus,isCanPlace);
        
        
        [self iscanSplaceWithbillType:newbill.billType billStatus:newbill.billStatus isCanPlace:isCanPlace];
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)iscanSplaceWithbillType:(NSString *)billType billStatus:(NSString *)billStatus isCanPlace:(NSString *)CanPlace{
    
    if ([billType isEqualToString:@"1"] || [billType isEqualToString:@"2"] || [billType isEqualToString:@"3"] || [billType isEqualToString:@"5"]) {
        if ([CanPlace isEqualToString:@"0"]) {
            self.jiezhang.backgroundColor = [UIColor lightGrayColor];
            self.xiandan.backgroundColor = [UIColor lightGrayColor];
            self.jiezhang.userInteractionEnabled = NO;
            self.xiandan.userInteractionEnabled = NO;
        }else if ([CanPlace isEqualToString:@"1"]){
            self.jiezhang.userInteractionEnabled = NO;
            self.jiezhang.backgroundColor = [UIColor lightGrayColor];
            //self.xiandan.backgroundColor = [UIColor blueColor];
            self.xiandan.userInteractionEnabled = YES;
        }
    }else if ([billType isEqualToString:@"4"]){
        
        if ([billStatus isEqualToString:@"3"] || [billStatus isEqualToString:@"8"] || [billStatus isEqualToString:@"10"]) {
            self.xiandan.userInteractionEnabled = NO;
            self.xiandan.backgroundColor = [UIColor lightGrayColor];
            self.jiezhang.backgroundColor = [UIColor lightGrayColor];
            self.jiezhang.userInteractionEnabled = NO;
        }else if ([billStatus isEqualToString:@"1"] || [billStatus isEqualToString:@"2"] || [billStatus isEqualToString:@"4"] || [billStatus isEqualToString:@"9"]){
            self.xiandan.userInteractionEnabled = NO;
            self.xiandan.backgroundColor = [UIColor lightGrayColor];
            //self.jiezhang.backgroundColor = [UIColor blueColor];
            self.jiezhang.userInteractionEnabled = YES;
        }
    }
}


#pragma mark - tableview的数据源和代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.caiArr.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    JiLuCaiViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"JiLuCaiViewCell" owner:nil options:nil];
        cell = [arr lastObject];
    }
    CaiPG *pg = self.caiArr[indexPath.row];

    cell.caipg = pg;
    
    cell.xuhao.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}



@end
