//
//  KTLBNavigationController.m
//  KTAPP
//
//  Created by admin on 15/6/28.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "NDLBSCircleController.h"
//#import "LBControllerHeader.h"
#import "BSUIFrameworkHeader.h"

@interface NDLBSCircleController()<BSImagePlayerDelegate>
    @property (nonatomic, weak) BSFCRollingADImageUIView *imagePlayer;
    @property (nonatomic, copy) NSArray *imageNameArray;
@end

@implementation NDLBSCircleController
@dynamic tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BSTableSection *bsTable=[BSTableSection
                             initWithHeaderVcClassContent:@"商圈"//章节显示标题
                             imageName:@"xy"//章节显示图标
                             headerViewClass:nil//章节显示视图
                             cellIdentifier:@"BSUIFiveColTableViewCell"//采用的TableViewCell
                             cellClass:[BSUIFiveColTableViewCell class]//TableViewCell实现
                             
                             storyboard:@"KTWaterDetailsViewController"
                             colCapatibilty:2//每个章节的row数量
                             bsContent:nil];
    
    
    BSTableContentObject *recommend=[BSTableContentObject initWithContentObject:@"餐饮"
                                                                     methodName:nil imageName:@"dining_1"
                                                                       colClass:nil];
    recommend.noNeedLoginCheck=YES;
    
    [bsTable addBSTableContent:recommend sectionHeader:@"商圈"];
    
    
    BSTableContentObject *commu=[BSTableContentObject
                                 initWithContentObject:@"住宿"
                                 methodName:nil imageName:@"hotel_2"
                                 vcClass:nil];
    commu.noNeedLoginCheck=YES;
    
    [bsTable addBSTableContent:commu sectionHeader:@"商圈"];
    
    
    BSTableContentObject *tech=[BSTableContentObject initWithContentObject:@"本地市场" methodName:nil imageName:@"native_market_3" colClass:nil];
    tech.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:tech sectionHeader:@"商圈"];
    
    
    //预约服务
    BSTableContentObject *appointment=[BSTableContentObject initWithContentObject:@"车服务" methodName:nil imageName:@"wash_4" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:appointment sectionHeader:@"商圈"];
    
    //配置轮播
    BSTableContentObject *lifeService=[BSTableContentObject initWithContentObject:@"轮播图" methodName:nil imageName:nil
        colClass:nil];
    lifeService.noNeedLoginCheck=YES;
    //lifeService.colCapatibilty=1;
    //添加轮播
    [self addImagePlay];
    lifeService.display=self.imagePlayer ;
    [bsTable addBSTableContent:lifeService sectionHeader:@"轮播广告"];
    
    //
    //农家院
    BSTableContentObject *nongjiayuan=[BSTableContentObject initWithContentObject:@"农家院" methodName:nil imageName:@"djh_1" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:nongjiayuan sectionHeader:@"其它商圈"];
    
    BSTableContentObject *mk=[BSTableContentObject initWithContentObject:@"超市" methodName:nil imageName:@"cs_1" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:mk sectionHeader:@"其它商圈"];

    BSTableContentObject *drinkmk=[BSTableContentObject initWithContentObject:@"烟酒实体店" methodName:nil imageName:@"mj_1" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:drinkmk sectionHeader:@"其它商圈"];
    
    BSTableContentObject *hiremk=[BSTableContentObject initWithContentObject:@"美容美发" methodName:nil imageName:@"mrmf_1" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:hiremk sectionHeader:@"其它商圈"];
    
    BSTableContentObject *allopenemk=[BSTableContentObject initWithContentObject:@"全民开店" methodName:nil imageName:@"qmkd_1" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:allopenemk sectionHeader:@"其它商圈"];
    
    BSTableContentObject *discountemk=[BSTableContentObject initWithContentObject:@"特惠品" methodName:nil imageName:@"thp_1" colClass:nil];
    appointment.noNeedLoginCheck=YES;
    [bsTable addBSTableContent:discountemk sectionHeader:@"其它商圈"];
    
    [super setValue:bsTable forKey:@"bSTableObjects"];

}

/**
 *  添加头部图片轮播器
 */
- (void)addImagePlay{
    //
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++){
        NSString *imgName = [NSString stringWithFormat:@"slide%d.png",i+1];
        [tempArray addObject:imgName];
    }
    
    self.imagePlayer =[BSFCRollingADImageUIView initADImageUIViewWith:tempArray playerDelegate:self urls:nil height:6];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return BSMarginX(140);
    
}

/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BSMarginY(0);
}
/**
 *每个section底部标题高度（实现这个代理方法后前面 sectionHeaderHeight 设定的高度无效）
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return BSMarginY(0);
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return nil;
}

@end
