//
//  CaiPinFenXiController.m
//  G2TestDemo
//
//  Created by ws on 15/9/9.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "CaiPinFenXiController.h"
#import "MJRefresh.h"
#import "HttpTool.h"
#import "topRG.h"
#import "CaiPG.h"
#import "MJExtension.h"
#import "DishesMainTableViewCell.h"
#import "ShuJuPG.h"
#import "ZongCaiTableViewCell.h"


@interface CaiPinFenXiController ()<UITableViewDataSource,UITableViewDelegate>


- (IBAction)Top:(UIButton *)sender;
- (IBAction)Under:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;//时间显示

@property (weak, nonatomic) IBOutlet UIButton *under;//前10菜品
@property (weak, nonatomic) IBOutlet UIButton *top;//后10 菜品

@property (nonatomic,strong)NSMutableArray *topArr;//右侧菜品分类数组
@property (weak, nonatomic) IBOutlet UILabel *paihang;
@property (weak, nonatomic) IBOutlet UILabel *caiming;
@property (weak, nonatomic) IBOutlet UILabel *shuliang;
@property (strong, nonatomic) topRG *categoryID;
@property (assign, nonatomic) BOOL top10;
@property (weak, nonatomic) IBOutlet UILabel *caiPinFenXi;

@property (weak, nonatomic) IBOutlet UIView *faBuShiJian;
//排序
@property (copy,nonatomic) NSString *orderBy;
@end

@implementation CaiPinFenXiController

- (void)viewDidLoad {
    [super viewDidLoad];
    //paipaix排序
    self.orderBy = @"desc";
    //菜品排行表格设置
    self.caiPinShuLiang.dataSource = self;
    self.caiPinShuLiang.delegate = self;
    self.caiPinShuLiang.tableFooterView = [[UIView alloc] init];
    self.caiPinShuLiang.tag = 1;
    [self.caiPinShuLiang setSeparatorStyle: UITableViewCellSeparatorStyleSingleLineEtched];
    
    //菜品分类 表格设置
    self.zongCaiDan.dataSource = self;
    self.zongCaiDan.delegate = self;
    self.zongCaiDan.tableFooterView = [[UIView alloc] init];
    self.zongCaiDan.tag = 2;
    [self.zongCaiDan setSeparatorStyle: UITableViewCellSeparatorStyleSingleLineEtched];
    
    //lable菜品分析
    _caiPinFenXi.text = @"菜品分析";
    [_caiPinFenXi setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [_caiPinFenXi sizeToFit];
    
    
    //lable显示数据时间
    //self.timeLabel.font = [UIFont systemFontOfSize:30];
    [self.timeLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    
    //获取现在时间
    NSDate *senddate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *string1 = [dateFormatter stringFromDate:senddate];
//    _timeLabel.text = [[NSDate date]description];
    _timeLabel.text = [string1 description];
    [_timeLabel sizeToFit];
    
    // 这个数组含义
    self.quanbuArr = [NSMutableArray array];

    _top10 = YES;
    [self setcaipinleixing];
    
    self.top.layer.cornerRadius = 12;
    self.top.layer.masksToBounds = YES;
    
    self.under.layer.cornerRadius = 12;
    self.under.layer.masksToBounds = YES;
     [self setMenuContentWithDate:nil];
    [self Top:nil];
}


#pragma mark -- UITableView代理方法使用


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 1) {
        return self.quanbuArr.count;

    }else {
        return self.topArr.count ;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2)
    {
        static NSString *ID = @"Cell";
        ZongCaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ZongCaiTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.numberOfLines = 0;
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"全部";
        }
        else
        {
            topRG *top = self.topArr[indexPath.row - 1];
            cell.textLabel.text = top.categoryName;
        }
        if (indexPath.row>0)
        {
            cell.backgroundColor = [UIColor colorWithRed:246 / 255.0 green:246 / 255.0 blue:246 / 255.0 alpha:1];
        }
        return cell;
    }
    else
    {
        static NSString *ID = @"Cell";
        DishesMainTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell1 == nil) {
            cell1 = [[[NSBundle mainBundle]loadNibNamed:@"DishesMainTableViewCell" owner:nil options:nil] firstObject];
        }//颜色前三行的不一样 要修改
        if (indexPath.row == 2 ) {
            cell1.backgroundColor = [UIColor colorWithRed:246 - (indexPath.row * 10)/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        }else if(indexPath.row == 0){
            cell1.backgroundColor = [UIColor colorWithRed:240/255.0 green:247 / 255.0 blue:253 / 255.0 alpha:1];
        }else if(indexPath.row == 1){
            cell1.backgroundColor = [UIColor colorWithRed:251 / 255.0 green:240 / 255.0 blue:236 / 255.0 alpha:1];
        }
        if (self.quanbuArr.count) {
             ShuJuPG * dishes = self.quanbuArr[indexPath.row];
            cell1.model = dishes;
            cell1.rankingLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        }
        else{
            ShuJuPG *dishes = nil;
            cell1.model = dishes;
            cell1.rankingLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        
        }
       

        
        return cell1;
    }
    
    
}

