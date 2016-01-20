    //
    //  WaiMaiDingdanController.h
    //  G2TestDemo
    //
    //  Created by lcc on 15/9/9.
    //  Copyright (c) 2015年 ws. All rights reserved.
    //

#import <UIKit/UIKit.h>
#import "WaiMaiOrderListCell.h"
@class WaiMaiDingdanController;

@protocol WaiMaiDingdanControllerDelegate <NSObject>
@optional
-(void)WaiMai:(WaiMaiDingdanController *)WaiMai didSelectedRowInDingDanTable:(int)row;
-(void)WaiMai:(WaiMaiDingdanController *)WaiMai didSeletedRowInCaiPinTable:(int)row;
- (void)WaiMaiDingdanControllerDidChickMore:(WaiMaiDingdanController *)waimaiVc;

@end

@protocol WaiMaiDingdanControllerDatasource <NSObject>

-(NSInteger)numberOfRowsInDingDanTable:(WaiMaiDingdanController *)WaiMai;

-(NSString *)WaiMai:(WaiMaiDingdanController *)WaiMai titleForRowInDingDanTable:(int)row;

-(NSArray *)WaiMai:(WaiMaiDingdanController *)WaiMai subDataForRowInDingDanTable:(int)row;

@end

@interface WaiMaiDingdanController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchBarTextField;

@property (weak, nonatomic) IBOutlet UITableView *CaiPinView;

@property (weak, nonatomic) IBOutlet UITableView *waiMaiOrderInfoList;

@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (nonatomic, weak) id<WaiMaiDingdanControllerDelegate> delegate;
@property (nonatomic, weak) id<WaiMaiDingdanControllerDatasource> dataSource;

@property (nonatomic, strong) NSMutableArray *quanbuArr;
@property (nonatomic, strong) NSMutableArray *caiPinArr;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIButton *payMoneyButton;

@end
