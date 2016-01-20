//
//  YuDingFirstViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/23.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "YuDingFirstViewController.h"
#import "YuDingCell.h"
#import "HttpTool.h"
#import "YuDingList.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "DXKeyboard.h"
#import "MiniPosSDK.h"
#import "UIUtils.h"
#import "TimeTool.h"

@interface YuDingFirstViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,DXKeyboardDelegate>{
    
    NSInteger _pageCount;
    NSInteger _allPageCount;
    NSString *_urlString;
    NSInteger _pageSize;
}
@property (weak, nonatomic) IBOutlet UIImageView *ssImage;
//@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UITextField *searbar;

@property (weak, nonatomic) IBOutlet UIButton *delButton;

/**
 *  对内的数据信息保存数组
 */
@property (nonatomic, strong) NSMutableArray *listArr;

//预定字体颜色
@property (weak, nonatomic) IBOutlet UILabel *yudingdanhao;
@property (weak, nonatomic) IBOutlet UILabel *cantai;
@property (weak, nonatomic) IBOutlet UILabel *yudingren;
@property (weak, nonatomic) IBOutlet UILabel *shoujihao;
@property (weak, nonatomic) IBOutlet UILabel *jiucanrenshu;
@property (weak, nonatomic) IBOutlet UILabel *yudingshijian;
@property (weak, nonatomic) IBOutlet UILabel *yudingyajin;
@property (weak, nonatomic) IBOutlet UILabel *yudinglaiyuan;

@property (weak, nonatomic) IBOutlet UILabel *shifoudiancan;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtai;

@property (strong,nonatomic)NSMutableArray *searchConditionTextReusltArray;
@property (strong, nonatomic)UITextField *isBeingEditingTextField;


@end

@implementation YuDingFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加数字键盘  王京阳
    DXKeyboard *jianpanView=[[DXKeyboard alloc]init];
    jianpanView.delegate=self;
    self.searbar.delegate=self;
    [self.searbar setInputView:jianpanView];

    
    
    
    
    //搜索框的颜色
    self.searbar.layer.borderWidth=1;
    self.searbar.layer.borderColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1].CGColor;
    self.yudingdanhao.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.cantai.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingren.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.shoujihao.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.jiucanrenshu.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingshijian.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingyajin.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudinglaiyuan.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.shifoudiancan.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.zhuangtai.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    for (UIView *view in [self.searbar subviews]) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")]) {
            if (view.subviews.count>0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                
            }
        }
    }
    
    
    
    self.searbar.delegate = self;
    
    
    
    
    //删除多余横线
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    // Do any additional setup after loading the view from its nib.
    _pageSize = 3;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestYuDingList)];
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
//    [self requestYuDingList];
    [self setSearchTextField];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderListReload:) name:@"update" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
//    [self requestYuDingList];
   // self.searbar.text = @"";
    [self.tableView.header beginRefreshing];
}

- (void)setSearchTextField{

    self.searbar.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
//    _searchBar.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hlk_ss3"]];
//    _searchBar.rightViewMode = UITextFieldViewModeAlways;//leftViewMode
    [self.searbar addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged]; // textField的文本发生变化时相应事件
    //    设置ReturnKeyType为UIRetuirKeySearch ：
    [self.searbar setReturnKeyType:UIReturnKeySearch];
   // [self.searbar setReturnKeyType:UIReturnKeySearch];
    //    设置UITextField的delegate为self：
//    self.searchBar.layer.borderWidth=0;
//    self.searchBar.layer.borderColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1].CGColor;
    
    self.searbar.delegate=self;
}
//响应点击搜索按钮的响应事件的函数
- (BOOL)textFieldShouldReturn:(UITextField*)theTextField {
    
    [self.searbar resignFirstResponder];
    [self getConditionSearchResultMethod:theTextField.text];
    

    return YES;
}

//textField的文本内容发生变化时，处理事件函数
- (void) textFieldDidChange:(UITextField*) TextField{
    NSLog(@"textFieldDidChange textFieldDidChange");
    if(![TextField.text isEqualToString:@""]) {
        _delButton.hidden=NO;  // 仿制searchbar后面的小叉叉
    } else{
        _delButton.hidden=YES;
    }
}