//设置每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2) {
        if (indexPath.row == 0) {
            return 100;
        }else{
            return 60;
        }
//        return ((580.0 - 99.0) / _topArr.count);
    }else if (tableView.tag == 1){
        
        return 39.1f;
    }
    return 0;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 2) {
        
        if (indexPath.row == 0) {
            //将cateID置空
            self.categoryID = nil;
            [self setMenuContentWithDate:_date];
        }
        else{
            _categoryID = self.topArr[indexPath.row - 1];
            NSLog(@"%@",_categoryID.categoryId);
            [self setMenuContentWithDate:_date];
        }
        
    
      
    }
    
}

- (void)setcaipinleixing{
    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=&returnJson=json",ceshiIP];
//  NSLog(@"test:%@",urlString);
    
    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {
        
        self.topArr = [NSMutableArray array];
       NSLog(@"receive:%@",responseObject);
        NSArray *tempArr = [responseObject objectForKey:@"dishesCategorys"];
        
        for (NSDictionary *dic in tempArr) {
            topRG * topModel = [[topRG alloc]initWithDictionary:dic];
            [_topArr addObject:topModel];
        }
        NSLog(@"testtopArr :%@",self.topArr);
        //要了做啥 ？
//        _categoryID = self.topArr[0];
//        NSLog(@"test count:%ld  top array:%@", self.topArr.count,_categoryID.categoryName );
        [self.zongCaiDan reloadData];

    } failure:^(NSError *error) {
        NSLog(@"-%@",error);
    }];
}

- (void)setDate:(NSString *)date{
    _date = date;
   
}

