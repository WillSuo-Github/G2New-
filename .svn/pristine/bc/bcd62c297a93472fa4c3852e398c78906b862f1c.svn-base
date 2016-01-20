//
//  LBHandySearchMainTableController.m
//  KTAPP
//
//  Created by admin on 15/7/16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NDLCashPayNavController.h"
#import "G1WeiXinPayViewController.h"
@interface NDLCashPayNavController ()
@property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;

@end
@implementation NDLCashPayNavController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title=@"周边查找";
    [super viewDidLoad];
    BSTableSection *bsTable=[BSTableSection initWithHeaderVcClassContent:@"支付"//章节显示标题
                                                               imageName:nil//章节显示图标
                                                         headerViewClass:nil//章节显示视图
                                                          cellIdentifier:@"BSUIFiveBotColTableViewCell"//采用的TableViewCell
                                                               cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                                                              storyboard:@"LSBLEIFTTUpHoldMain"
                                                          colCapatibilty:4//每个章节的row数量
                                                               bsContent:nil];
    
    
    
    BSTableContentObject *bleDevices=[BSTableContentObject
                                      initWithContentObject:@"支付"
                                      methodName:nil
                                      imageName:@"sns_sweep"
                                      vcClass:@"BLEDevicesTableViewController"];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支付"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"二维码、条码"
                methodName:nil
                imageName:@"cashier_6"
                vcClass:nil];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支付"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"   账单"
                methodName:nil
                imageName:@"cashier_10"
                vcClass:nil];
    
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支付"];
    
    //GatheringViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"银行卡收款"
                methodName:nil
                imageName:@"yl"
                vcClass:@"GatheringViewController"];
    bleDevices.storybordName=@"Main";// .storyboard
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"无卡收款"
                methodName:nil
                imageName:@"none_card"
                vcClass:nil];
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    
    //BTLECentralViewController
    bleDevices=[BSTableContentObject
                initWithContentObject:@"支付宝收款"
                methodName:nil
                imageName:@"taobao"
                vcClass:nil];
    bleDevices.storybordName=@"NDLG1ThirdPay";// .storyboard
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    

    bleDevices=[BSTableContentObject
                initWithContentObject:@"银联钱包"
                methodName:nil
                imageName:@"syt_yr_money"
                vcClass:nil];
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"微信收款"
                methodName:nil
                imageName:@"syt_wx"
                
                colClass:[G1WeiXinPayViewController class]];
    bleDevices.noNeedLoginCheck=YES;
//    bleDevices=[BSTableContentObject
//                initWithContentObject:@"微信收款"
//                methodName:nil
//                imageName:@"syt_wx"
//                vcClass:@"G1WeiXinPayViewController"];
//    bleDevices.storybordName=@"NDLG1ThirdPay";// .storyboard
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"百度钱包"
                methodName:nil
                imageName:@"baidu"
                vcClass:nil];
    bleDevices.storybordName=@"NDLG1ThirdPay";// .storyboard
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"垫资还款"
                methodName:nil
                imageName:@"syt_dz"
                vcClass:nil];
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"当日收"
                methodName:nil
                imageName:@"drs"
                vcClass:nil];
    
    
    [bsTable addBSTableContent:bleDevices sectionHeader:@"收款"];


    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"轮播图收银台" methodName:nil imageName:nil
                                                                         colClass:nil];
    //广告
    [self addImagePlay];
    lifeService.noNeedLoginCheck=YES;
    lifeService.colCapatibilty=1;
    //添加轮播

    lifeService.display=self.imagePlayer ;
    [bsTable addBSTableContent:lifeService sectionHeader:@"收银台轮播广告"];
    
    //
    bleDevices=[BSTableContentObject
                initWithContentObject:@"信用还款"
                methodName:nil
                imageName:@"syt_dz"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"  手机充值"
                methodName:nil
                imageName:@"cashier_3"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"   充流量"
                methodName:nil
                imageName:@"cashier_12"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"余额查询"
                methodName:nil
                imageName:@"cashier_9"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"游戏充值"
                methodName:nil
                imageName:@"cashier_14"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"机票飞机票"
                methodName:nil
                imageName:@"cashier_11"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"公共缴费"
                methodName:nil
                imageName:@"cashier_6"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    
    bleDevices=[BSTableContentObject
                initWithContentObject:@"交易查询"
                methodName:nil
                imageName:@"cashier_10"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];

    bleDevices=[BSTableContentObject
                initWithContentObject:@"    客服"
                methodName:nil
                imageName:@"cashier_13"
                vcClass:nil];
    
    bleDevices.colCapatibilty=3;
    [bsTable addBSTableContent:bleDevices sectionHeader:@"支出"];
    

    [super setValue:bsTable forKey:@"bSTableObjects"];
    
   
}



/**
 *改变行的高度（实现主个代理方法后 rowHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BSMarginY(120);
}

/**
 *覆盖父类实现，不显示章节标题
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

/**
 *覆盖，调整
 *每个section底部标题高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(0);
}


- (void)addImagePlay{
    //
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++){
        NSString *imgName = [NSString stringWithFormat:@"paycash%d.png",i+1];
        [tempArray addObject:imgName];
    }
    
    self.imagePlayer =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil height:5];
}


//-(void)testButtonClick:(UIButton *)sender
//{
//    
//    G1WeiXinPayViewController *testWeChatCtrl = [[G1WeiXinPayViewController alloc]initWithNibName:@"G1WeiXinPayViewController" bundle:nil];
//     UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:testWeChatCtrl];
//    [self presentViewController:navCtrl animated:YES completion:nil];
//    
//    
//    
//    
//    
//}

@end