- (void)requestYuDingList{
    
     //self.searbar.text = @"";
    
    NSString *url = @"canyin-frontdesk/order/ajax/order/list?returnJson=json&sortCol=createTime&direction=desc";
    url = [NSString stringWithFormat:@"%@/%@",ceshiIP,url];
    NSLog(@"request order book  url:%@",url);
    
    // 11-17 delete  这个变量  没有使用
//    NSString *url1 = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/order/list?returnJson=json",ceshiIP];
//    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/order/list?returnJson=json",ceshiIP];
    
    
// end of line
    if (self.getUrl == nil)
    {
        self.getUrl = url;
    }
    else
    {
        url = [self.getUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    _urlString = url;
    [HttpTool GET:url parameters:nil success:^(id responseObject) {
//    NSLog(@"%@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"tableOrders"];
       _allPageCount = [[dict objectForKey:@"totalPages"] integerValue];
        NSArray *arr = [dict objectForKey:@"content"];
        self.listArr = [YuDingList objectArrayWithKeyValuesArray:arr];
        
        
//        NSLog(@"%@",self.listArr);

        [self.tableView reloadData];
        _pageCount = 2;
        [self.tableView.header endRefreshing];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
  
}

- (void)requestMore{
    
    //没有数据时候提示  王京阳
     //self.searbar.text = @"";
    NSLog(@"%@",self.searbar);
    if (_pageCount == _allPageCount + 1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已到底部" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        [self.tableView.footer endRefreshing];
        return;

    }
    
    
    
   
  //下拉刷新添加新的数据    王京阳
    
       // NSString *urlstr = [NSString stringWithFormat:@"%@&page=%ld",_urlString,_pageCount];
     NSString *urlstr = [NSString stringWithFormat:@"%@&page=%ld",self.getUrl,_pageCount];
    NSLog(@"requset more url :%@",urlstr);
        [HttpTool GET:urlstr parameters:nil success:^(id responseObject) {
            
        //NSLog(@"-------%@",responseObject);
            NSDictionary *dict = [responseObject objectForKey:@"tableOrders"];
            NSArray *arr = [dict objectForKey:@"content"];
            arr=[YuDingList objectArrayWithKeyValuesArray:arr];
            [self.listArr addObjectsFromArray:arr];
            [self.tableView reloadData];
            _pageCount+=1;
            [self.tableView.footer endRefreshing];
        
            
 //           [self.listArr addObjectsFromArray:arr];
//            NSIndexPath *index = [NSIndexPath indexPathForRow:(_pageCount - 1) * 10 inSection:0];
//            [self.listArr insertObject:arr atIndex:index.row];
//            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index.row];
//            [self.listArr insertObjects:arr atIndexes:indexSet];
//            NSArray *insertIndex = [NSArray arrayWithObjects:index, nil];
//            [self.tableView insertRowsAtIndexPaths:insertIndex withRowAnimation:UITableViewRowAnimationLeft];
            
          } failure:^(NSError *error) {
            
            NSLog(@"%@",error);
        }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setDataArr:(NSArray *)dataArr{
    
    _dataArr = dataArr;
    self.listArr = [NSMutableArray arrayWithArray:dataArr];
    
    [self.tableView reloadData];
//    NSLog(@"^^^^^%@",dataArr);
}

#pragma mark - tableView的数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.listArr.count;
    //return 100;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    YuDingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"YuDingCell" owner:nil options:nil];
        cell = [arr lastObject];
        
        
        
        //灰白相间
        if (indexPath.row%2) {
            cell.backgroundColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        } else {
            
            cell.backgroundColor=[UIColor whiteColor];
        }
       
        
    }
    cell.list = self.listArr[indexPath.row];
    return cell;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
         
}-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YuDingCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[cell.list mj_keyValues]];
    //蓝牙传递
    NSString *orderPeopleName = dic[@"orderPeopleName"];
    NSString *telphone = dic[@"telphone"];
    NSString *orderTime = dic[@"orderTime"];
    NSString *ordertime = [TimeTool JiaoYizhuanhuanshijian:orderTime];
    NSString *tabNo = dic[@"tabNo"];
    NSString *str = [NSString stringWithFormat:@"1:%@,%@,%@,%@",orderPeopleName,telphone,tabNo,ordertime];
     char *str1 =[UIUtils UTF8_To_GB2312:str];
    //[self initBLESDK];
    //MiniPosSDKInit();
    //NSLog(@"LoginViewController-host:%s,port:%d",host.UTF8String,port.intValue);
    //MiniPosSDKSetPublicParam(shangHu.UTF8String, zhongDuan.UTF8String, caoZhuoYuan.UTF8String);
    // MiniPosSDKSetPostCenterParam(host.UTF8String, port.intValue, 0);
    
    //MiniPosSDKRegisterDeviceInterface(GetBLEDeviceInterface());
    
   // [self addSDKDelegate];
    MiniPosSDKCreateWindow(str1);

  //[self removeSDKDelegate];
    NSLog(@"yuding  info %@",dic);
    
    //   WithObjects:cell.list.orderNo forKeys:@"orderNo"];
    
//    [[NSNotificationCenter defaultCenter]postNotificationName:Kquxiaoyudingbutton object:nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:Kquxiaoyudingbutton object:nil userInfo:dic];
    
    

}


- (NSMutableArray *)listArr{
    
    if (_listArr == nil) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

-(void)orderListReload:(NSNotification *)info
{
      NSLog(@"receive notification");
   [self.tableView.header beginRefreshing];
    
  
    
}


/**
 *  这个方法  做条件搜索
 *
 *
 */
#pragma UItextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    _pageCount = 2;
    
    NSLog(@"self.geturl:%@",self.getUrl);
    //这是从预定控制器 传递过来的URL 这个URL 即是当前数据的接口
    // 在这个接口 后面添加关键字  即可获得 符合搜索条件的数据信息
    
    [self getConditionSearchResultMethod:textField.text];
    
    
    
    
//    
//    
//    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//        NSDictionary *dict = [responseObject objectForKey:@"tableOrders"];
//        //        _allPageCount = [dict objectForKey:@"totalPages"];
//        NSArray *arr = [dict objectForKey:@"content"];
//        self.listArr = [YuDingList objectArrayWithKeyValuesArray:arr];
//        
//        
//        //        NSLog(@"%@",self.listArr);
//        
//        [self.tableView reloadData];
//        _pageCount = 2;
//        [self.tableView.header endRefreshing];
//        
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//    }];
    
    
}




-(void)getConditionSearchResultMethod:(NSString *)conditionStr
{
    
//    NSString *urlStr1  = [NSString stringWithFormat:@"%@/canyin-frontdesk/order/ajax/order/list?returnJson=json&sortCol=createTime&direction=desc&kewWords=%@",ceshiIP,conditionStr];
    
    
    //判断是否 有搜索关键字
    if ([self.getUrl rangeOfString:@"kewWords"].location == NSNotFound) {
        NSString *urlStr = [NSString stringWithFormat:@"%@&kewWords=%@",self.getUrl,conditionStr];
        self.getUrl = [NSString stringWithFormat:@"%@",urlStr];
        NSLog(@"condition result url  before :%@",urlStr);
    }
    else
    {
        // 替换搜索关键字
        NSRange keyWord = [self.getUrl rangeOfString:@"kewWords="];
        NSString *mainUrl = [self.getUrl substringToIndex:[self.getUrl rangeOfString:@"kewWords="].location];
        NSString *urlStr = [NSString stringWithFormat:@"%@kewWords=%@",mainUrl,conditionStr];
        self.getUrl = [NSString stringWithFormat:@"%@",urlStr];
        
    }
    
    NSLog(@"condition result url :%@",self.getUrl);
    
    
    [HttpTool GET:self.getUrl parameters:nil success:^(id responseObject) {
        
        //NSLog(@"condition result %@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"tableOrders"];
        //        _allPageCount = [dict objectForKey:@"totalPages"];
        NSArray *arr = [dict objectForKey:@"content"];
        self.listArr = [YuDingList objectArrayWithKeyValuesArray:arr];
        
        for (YuDingList *personBookInfo in self.listArr) {
          //  NSLog(@"telphone:%@",personBookInfo.telphone);
        }
        
        
        
       // NSLog(@"condition  result info :%@",self.listArr);
        //if(self.listArr.count>0)
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
        NSLog(@" condition search result error :%@ ",[error localizedDescription]);
    }];
    
    
    
    
    
}

//添加数字键盘搜索
#pragma mark -- 数字键盘
- (void)numberKeyBoardInput:(NSInteger) number
{
    if (self.isBeingEditingTextField.text.length >10) {
        return;
        
    }
    //    DebugLog(@"string number : %d",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",self.isBeingEditingTextField.text,(long)number];
        self.isBeingEditingTextField.text = textString;
    }if (number == 11) {
        if (self.isBeingEditingTextField.text.length==10)return;
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",self.isBeingEditingTextField.text];
        
        self.isBeingEditingTextField.text = textString;
        
    }
    //    if (number == 10) {
    //        //不能入点
    //
    //        if (self.lianxidianhua.text.length==0) return;
    //        if (self.beiyongdianhua.text.length==0) return;
    //
    //        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",self.isBeingEditingTextField.text];
    //                self.isBeingEditingTextField.text = textString;
    //
    //        //更改结束 wjy
    //    }
    if (number == 12) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",self.isBeingEditingTextField.text];
        
        self.isBeingEditingTextField.text = textString;
        
        
        
    }
}

- (void)xiaqufangfa{
    
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    self.isBeingEditingTextField = textField;
    
}

- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", self.isBeingEditingTextField.text];
    
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    self.isBeingEditingTextField.text = mutableString;
    
}

- (void)numberKeyBoardFinish
{
    //    DebugLog(@"finished.......");
    [self.searbar resignFirstResponder];
    
}

- (void)bgButtonClick27703784131
{
    
    [self.searbar resignFirstResponder];
    
    
    
}
- (void) numberKeyBoardShou{
    [self xiaqufangfa];
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