- (void)setMenuContentWithDate:(NSString *)date{
    NSString *urlStr = nil;
    if (self.startDate) {
        if (self.categoryID.categoryId) {
            urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/iosList?pageType=&categoryId=%@&sorting=%@&startDate=%@&endDate=%@&returnJson=json",ceshiIP,self.categoryID.categoryId,self.orderBy,self.startDate,self.endDate];
        }else{
            urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/iosList?pageType=&categoryId=&sorting=%@&startDate=%@&endDate=%@&returnJson=json",ceshiIP,self.orderBy,self.startDate,self.endDate];
                   NSLog(@"111%@",urlStr);
            
        }
        
    } else {
        if (self.categoryID.categoryId) {
            urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/iosList?pageType=%@&categoryId=%@&sorting=%@&startDate=&endDate=&returnJson=json",ceshiIP,self.todayOrSevenDay,self.categoryID.categoryId,self.orderBy];
        }else{
            urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/iosList?pageType=%@&categoryId=&sorting=%@&startDate=&endDate=&returnJson=json",ceshiIP,self.todayOrSevenDay,self.orderBy];
                    NSLog(@"urlStr%@",urlStr);
            
        }
    }
 
    
    
//   NSLog(@"+++++++++++++++++++%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
NSLog(@"33333333%@",responseObject);
//        _quanbuArr = [NSMutableArray array];
        _quanbuArr = [NSMutableArray arrayWithCapacity:0];
        NSArray *dinerBillDisheSet = [responseObject objectForKey:@"dinerBillDisheSet"];
        NSArray *dinerBillDishe = [responseObject objectForKey:@"dinerBillDishe"];
        for (NSDictionary *dic in dinerBillDisheSet)
        {
            
            ShuJuPG *model =[[ShuJuPG alloc] initWithDictionary:dic];
            [_quanbuArr addObject:model];
        }
        //NSLog(@"test The Whole:%@",self.quanbuArr);
        for (NSDictionary *dic in dinerBillDishe)
        {
            
            ShuJuPG *model = [[ShuJuPG alloc]initWithDictionary:dic];
            [_quanbuArr addObject:model];
        }
        
//        if (_top10) {
//            _quanbuArr = [[_quanbuArr sortedArrayUsingComparator:^NSComparisonResult(ShuJuPG *obj1, ShuJuPG *obj2) {
//                if ([obj1.shuLiang integerValue] < [obj2.shuLiang integerValue]) {
//                    return NSOrderedDescending;
//                } else {
//                    return NSOrderedAscending;
//                }
//            }] copy];
//        }else{
//            _quanbuArr = [[_quanbuArr sortedArrayUsingComparator:^NSComparisonResult(ShuJuPG *obj1, ShuJuPG *obj2) {
//                if ([obj1.shuLiang integerValue] > [obj2.shuLiang integerValue]) {
//                    return NSOrderedDescending;
//                } else {
//                    return NSOrderedAscending;
//                }
//            }] copy];
//            
//        }
//        if (_quanbuArr.count >10) {
//            NSRange range = NSMakeRange(1, 2);
//            NSArray *temp = [_quanbuArr subarrayWithRange:range];
//            _quanbuArr = [temp copy];
//        }
        DLog(@"%@",_quanbuArr);
       
       [self.caiPinShuLiang reloadData];
    
        

    } failure:^(NSError *error) {
        
    }];
  

};
//第二套接口
//- (void)setMenuContentWithDate:(NSString *)date{
//    NSString * caipinStr = @"";
//    NSString * caipinId = @"";
//    if ([_categoryID.categoryName isEqualToString:@"套餐"]) {
//        caipinStr = @"dsId";
//        caipinId = _categoryID.dsId;
//    }else{
//        caipinStr = @"categoryId";
//        caipinId = _categoryID.categoryId;
//    }
//    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/report/yyfx/iosList?pageType=%@?%@=%@&returnJson=json",ceshiIP,date,caipinStr,caipinId];
//    
//    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//        _quanbuArr = [NSMutableArray arrayWithCapacity:0];
//        NSArray *dinerBill = [NSArray array];
//        if ([caipinStr isEqualToString:@"套餐"]) {
//            
//            dinerBill = [responseObject objectForKey:@"dinerBillDisheSet"];
//        }else{
//            dinerBill = [responseObject objectForKey:@"dinerBillDishe"];
//        }
//        for (NSDictionary *dic in dinerBill) {
//            
//            ShuJuPG *model =[[ShuJuPG alloc] initWithDictionary:dic];
//            [_quanbuArr addObject:model];
//        }
//        if (_top10) {
//            _quanbuArr = [[_quanbuArr sortedArrayUsingComparator:^NSComparisonResult(ShuJuPG *obj1, ShuJuPG *obj2) {
//                if ([obj1.shuLiang integerValue] < [obj2.shuLiang integerValue]) {
//                    return NSOrderedDescending;
//                } else {
//                    return NSOrderedAscending;
//                }
//            }] copy];
//        }else{
//            _quanbuArr = [[_quanbuArr sortedArrayUsingComparator:^NSComparisonResult(ShuJuPG *obj1, ShuJuPG *obj2) {
//                if ([obj1.shuLiang integerValue] > [obj2.shuLiang integerValue]) {
//                    return NSOrderedDescending;
//                } else {
//                    return NSOrderedAscending;
//                }
//            }] copy];
//            
//        }
//        if (_quanbuArr.count >10) {
//            NSRange range = NSMakeRange(1, 2);
//            NSArray *temp = [_quanbuArr subarrayWithRange:range];
//            _quanbuArr = [temp copy];
//        }
//        [self.caiPinShuLiang reloadData];
//        
//    } failure:^(NSError *error) {
//        
//    }];
//
//}


//这是一个单例
- (NSMutableArray *)quanbuArr{
    if (_quanbuArr == nil) {
        
        _quanbuArr = [NSMutableArray array];
    }
    return _quanbuArr;
}

- (IBAction)Under:(UIButton *)sender {
    self.top.backgroundColor = [UIColor clearColor];
    [self.top setTitleColor:[UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    [self.under setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.under.backgroundColor = [UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1];
    _top10 = NO;
    self.orderBy = @"asc";
    [self setMenuContentWithDate:_date];
}

- (IBAction)Top:(UIButton *)sender {
    self.top.backgroundColor = [UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1];
    [self.top setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.under.backgroundColor = [UIColor clearColor];
    [self.under setTitleColor:[UIColor colorWithRed:35/255.0 green:122/255.0 blue:234/255.0 alpha:1] forState:UIControlStateNormal];
    _top10 = YES;
    self.orderBy = @"desc";
    [self setMenuContentWithDate:_date];
}
@end
