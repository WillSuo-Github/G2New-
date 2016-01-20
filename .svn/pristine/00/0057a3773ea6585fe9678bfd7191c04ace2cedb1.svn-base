    //
    //  WaiMaiDingdanController.m
    //  G2TestDemo
    //
    //  Created by lcc on 15/9/9.
    //  Copyright (c) 2015年 ws. All rights reserved.
    //

#import "WaiMaiDingdanController.h"
#import "WaiMaiDingdanCell.h"
#import "NDLBusinessConfigure.h"
#import "ZhiFuViewController.h"
#import "CaiPinCell.h"
#import "HttpTool.h"
#import "WaiMaiPG.h"
#import "MJExtension.h"
#import "WaiMaiDetalPG.h"
#import "MainViewController.h"
#import "ZhiFuChuanDiPG.h"


#define waimaiWidth 690
@interface WaiMaiDingdanController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    BOOL waimaiDetilHidden;
    BOOL waimaiHidden;
    BOOL _isRefreshiang;
    
}

@property (nonatomic, assign) int selRowInDingDanView;


@property (nonatomic, strong) NSMutableArray *orderListArr;

@property(nonatomic,strong)ZhiFuViewController *zhiFuViewController;

@property (weak, nonatomic) IBOutlet UILabel *zongjineLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *peisongyuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *fapiaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *beizhuLabel;
@property (nonatomic, copy) NSString *billID;

@end

@implementation WaiMaiDingdanController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSongWaiMai];
    
    //接收通知代理 wjy
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(qingchuwaimai) name:Kqingchuwaimai object:nil];
    
    self.payMoneyButton.backgroundColor = [UIColor colorWithRed:79/255.0 green:152/255.0 blue:228/255.0 alpha:1];
    self.payMoneyButton.layer.cornerRadius = 5;
    [self.payMoneyButton setTitle:@"结账" forState:UIControlStateNormal];

    
    
    [self.payMoneyButton addTarget:self action:@selector(checkoutClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.waiMaiOrderInfoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_CaiPinView.separatorStyle = UITableViewCellSeparatorStyleNone;


    //self.textView.constraints = 10;
    self.searchBarTextField.layer.borderWidth = 1;
    self.searchBarTextField.layer.borderColor = [[UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:1]CGColor];
    self.searchBarTextField.returnKeyType = UIReturnKeyDone;
    self.searchBarTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.searchBarTextField.clearsOnBeginEditing = YES;
    self.searchBarTextField.delegate = self;
    self.searchBarTextField.layer.cornerRadius = 15.0;
    self.CaiPinView.scrollEnabled = YES;
    self.moreButton.layer.masksToBounds = YES;
    [self.moreButton addTarget:self action:@selector(moreBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.moreButton.hidden = YES;
    
    
   
     
    
    
}

//删除通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:Kqingchuwaimai object:nil];

}

//清台 王京阳
-(void)qingchuwaimai{
    
    if (self.quanbuArr.count > _selRowInDingDanView) {
        [self.quanbuArr removeObjectAtIndex:_selRowInDingDanView];
    }
    
    [self.waiMaiOrderInfoList reloadData];
    

    [self.orderListArr removeAllObjects];
    [self.CaiPinView reloadData];
    
    self.addressLabel.text=@"";
    self.beizhuLabel.text=@"";
    self.peisongyuanLabel.text=@"";
    self.fapiaoLabel.text=@"";
    self.zongjineLabel.text=@"";
    
}

- (IBAction)tianjiawaimai:(id)sender {
    
    
    MainViewController *mainVc = [MainViewController sharedMainView];

    UIButton *btn = [[UIButton alloc] init];
    btn.tag = 1;
    [mainVc BottomViewDidChick:nil withButton:btn whereFromStr:kWaiMaiFromStr];
    
}

/**
 *  外卖结账按钮
 */
-(void)checkoutClick:(UIButton *)sender
{

    self.zhiFuViewController = [[ZhiFuViewController alloc]init];

    UINavigationController *navigationC = [[UINavigationController alloc]initWithRootViewController:self.zhiFuViewController];
    navigationC.modalPresentationStyle = UIModalPresentationPageSheet;

    UIButton *titleButton = [[UIButton alloc]init];
    ZhiFuChuanDiPG *chuandipg = [[ZhiFuChuanDiPG alloc] init];
    chuandipg.count = self.zongjineLabel.text;
    chuandipg.whereFrom = kWaiMaiJieZhangFromStr;
    chuandipg.billID = self.billID;
    self.zhiFuViewController.chuandiPG = chuandipg;
//    self.zhiFuViewController.count = self.zongjineLabel.text;
//    self.zhiFuViewController.whereFrom = kWaiMaiJieZhangFromStr;
//    self.zhiFuViewController.billID = self.billID;
    self.navigationItem.titleView = titleButton;
    
    
    [self presentViewController:navigationC animated:YES completion:nil];

}

-(void)leftButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)moreBtn:(id)sender {
    
    
    
    if ([_delegate respondsToSelector:@selector(WaiMaiDingdanControllerDidChickMore:)]) {
        
        [self.delegate WaiMaiDingdanControllerDidChickMore:self];
        self.moreButton.hidden = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)requestWaiMaiInfoWith:(WaiMaiPG *)waimaipg{
    
    
    
    //modify by manman for start of line
    // 总计 金额 显示不正确
    
    if (waimaipg.billId == NULL) {
        waimaipg.billId = @"";
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?billId=%@&billType=2&returnJson=json",ceshiIP,waimaipg.billId];
    NSLog(@"waimai  order detail  list %@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {

        NSLog(@"waimai  order detail  list:%@",responseObject );
        NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
        // 获得菜品信息
        self.orderListArr = [WaiMaiDetalPG mj_objectArrayWithKeyValuesArray:arr];
        
        
        // 获得小计  即 订单总价 金额
        NSDictionary *dict = [responseObject objectForKey:@"newBill"];
        NSString *amount  = [NSString stringWithFormat:@"%.2f",[[dict objectForKeyedSubscript:@"oriCost"] floatValue]];
        NSLog(@"amount :%@",amount);
        NSLog(@"  2 amount :%f",[[dict objectForKeyedSubscript:@"oriCost"] floatValue]);
        waimaipg.totalCost = [NSString stringWithFormat:@"%@",amount];
        
        //获得0配送员  1备注 2发票
        @try {
            NSArray *expressAndInvoiceTitleAndCustomerMessageInfo = [responseObject objectForKey:@"takeout"];
//            NSArray *expressAndInvoiceTitleAndCustomerMessage = [expressAndInvoiceTitleAndCustomerMessageInfo firstObject];
               NSString *expressPersoner = [expressAndInvoiceTitleAndCustomerMessageInfo objectAtIndex:0];
                NSString *customMessage = [expressAndInvoiceTitleAndCustomerMessageInfo objectAtIndex:1];
                NSString *InvoiceTitle = [expressAndInvoiceTitleAndCustomerMessageInfo objectAtIndex:2];
                self.beizhuLabel.text = customMessage;
                self.fapiaoLabel.text = InvoiceTitle;
                // 修改配送员
                self.peisongyuanLabel.text = expressPersoner;//waimaipg.contactName
           
            self.addressLabel.text = waimaipg.sendAddress;
           
            self.zongjineLabel.text = waimaipg.totalCost;

             NSLog(@"waimaipg.totalCost:%@",waimaipg.totalCost);
        }
        @catch (NSException *exception) {
            NSLog(@"Erro key is null");
        }
        
       
        
        
        
        // 获得配送员
//        
//        NSLog(@"sendAddress:%@",waimaipg.sendAddress);
//        NSLog(@"sendAddress:%@",waimaipg.contactName);
//        NSLog(@" waimai amount :%@",waimaipg.totalCost);
        
     
        [self.CaiPinView reloadData];
        
        
        
        // end of line
            
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}



#pragma mark - tableView的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        //    return self.quanbuArr.count;
    if (tableView == self.waiMaiOrderInfoList) {
        
       // NSLog(@"waimai  order count :%ld ",self.quanbuArr.count);
        return self.quanbuArr.count;
        //return 10;
    }else{
        

        return self.orderListArr.count;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.waiMaiOrderInfoList) {
        
        
        self.moreButton.hidden = YES;
        static NSString *ID = @"Cell";
        
        WaiMaiDingdanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil)
        {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"WaiMaiDingdanCell" owner:nil options:nil ]firstObject];
        }
        WaiMaiPG * waimai = self.quanbuArr[indexPath.row];
        
        cell.model = waimai;
        
        return cell;
    }
    else
        {
            //        CaiPinCell *cell = [CaiPinCell cellWithTableView:tableView];
            //
            //        cell.textLabel.text = @"test---------";
            //
            //        return cell;
        self.moreButton.hidden = NO;
        
        static NSString *idStr = @"idStr";
        
        WaiMaiOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:idStr];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"WaiMaiOrderListCell" owner:nil options:nil]firstObject];
            
        }
        WaiMaiDetalPG *waimaiDetal = self.orderListArr[indexPath.row];
//        NSLog(@"%@---%@",waimaiDetal.dishesName,waimaiDetal.oriCost);
        cell.dishNameLabel.text = [NSString stringWithFormat:@"%@",waimaiDetal.dishesName];
        cell.dishPrice.text = [NSString stringWithFormat:@"%@",waimaiDetal.oriCostStr];
        
        
        return cell;
        }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.moreButton.hidden = YES;

    // self.moreButton.hidden = NO;
    if (tableView == self.waiMaiOrderInfoList)
    {
        self.selRowInDingDanView = indexPath.row;
        
        WaiMaiPG *waimaiPG = self.quanbuArr[indexPath.row];
        
        self.billID = waimaiPG.billId;
        [self requestWaiMaiInfoWith:waimaiPG];
        
       
        
        [self CaiPinCellAppear];

    }


}



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.moreButton.hidden == NO) {
        self.moreButton.hidden = YES;
    }else{
        self.moreButton.hidden = NO;
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    

    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    
    
    }
    
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
    
}


-(void)CaiPinCellAppear
{
    CGFloat waimaiH = 668;
//    CGFloat waimaiW = 460;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.view.frame = CGRectMake(kScreenWidth -690, 100, waimaiWidth, waimaiH);
        waimaiDetilHidden = NO;
    }];
}

    //-(void)CaiPinViewRequestAndRefresh:(NSString *)billId
    //{
    //    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?returnJson=json&billId=%@",ceshiIP,billId];
    //}


- (void)setSongWaiMai{
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/takeout/ajax/takeoutContent?returnJson=json&billStatus=-1&pageSize=200&page=1",ceshiIP];
    NSLog (@" waimai oeder list  %@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"waimai response object :%@",responseObject);
        _quanbuArr = [NSMutableArray array];
        NSDictionary *takeoutList = [responseObject objectForKey:@"takeoutList"];
        NSArray *content = [takeoutList objectForKey:@"content"];
        self.quanbuArr = [WaiMaiPG mj_objectArrayWithKeyValuesArray:content];
        [self.waiMaiOrderInfoList reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSMutableArray *)quanbuArr{
    
    if (_quanbuArr == nil) {
        _quanbuArr = [NSMutableArray array];
    }
    return _quanbuArr;
}

- (NSMutableArray *)caiPinArr{
    if (_caiPinArr == nil) {
        _caiPinArr = [NSMutableArray array];
    }
    return _caiPinArr;
}

- (NSMutableArray *)orderListArr{
    
    if (_orderListArr == nil) {
        _orderListArr = [NSMutableArray array];
    }
    return _orderListArr;
}



#pragma UITextFieldDelegate

/**
 *  此方法  实现 条件搜索
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchBarTextField resignFirstResponder];
    
    if (self.searchBarTextField.text.length >0) {
        BOOL isSuccess = [self isPureInt:textField.text];
        if (!isSuccess)  return YES;
    }
    
    [self getConditionSearchTextResult:textField.text];
    
    //self.searchBarTextField.text = @"";
    
    return YES;
}


- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}


/**
 *  此方法  实现 条件搜索
 *  出现手势冲突
 */
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [self.searchBarTextField resignFirstResponder];
//    [self getConditionSearchTextResult:textField.text];
//     self.searchBarTextField.text = @"";
//    
//}


-(void)getConditionSearchTextResult:(NSString *)conditionText
{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/takeout/ajax/takeoutContent?returnJson=json&billStatus=-1&pageSize=200&page=1&keyWords=%@",ceshiIP,conditionText];
    
    NSLog(@"waimai request condition info:%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"waimai condition info responseObject:%@",responseObject);
        _quanbuArr = [NSMutableArray array];
        NSDictionary *takeoutList = [responseObject objectForKey:@"takeoutList"];
        NSArray *content = [takeoutList objectForKey:@"content"];
        self.quanbuArr = [WaiMaiPG objectArrayWithKeyValuesArray:content];
        [self.waiMaiOrderInfoList reloadData];
        
        //11-17
        //将文本框中的数据清空 以待下次查询
        //self.searchBarTextField.text = @"";
        //
        
    } failure:^(NSError *error) {
        
    }];
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    }
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    [self.moreButton removeFromSuperview];
//    [self.view sendSubviewToBack:self.moreButton];
    [self.bigView sendSubviewToBack:self.moreButton];
    
    
    
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
