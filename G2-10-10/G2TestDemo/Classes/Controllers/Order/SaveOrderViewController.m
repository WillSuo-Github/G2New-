//
//  SaveOrderViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/18.
//  Copyright (c) 2015年 ws. All rights reserved.
//


#import "SaveOrderViewController.h"
#import "TTSwitch.h"
#import "HttpTool.h"
#import "DeskState.h"
#import "DeskViewCell.h"
#import "DeskState.h"
#import "SaveDiskCell.h"
#import "MJExtension.h"
#import "AreaStates.h"
#import "SaveOrderReusableView.h"
#import "CaiPG.h"
#import "MBProgressHUD.h"
#import "TaoCanPG.h"
#import "TaoCanUpPG.h"
#import "AFNetworking.h"
#import "DXKeyboard.h"
#import "AddWaiMaiPG.h"
#import "CaiPG.h"
#import "MJExtension.h"
#import "TimeTool.h"
#import "JiKou.h"
//添加就餐人数  wjy
//#import "KaiTaiPG.h"

@interface SaveOrderViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,DXKeyboardDelegate,UITextViewDelegate>{
    
    
    BOOL isOpen;
    NSInteger selectedIndex; //被选中的索
    BOOL upSuccess;
    int beizhuoffset;
}
@property (weak, nonatomic) IBOutlet UIButton *baocunBTN;

@property (nonatomic, strong) TTSwitch *sq; //开台开关

@property (nonatomic, strong) TTSwitch *sq1; //外卖开关

@property (nonatomic, strong) TTSwitch *invoice;

/**
 *  用户下单备注
 */
@property (weak, nonatomic) IBOutlet UITextView *beizhu;
@property (strong,nonatomic) CaiPG *caipg;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *peopleNumTextField;

/**
 *  所有的餐台信息
 */
@property (nonatomic, strong) NSMutableArray *AllTable;
/**
 *  餐区数组
 */
@property (nonatomic, strong) NSMutableArray *AreasArr;// 桌台标题数组
@property (nonatomic, strong) NSMutableArray *tmpAreasArr;

/**
 *  分区数组
 */
@property (nonatomic, strong) NSMutableArray *tmpArr;
@property (nonatomic, strong) NSMutableArray *sectionArr;

@property (nonatomic, strong) SaveDiskCell *selectCell;
@property (nonatomic, strong) DeskState *selectDeskState;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) DXKeyboard *keyBoard;
@property (nonatomic, strong) NSString *diancanforwardUrl;
@property (nonatomic, copy) NSString *diancanbillType;

@property (nonatomic, strong) SaveOrderReusableView *selectHeaderView;

@property (nonatomic, strong) MBProgressHUD *hud;
/**
 *  外卖
 */
@property (weak, nonatomic) IBOutlet UIView *waimaiView;
@property (weak, nonatomic) IBOutlet UIButton *geren;
@property (weak, nonatomic) IBOutlet UIButton *gongsi;
@property (weak, nonatomic) IBOutlet UITextField *peisongyuanTextField;
@property (weak, nonatomic) IBOutlet UITextField *dizhiTextField;
@property (weak, nonatomic) IBOutlet UITextField *xingmingTextField;

@property (weak, nonatomic) IBOutlet UITextField *shoujiTextField;
@property (weak, nonatomic) IBOutlet UITextField *gongsiTextField;
@property (nonatomic, strong) UIImageView *selectImageView;

@property (weak, nonatomic) IBOutlet UILabel *kaitaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *waimaiLabel;



//配送员
@property (weak, nonatomic) IBOutlet UIButton *expressPersonButton;

@property (strong,nonatomic) UITableView *expressPersonTableView;

@property (strong,nonatomic) NSMutableArray *expressPersonMArray;

@property (weak, nonatomic) IBOutlet UIView *expressBackground;
@property (copy,nonatomic) NSString *billId;



@end

@implementation SaveOrderViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.waimaiView.hidden = YES;
    isOpen = NO;
    upSuccess = NO;
    self.geren.hidden = YES;
    self.gongsi.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
    self.beizhu.layer.borderColor = UIColor.grayColor.CGColor;
    self.beizhu.layer.borderWidth = 1;
    self.beizhu.layer.cornerRadius = 5;
    self.beizhu.layer.masksToBounds = YES;
    self.beizhu.delegate =self;
    
    self.collectionView.allowsSelection = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;


    self.baocunBTN.userInteractionEnabled = YES;
   
    self.peopleNumTextField.layer.borderWidth = 1;
    self.peopleNumTextField.layer.cornerRadius = 5;
    self.peopleNumTextField.delegate = self;
    self.peopleNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.peopleNumTextField.returnKeyType = UIReturnKeyDone;
    
    
    self.peopleNumTextField.layer.borderColor = [[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1 ]CGColor];
    self.peopleNumTextField.layer.borderWidth = 1;
    
    
    //外卖 start
    
    self.xingmingTextField.layer.borderWidth = 1;
    self.xingmingTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.xingmingTextField.layer.cornerRadius = 5;
    
    self.peisongyuanTextField.layer.borderWidth = 1;
    self.peisongyuanTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
     self.peisongyuanTextField.layer.cornerRadius = 5;
    
    self.dizhiTextField.layer.borderWidth = 1;
    self.dizhiTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
     self.dizhiTextField.layer.cornerRadius = 5;
    
    self.shoujiTextField.layer.borderWidth = 1;
    self.shoujiTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
     self.shoujiTextField.layer.cornerRadius = 5;
    
    self.gongsiTextField.layer.borderWidth = 1;
    self.gongsiTextField.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.gongsiTextField.layer.cornerRadius = 5;
    self.gongsiTextField.hidden = YES;
    self.gongsiTextField.tag = 1010;
    self.gongsiTextField.delegate =self;
    
    
    DXKeyboard *jianpanView = [[DXKeyboard alloc] init];
    jianpanView.delegate = self;
    [_shoujiTextField setInputView:jianpanView];
    self.keyBoard = jianpanView;
    [_shoujiTextField setBorderStyle:UITextBorderStyleRoundedRect];
    
    // end of line

    

    [self setUpSwitch];
    [self requestTables];

    [self.collectionView registerNib:[UINib nibWithNibName:@"SaveOrderReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    //self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.contentSize = self.collectionView.frame.size;
    if ([self.whereCome isEqualToString:kWaiMaiFromStr]) {
        [self.sq1 setOn:YES];
        self.waimaiView.hidden = NO;
    }else{
        
        self.waimaiView.hidden = YES;
        [self.sq setOn:YES];
    }
    
    
    UIButton *leftButton = [[UIButton alloc]init];
    [leftButton setImage:[UIImage imageNamed:@"hlk_qx"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIButton *rightButton = [[UIButton alloc]init];
    [rightButton setImage:[UIImage imageNamed:@"hlk_duihao"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem = rightBarButton;
    
    //self.navigationController.navigationBar.hidden = YES;
    
    
    
    
    
    
    
    
    //配送员
    [self.expressPersonButton addTarget:self action:@selector(selectExpressPersonButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGPoint point = self.expressBackground.superview.frame.origin ;
    point.y += self.expressBackground.frame.origin.y +30;
    point.x += self.expressBackground.frame.origin.x +60;
    
//    point.x =  self.peisongyuanTextField.superview.frame.origin.x  + self.peisongyuanTextField.frame.origin.x ;
//    point.y = self.peisongyuanTextField.superview.frame.origin.y  + self.peisongyuanTextField.frame.origin.y;
//    
    

    [self createExpressPersonTableViewAutoLayout:point];
    
   

//    NSLog(@"------%@---%@",self.taocanList,self.OrderList);
}




-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.baocunBTN.userInteractionEnabled = YES;
    upSuccess = NO;
    
}

-(void)selectExpressPersonButtonClick:(UIButton *)sender
{
     [self getExpressPersonMArrayData];
    if (self.expressPersonTableView.hidden == YES) {
        self.expressPersonTableView.hidden = NO;
    }
    else
    {
        self.expressPersonTableView.hidden = YES;
        
    }
    
    
    
}

//配送员
-(void)createExpressPersonTableViewAutoLayout:(CGPoint )originPoint
{
    
    
    
     NSLog(@"express preson :%@",self.expressPersonMArray.mj_keyValues);
    self.expressPersonTableView = [[UITableView alloc]initWithFrame:CGRectMake(originPoint.x,originPoint.y,265, 2*46)];
    //self.expressPersonTableView.backgroundColor = [UIColor redColor];
    self.expressPersonTableView.delegate = self;
    self.expressPersonTableView.dataSource = self;
    [self.expressBackground.superview addSubview:self.expressPersonTableView];
    self.expressPersonTableView.separatorStyle = NO;
    self.expressPersonTableView.hidden = YES;

    
}

-(void) getExpressPersonMArrayData
{
    
    self.expressPersonMArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    
    char *baseUrl = "/canyin-frontdesk/takeout/pop/sendForm/\"\"?returnJson=json";
    
    char url[1024]="\0";
    sprintf(url,"%s%s",ceshiIP.UTF8String,baseUrl);
    //NSLog(@"%s",url);
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/takeout/pop/sendForm/\"\"?returnJson=json",ceshiIP];
    
    
   NSString *urlString = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"URL:%@",urlString);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"express person JSON: %@", responseObject);
        NSDictionary *employees = [responseObject objectForKey:@"employees"];
        
       NSArray *content = [employees objectForKey:@"content"];
        for(int i = 0; i< content.count ;i++)
        {
            NSDictionary *dic = content[i];
             NSString *str  = [dic objectForKey:@"name"];
            [self.expressPersonMArray addObject:str ];
        }
       
//        NSLog(@"%@",self.expressPersonMArray);
        [self.expressPersonTableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    

    
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.expressPersonMArray.count >0) {
        return self.expressPersonMArray.count;
    }else return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idStr = @"idStr";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
        
    }
//    NSLog(@"%@",self.expressPersonMArray[indexPath.row]);
    cell.textLabel.text = self.expressPersonMArray[indexPath.row];
    
    return cell;
    
    
}
    
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //self.expressPersonButton.titleLabel.text = cell.textLabel.text;
    [self.expressPersonButton setTitle:cell.textLabel.text forState:UIControlStateNormal];
    
    self.expressPersonTableView.hidden = YES;
    
    
}



//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}


/**
 *  外卖
 */



//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    //开始编辑时触发，文本字段将成为first responder
//        self.peopleNumTextField.layer.borderColor = [[UIColor colorWithRed:78/255.0 green:152/255.0 blue:226/255.0 alpha:1 ]CGColor];
//}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor colorWithRed:93/255.0 green:156/255.0 blue:236/255.0 alpha:1 ]CGColor];
    textField.layer.borderWidth= 3;
    return YES;
}



- (IBAction)gerenChick:(id)sender {
    self.geren.selected =  YES;
    self.gongsi.selected = NO;
    self.gongsiTextField.hidden =YES;
    
}

- (IBAction)gongsiChick:(id)sender {
    self.gongsi.selected = YES;
    self.geren.selected = NO;
    self.gongsiTextField.hidden = NO;
}




/**
 *  请求桌台信息
 */
- (void)requestTables{
    
    NSString *urlS = [NSString stringWithFormat:@"%@/canyin-frontdesk/index/ajax/table/list?returnJson=json&search_EQ_dinnerStatus=",ceshiIP];
    NSDictionary *dic = nil;
    if ([self.whereCome isEqualToString:@"预定"]) {
      dic = [NSDictionary dictionaryWithObject:self.bookTimeStr forKey:@"orderTime"];
    }
    
    NSLog(@"requestTables:%@",urlS);
    [HttpTool GET:urlS parameters:dic success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"tables"];

        NSArray *arr = [dict objectForKey:@"content"];
        
        /**
         *  所有的桌子信息
         */
        _AllTable = [DeskState objectArrayWithKeyValuesArray:arr];
        
        NSArray *areas = [responseObject objectForKey:@"roleTableAreas"];
        /**
         *  分区信息
         */
        _AreasArr = [AreaStates objectArrayWithKeyValuesArray:areas];
    
        [self.tmpAreasArr removeAllObjects];
        for (AreaStates *areaStates in self.AreasArr)
        {
            //           if ([fistState.areaId isEqualToString:areaStates.areaId]) {
            [self.tmpAreasArr addObject:areaStates];
            //            }
        }
//        [self.tableDict removeAllObjects];
        
        /**
         *  桌子匹配 分区
         */
        for (int i = 0; i < self.AreasArr.count; ++i)
        {
            AreaStates *areas = self.AreasArr[i];
            
            NSMutableArray *array = [NSMutableArray array];

            for (int j = 0; j < self.AllTable.count; ++j)
            {
                DeskState *states = self.AllTable[j];

                if ([self.whereCome isEqualToString:@"预定"])
                {
                    
                    if ([states.areaId isEqualToString:areas.areaId])
                    {
                        
                        [array addObject:states];
                    }
                    
                }
                else
                {
                    
                    /**
                     *  分区与桌子 匹配
                     */
                    if ([states.areaId isEqualToString:areas.areaId] && [states.dinnerStatus isEqualToString:@"1"])
                    {
                        [array addObject:states];
                    }
                }
                
                
            }
            
            if (array.count) {
                [self.tmpArr addObject:array];

            }
            
        }
        
       // NSLog(@"TableNo:%ld",self.tmpArr.count);
         [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
   

    
}

- (void)setUpSwitch{
    
    TTSwitch *squareThumbSwitch = [[TTSwitch alloc] initWithFrame:(CGRect){ {CGRectGetMaxX(self.kaitaiLabel.frame),self.kaitaiLabel.frame.origin.y + 3}, { 76.0f, 27.0f } }];
    
    _sq = squareThumbSwitch;
    squareThumbSwitch.trackImage = [UIImage imageNamed:@"square-switch-track"];
    squareThumbSwitch.overlayImage = [UIImage imageNamed:@"square-switch-overlay"];
    squareThumbSwitch.thumbImage = [UIImage imageNamed:@"square-switch-thumb"];
    squareThumbSwitch.thumbHighlightImage = [UIImage imageNamed:@"square-switch-thumb-highlight"];
    squareThumbSwitch.trackMaskImage = [UIImage imageNamed:@"square-switch-mask"];
    squareThumbSwitch.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    squareThumbSwitch.thumbInsetX = -3.0f;
    squareThumbSwitch.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [self.view addSubview:squareThumbSwitch];
    
    TTSwitch *squareThumbSwitch1 = [[TTSwitch alloc] initWithFrame:(CGRect){ {CGRectGetMaxX(self.waimaiLabel.frame),self.waimaiLabel.frame.origin.y + 3}, { 76.0f, 27.0f } }];
    _sq1 = squareThumbSwitch1;
    squareThumbSwitch1.trackImage = [UIImage imageNamed:@"square-switch-track"];
    squareThumbSwitch1.overlayImage = [UIImage imageNamed:@"square-switch-overlay"];
    squareThumbSwitch1.thumbImage = [UIImage imageNamed:@"square-switch-thumb"];
    squareThumbSwitch1.thumbHighlightImage = [UIImage imageNamed:@"square-switch-thumb-highlight"];
    squareThumbSwitch1.trackMaskImage = [UIImage imageNamed:@"square-switch-mask"];
    squareThumbSwitch1.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    squareThumbSwitch1.thumbInsetX = -3.0f;
    squareThumbSwitch1.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [self.view addSubview:squareThumbSwitch1];
    
    
    //start
    
    TTSwitch *squareThumbSwitch2 = [[TTSwitch alloc] initWithFrame:(CGRect){ {175.0f,235.0f}, { 76.0f, 27.0f } }];
    self.invoice = squareThumbSwitch2;
    squareThumbSwitch2.trackImage = [UIImage imageNamed:@"square-switch-track"];
    squareThumbSwitch2.overlayImage = [UIImage imageNamed:@"square-switch-overlay"];
    squareThumbSwitch2.thumbImage = [UIImage imageNamed:@"square-switch-thumb"];
    squareThumbSwitch2.thumbHighlightImage = [UIImage imageNamed:@"square-switch-thumb-highlight"];
    squareThumbSwitch2.trackMaskImage = [UIImage imageNamed:@"square-switch-mask"];
    squareThumbSwitch2.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    squareThumbSwitch2.thumbInsetX = -3.0f;
    squareThumbSwitch2.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [self.waimaiView addSubview:self.invoice];
    
    
    // end of line
    
    
    
    
    __weak SaveOrderViewController *weakSelf = self;
    _sq.changeHandler = ^(BOOL on){
        
        if (on) {
            [weakSelf.sq1 setOn:NO];

//            NSLog(@"1");
            weakSelf.waimaiView.hidden = YES;
        }
    };
    

    _sq1.changeHandler = ^(BOOL on){
        
        if (on) {
            [weakSelf.sq setOn:NO];

//            NSLog(@"2");
            weakSelf.waimaiView.hidden = NO;
        }
    };
    
    self.invoice.changeHandler = ^(BOOL on)
    {
        if (!on) {
            self.geren.selected = NO;
            self.gongsi.selected = NO;
            self.geren.hidden = YES;
            self.gongsi.hidden = YES;
            self.gongsiTextField.hidden = YES;
            
            
        }else
        {
            self.geren.hidden = NO;
            self.gongsi.hidden = NO;
            //开启发票默认个人
            self.geren.selected=YES;
            
            self.gongsiTextField.hidden = YES;
            
        }
    };
    

}
- (IBAction)queding:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    //button.userInteractionEnabled = NO;
    
    //外卖 开关
    if (self.sq1.on)
    {

        if (!self.xingmingTextField.text.length) {
            [self showAlertViewWithMessage:@"外卖姓名不能为空"];
        }else if (!self.shoujiTextField.text.length){
            
            [self showAlertViewWithMessage:@"外卖手机号不能为空"];
        }else if (self.shoujiTextField.text.length!=11){
            
            [self showAlertViewWithMessage:@"请正确的输入外卖手机号"];
        }else if (!self.dizhiTextField.text.length){
            
            [self showAlertViewWithMessage:@"外卖地址不能为空"];
        }else if (!self.expressPersonButton.titleLabel.text.length){
            
            [self showAlertViewWithMessage:@"外卖配送员不能为空"];
        }
        else
        {
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/takeout/saveTakeout",ceshiIP];
            AddWaiMaiPG *waimaiPG = [[AddWaiMaiPG alloc] init];
            waimaiPG.Mobile = self.shoujiTextField.text;
//            waimaiPG.takeId = self.expressPersonButton.titleLabel.text;
            waimaiPG.ccdId = @"";
            waimaiPG.sendAtOnce = @"1";
            waimaiPG.sendAddress = self.dizhiTextField.text;
            waimaiPG.contactName = self.xingmingTextField.text;
            waimaiPG.invoiceTitle = @"否";
            NSString *dateStr = [TimeTool getCurrentDateStr];
            NSString *twoRandomStr = [TimeTool getRandomCharStr:2];
            NSString *takeAwayId = [NSString stringWithFormat:@"%@%@",dateStr,twoRandomStr];
            NSLog(@"takeAwayId:%@",takeAwayId);
            waimaiPG.takesNumber = takeAwayId;
             NSLog(@" waimaiPG.TakeAwayOrderId:%@", waimaiPG.takesNumber);
            
            
            
            if (self.gongsiTextField.text.length) {
               waimaiPG.invoiceTitle = self.gongsiTextField.text;
            }if ( self.geren.selected ==YES) {
                waimaiPG.invoiceTitle = @"个人";
            }
            waimaiPG.takeId = self.expressPersonButton.currentTitle;
            waimaiPG.customNote = self.beizhu.text;
            
            
        
//
          NSLog(@"%@",waimaiPG.mj_keyValues);
            
//            NSLog(@"%@",waimaiPG.keyValues);
//            NSLog(@"%@",self.OrderList);
//            self.caipg = self.OrderList[0];
            
            NSLog(@"%@",[self.caipg mj_keyValues]);
//            CaiPG.
            [HttpTool POST:urlStr parameters:waimaiPG.mj_keyValues success:^(id responseObject) {
                NSLog(@"%@",responseObject);
                [self.view endEditing:YES];
//                [self dismissModalViewControllerAnimated:YES];
//                [self dismissViewControllerAnimated:YES completion:nil];
//                [self getInfo];
                NSString *dishID = @"";
                NSString *dishNum = @"";
                //    NSLog(@"%@",self.OrderList);
                if (self.OrderList.count == 0)
                {
//                    [self shangchuanTaoCan];
                    return;
                }
                
                for (int i = 0; i < self.OrderList.count; ++i)
                {
                    CaiPG *caipg = self.OrderList[i];
                    if (dishID.length == 0) {
                        dishID = caipg.dishesId;
                    }else{
                        
                        dishID = [NSString stringWithFormat:@"%@,%@",dishID,caipg.dishesId];
                    }
                }
                
                for (int i = 0; i < self.OrderList.count; ++i)
                {
                    CaiPG *caipg = self.OrderList[i];
                    if (dishNum.length == 0) {
                        dishNum = caipg.unitNumStr;
                    }else{
                        
                        dishNum = [NSString stringWithFormat:@"%@,%@",dishNum,caipg.unitNumStr];
                    }
                }
                NSString *tId = responseObject[@"value"];
                NSLog(@"%@",tId);
      NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/jiacai/2/%@?unitNumStr=%@&tId=%@",ceshiIP,dishID,dishNum,tId];
                   NSLog(@"waimai  %@",urlStr);
                [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
                    
                           NSLog(@" 外卖list %@",responseObject);
                   
                    
                    NSDictionary *dic = [NSDictionary dictionaryWithObject:[responseObject objectForKey:@"forwardUrl"] forKey:@"billNo"];
                    // add by manman
                    // 添加 外卖编号  新添加  15-12-14
                    NSLog(@"self DeskState %@",self.selectDeskState.mj_keyValues);
                         
                    
                    
                    // end of line
                    
                    //[self printOrderInfo:self.foodMenuArr];
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"添加外卖成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    //发送外卖清台通知 王京阳
                    [[NSNotificationCenter defaultCenter]postNotificationName:KWaiMaiXiaDan object:nil userInfo:dic ];

                    [alert show];
                    
                    
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
            
            button.userInteractionEnabled=NO;
        }
        
        
        return;
    }else{
        
        if ([self.whereCome isEqualToString:@"预定"])
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:KyudingTiaoxuanzhuo object:nil userInfo:self.selectDeskState];
          //添加通知 王京阳
//            [[NSNotificationCenter defaultCenter] postNotificationName:KyudingTiaoxuanzhuo object:nil userInfo:self.kaitaiP];
            
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        else
        {
            //正常下单
            if (!self.selectDeskState) {
                [self showAlertViewWithMessage:@"请选择餐桌"];
            }else if (self.peopleNumTextField.text.length == 0){
                
                [self showAlertViewWithMessage:@"请输入就餐人数"];
            }else{
                
                self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                self.hud.labelText = @"请稍后";
                self.hud.dimBackground = YES;
                [self.hud show:YES];
                [self kaiTai];
                
                
   //             [HardwareInterface printCommandAction];
  //              [HardwareInterface showAction];
                
                
                
            }
        }
    }
    
    
   
}

#pragma mark   键盘的代理方法

#pragma mark -- 数字键盘
- (void)numberKeyBoardInput:(NSInteger) number
{
    if (self.shoujiTextField.text.length >10) {
        return;
        
    }
    //    DebugLog(@"string number : %d",number);
    if (number <= 9 && number >= 1) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@%ld",_shoujiTextField.text,(long)number];
        _shoujiTextField.text = textString;
    }if (number == 11) {
        if (self.shoujiTextField.text.length==10)return;

        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@00",_shoujiTextField.text];
        _shoujiTextField.text = textString;
    }
    //手机号不让输入.  王京阳
//    if (number == 10) {
//        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@.",_shoujiTextField.text];
//        _shoujiTextField.text = textString;
//    }
    if (number == 12) {
        NSMutableString *textString = [[NSMutableString alloc] initWithFormat:@"%@0",_shoujiTextField.text];
        _shoujiTextField.text = textString;
        
        
    }
}

- (void)xiaqufangfa{
    [self.view endEditing:YES];
}

- (void)numberKeyBoardBackspace {
    NSMutableString* mutableString = [[NSMutableString alloc] initWithFormat:@"%@", _shoujiTextField.text];
    if ([mutableString length] >= 1) {
        NSRange tmpRange;
        tmpRange.location = [mutableString length] - 1;
        tmpRange.length = 1;
        [mutableString deleteCharactersInRange:tmpRange];
    }
    _shoujiTextField.text = mutableString;
    
 
}

- (void)numberKeyBoardFinish
{
    //    DebugLog(@"finished.......");
    [_shoujiTextField resignFirstResponder];
}

- (void)bgButtonClick27703784131
{
    
    [_shoujiTextField resignFirstResponder];
}

- (void) numberKeyBoardShou{
    [self xiaqufangfa];
}



- (void)kaiTai{
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.selectDeskState.tabNo,@"table.tabNo",self.selectDeskState.tabId,@"table.tabId",self.selectDeskState.tabNo,@"tableNo",self.peopleNumTextField.text,@"peopleNum", nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.selectDeskState.tabNo,@"table.tabNo",self.selectDeskState.tabId,@"table.tabId",self.selectDeskState.tabNo,@"tableNo",self.peopleNumTextField.text,@"peopleNum", nil];
    self.selectDeskState.peopleCount = [NSString stringWithFormat:@"%@",self.peopleNumTextField.text];
    
    NSString *openTableTime = [self getCurrentDateStr:@"%04ld-%02ld-%02ld %02ld:%02ld:%02ld"];
    self.selectDeskState.openTableTime = [NSString stringWithFormat:@"%@",openTableTime];
   // NSLog(@"%@",self.selectDeskState);
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/IOS_index/kaitai/create",ceshiIP];
    
    [HttpTool GET:urlStr parameters:dict success:^(id responseObject) {
        NSLog(@"kaitai response:%@",responseObject);
        if ([[responseObject objectForKey:@"message"] isEqualToString:@"1"]) {
            self.diancanforwardUrl = [responseObject objectForKey:@"forwardUrl"];
            // add by manman start of line  15-12-14
            // 新增 订单号 替换订单ID（打印显示）
            NSLog(@"billNO:%@",[responseObject objectForKey:@"value"]);
            self.selectDeskState.billNo = [responseObject objectForKey:@"value"];// 订单号
            NSLog(@"billNo  new :%@",self.selectDeskState.billId );
            // end of line
            self.baocunBTN.userInteractionEnabled = NO;
            [self getInfo];
            
        }else{
            
            [self showAlertViewWithMessage:@"开台失败"];
        }
    } failure:^(NSError *error) {
        [self.hud hide:YES];
        [self showAlertViewWithMessage:@"开台失败"];
    }];
}

- (void)getInfo{
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/diancai?billId=%@&returnJson=json",ceshiIP,self.diancanforwardUrl];
   // NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
       // NSLog(@" xiadan   request SS:%@",responseObject);
        
        self.billId = responseObject[@"billId"];
        self.selectDeskState.billId = [NSString stringWithFormat:@"%@",self.billId];
        NSLog(@"4444%@",responseObject);
        self.diancanbillType = [responseObject objectForKey:@"billType"];
        
        if (!self.OrderList.count && self.taocanList.count) {
            [self shangchuanTaoCan];
        }else{
             
            [self shangchuanCaiPin];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



- (void)shangchuanCaiPin{
    
    NSString *dishID = @"";
    NSString *dishNum = @"";
//    NSLog(@"%@",self.OrderList);
    if (self.OrderList.count == 0) {
        [self shangchuanTaoCan];
        return;
    }
    
    for (int i = 0; i < self.OrderList.count; ++i) {
        CaiPG *caipg = self.OrderList[i];
        if (dishID.length == 0) {
            dishID = caipg.dishesId;
        }else{
            
            dishID = [NSString stringWithFormat:@"%@,%@",dishID,caipg.dishesId];
        }
    }
    
    for (int i = 0; i < self.OrderList.count; ++i) {
        CaiPG *caipg = self.OrderList[i];
        if (dishNum.length == 0) {
            dishNum = caipg.unitNumStr;
        }else{
            
            dishNum = [NSString stringWithFormat:@"%@,%@",dishNum,caipg.unitNumStr];
        }
    }
//    NSLog(@"%@----%@",dishID,dishNum);
//  NSNotificationCenter defaultCenter
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/jiacai/%@/%@?unitNumStr=%@&billId=%@",ceshiIP,self.diancanbillType,dishID,dishNum,self.diancanforwardUrl];
    NSLog(@"  request URL S%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@" response URL S  %@",responseObject);
        if (self.taocanList.count) {
            [self shangchuanTaoCan];
        }else{
            [self.hud hide:YES];
//            [self showAlertViewWithMessage:@"下单成功"];
            [self tiJiaoDingDan];
        }
        

    } failure:^(NSError *error) {
        [self showAlertViewWithMessage:@"下单失败"];
        [self.hud hide:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    
}


/**
 *  套餐上传
 */
- (void)shangchuanTaoCan{
    
 
    NSString *taocanID = @"";
    NSString *FcaipinID = @"";
    for (int i = 0; i < self.taocanList.count; ++i) {
        TaoCanPG *taocanPG = self.taocanList[i];
        if (taocanID.length == 0) {
            taocanID = taocanPG.dishID;
        }else{
            taocanID = [NSString stringWithFormat:@"%@=%@",taocanID,taocanPG.dishID];
        }
        
        

        NSString *caipinID = @"[";
        for (int i = 0; i < taocanPG.caipinArr.count; ++i) {
            TaoCanUpPG *caipg = taocanPG.caipinArr[i];
            if ([caipinID isEqualToString:@"["]) {
                caipinID = [NSString stringWithFormat:@"%@%@",caipinID,[caipg.keyValues JSONString]];
                
            }else{
                
                caipinID = [NSString stringWithFormat:@"%@,%@",caipinID,[caipg.keyValues JSONString]];
            }

        }
        caipinID = [NSString stringWithFormat:@"%@]",caipinID];
//        NSLog(@"%@",caipinID);

        if (!FcaipinID.length) {
            FcaipinID = caipinID;
        }else{
            
            FcaipinID = [NSString stringWithFormat:@"%@=%@",FcaipinID,caipinID];
            
        }
        
        
    }
    
    
        //    NSString *urlStr1 = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/addDishesSet/%@/%@?billId=%@&returnJson=json&dsDishesDesc=%@",ceshiIP,self.diancanbillType,taocanID,self.diancanforwardUrl,caipinID];
    
//    
//    NSString *urlStr1 = [NSString stringWithFormat:@"%@/canyin-frontdesk/ios/bill/addDishesSet/%@/%@",ceshiIP,self.diancanbillType,taocanID];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.diancanforwardUrl,@"billId",FcaipinID,@"dsDishesDesc", nil];
////    NSLog(@"%@",urlStr1);
////    NSLog(@"%@",dict);
//    [HttpTool POST:urlStr1 parameters:dict success:^(id responseObject) {
//        [self tiJiaoDingDan];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [self.hud hide:YES];
//    }];
}
/**
 *  下单
 */
- (void)tiJiaoDingDan{
    
    NSString *str = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/xiadan/%@?enterType=0&returnJson=json",ceshiIP,self.diancanforwardUrl];
    
    [HttpTool GET:str parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        NSString *strBillID = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiBillContent?billId=%@&billType=1&returnJson=json",ceshiIP,self.billId];
          [HttpTool GET:strBillID parameters:nil success:^(id responseObject) {
              NSArray *arr = [responseObject objectForKey:@"dinerBillDishes"];
              // add by manman for start of line
              //添加菜品部分信息
              // NSArray *tmpArra = [arr firstObject];
              NSMutableString *zengping = [NSMutableString string];
              for (NSDictionary *tmpDic in arr) {
                  NSString *bdid = [tmpDic objectForKeyedSubscript:@"bdId"];
                  NSString *dishName = [tmpDic objectForKeyedSubscript:@"dishesName"];
                  
                  if (self.jiKouArr.count) {
                      //遍历加几口
                      for (JiKou *jik in self.jiKouArr) {
//                          NSLog(@"%@",jik.name);
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

                  for (CaiPG *cai in self.OrderList) {
                      if ([cai.dishesName isEqualToString:dishName]&&[cai.oriCostStr isEqualToString:@"0"]) {
                          zengping = [NSMutableString stringWithFormat:@"%@,%@",zengping,bdid];
                      }
                  }

              }
              //防止崩溃 WHC 没有增彩的时候会崩溃
              if (zengping.length) {
                  [zengping deleteCharactersInRange:NSMakeRange(0, 1)];
                  //WHC 增加赠品
                  NSString *urlZeng = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/zengcais/%@/%@",ceshiIP,zengping,self.billId];
                  NSDictionary *dic = @{@"isSet":@"0",@"returnJson":@"json"};
                  [HttpTool GET:urlZeng parameters:dic success:^(id responseObject) {
                      NSLog(@"chenggong");
                      [self.hud hide:YES];
                      [self showAlertViewWithMessage:@"下单成功"];
                      
                      
                      if ([_delegate respondsToSelector:@selector(SaveOrderViewControllerDidZhifu:DeskState:billID:)]) {
                          [self.delegate SaveOrderViewControllerDidZhifu:self DeskState:self.selectDeskState billID:self.diancanforwardUrl];
                      }
                      
                      [self dismissViewControllerAnimated:YES completion:nil];
                  } failure:^(NSError *error) {
                      
                  }];
                  //WHC end
              }
              else{
                  [self.hud hide:YES];
                  [self showAlertViewWithMessage:@"下单成功"];
                  
                  
                  if ([_delegate respondsToSelector:@selector(SaveOrderViewControllerDidZhifu:DeskState:billID:)]) {
                      [self.delegate SaveOrderViewControllerDidZhifu:self DeskState:self.selectDeskState billID:self.diancanforwardUrl];
                  }
                  
                  [self dismissViewControllerAnimated:YES completion:nil];
              }
              
             
              

          } failure:^(NSError *error) {
              
          }];
      
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
        [self.hud hide:YES];
    }];
    
    
}

- (IBAction)cancle:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)HeaderBtnChick:(UIButton *)btn{
    

    
    if (selectedIndex == btn.tag) {
        
        

    }else{
        
        selectedIndex = btn.tag;
        self.sectionArr = self.tmpArr[btn.tag];//所有的分区
        
        for (UIView *view in self.collectionView.subviews) {
            if ([view isKindOfClass:[SaveDiskCell class]]) {
                SaveDiskCell *saveCell = (SaveDiskCell *)view;
                saveCell.isSelect = NO;
                [saveCell.btn setImage:[UIImage imageNamed:@"desk2No"] forState:UIControlStateNormal];
            }
        }
        

        
        
        
        [self.collectionView reloadData];
    }

    selectedIndex = btn.tag;
//    NSLog(@"%ld",btn.tag);

    
    
    SaveOrderReusableView *headrView = [self.collectionView viewWithTag:btn.tag + 10];
//    NSLog(@"!!!%ld---%p",headrView.tag,headrView);

            
    headrView.imageView.transform = CGAffineTransformRotate(headrView.imageView.transform, M_2_PI);

        //headrView.imageView.image=
    self.sectionArr = self.tmpArr[btn.tag];
    
    for (UIView *view in self.collectionView.subviews)
    {
        if ([view isKindOfClass:[SaveDiskCell class]])
        {
            SaveDiskCell *saveCell = (SaveDiskCell *)view;
            saveCell.isSelect = NO;
            [saveCell.btn setImage:[UIImage imageNamed:@"desk2No"] forState:UIControlStateNormal];
        }
    }
//    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:btn.tag];
////    [self.collectionView reloadSections:indexSet];
//    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:btn.tag];
////    [self.collectionView reloadItemsAtIndexPaths:@[index]];
//    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];

    [self.collectionView reloadData];
    

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collectionView的代理和数据源方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.tmpArr.count;//分区数组

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
//    NSArray *arr = self.tmpArr[section];
//    return arr.count;
//    一个分组中 元素的个数
    if (section == selectedIndex)
    {
       // NSLog(@"section count :%ld",self.sectionArr.count);
        return self.sectionArr.count;
         //return 5;
    }
    return 0;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    SaveOrderReusableView *headerView;
    
    if ([kind isEqualToString: UICollectionElementKindSectionHeader])
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        
            //判断数组里面的元素属于哪个分区
            //NSLog(@"self.tmpAreasArr.count%ld",self.tmpAreasArr.count);
           // NSLog(@"index.section:%ld",indexPath.section);
            NSArray *tableArr = self.tmpArr[indexPath.section];
            DeskState *fistState = [tableArr firstObject];

//          NSLog(@"%@",fistState.)
         
            
//           NSLog(@"areas:%@",self.AreasArr);
          // NSLog(@"areasID:%@",self.tmpAreasArr[indexPath.section]);
           // NSLog(@"self.tmpAreasArr.count:%ld",self.tmpAreasArr.count);
            
            if (self.tmpAreasArr.count>indexPath.section)
            {
                //start of line add
                
                
                
                
                for (int i = 0;i<self.tmpAreasArr.count;i++)
                {
                    AreaStates *areas = self.tmpAreasArr[i];
                    
                    NSLog(@"areas:%@",areas.name);
                    if ([fistState.areaId isEqualToString:areas.areaId]) {
                        
                        headerView.titleName = areas.name;
                        //NSLog(@" into loop  tableName:%@",headerView.titleName);
                        
                        // NSLog(@"areas.name:%@",areas.name);
                        headerView.tableCapacity.text = [NSString stringWithFormat:@"( %@ 人数)", areas.teamare];
                        break;
                    }
                }
                
                
                // end of line
                
                
                
//                
//                AreaStates *areas = self.tmpAreasArr[indexPath.section];
//                if ([fistState.areaId isEqualToString:areas.areaId])
//                {
//                    headerView.titleName = areas.name;
//                    NSLog(@" into loop  tableName:%@",headerView.titleName);
//                 
//                   // NSLog(@"areas.name:%@",areas.name);
//                    headerView.tableCapacity.text = [NSString stringWithFormat:@"( %@ 人数)", areas.teamare];
//                }
//                else
//                {
//                // modify by manman for start of line
//                    
//                    [self.tmpAreasArr removeObjectAtIndex:indexPath.section];
//                    AreaStates *areas = self.tmpAreasArr[indexPath.section];
//                    headerView.titleName = areas.name;
//                    
//                    NSLog(@"areas.name:%@",areas.name);
//                    headerView.tableCapacity.text = [NSString stringWithFormat:@"( %@ 人数)", areas.teamare];
//                
//                
//                // end of line
////                [self collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
////                return headerView;
////                return headerView;
////                [self.collectionView reloadData];
//                
//                }
            }
    
    
//
        headerView.btn.tag = indexPath.section;
        headerView.tag = indexPath.section + 10;
        NSLog(@"self.count:%ld  section :%ld",self.tmpAreasArr.count ,indexPath.section);
        NSLog(@"headerView tableName:%@",headerView.titleName);
        [headerView.btn addTarget:self action:@selector(HeaderBtnChick:) forControlEvents:UIControlEventTouchDown];
    }
    
    return headerView;
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    [collectionView registerNib:[UINib nibWithNibName:@"SaveDiskCell" bundle:nil] forCellWithReuseIdentifier:ID];
    SaveDiskCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.states = self.sectionArr[indexPath.row];
    
//    NSLog(@"tableName:%@",cell.states.tabNo);
//    NSLog(@"tableName:%@",cell.states.tabName);
    UIView *view = [[UIView alloc] init];

    cell.selectedBackgroundView = view;
    return cell;

}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5,0, 5);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    SaveDiskCell *cell = (SaveDiskCell *)[collectionView cellForItemAtIndexPath:indexPath];
    for (UIView *view in self.collectionView.subviews) {
        if ([view isKindOfClass:[SaveDiskCell class]]) {
            SaveDiskCell *saveCell = (SaveDiskCell *)view;
            saveCell.isSelect = NO;
            [saveCell.btn setImage:[UIImage imageNamed:@"desk2No"] forState:UIControlStateNormal];
        }
    }
    if (cell.isSelect) {
        cell.isSelect = NO;
        [cell.btn setImage:[UIImage imageNamed:@"desk2No"] forState:UIControlStateNormal];
        
    }else{
        
        self.selectDeskState = self.sectionArr[indexPath.row];
        cell.isSelect = YES;
        [cell.btn setImage:[UIImage imageNamed:@"desk2Yes"] forState:UIControlStateNormal];

    }
}




#pragma UITextViewDelegate


- (void)textViewDidBeginEditing:(UITextView *)textView
{
   
    CGRect frame = self.beizhu.frame;
    frame.origin.y = 750;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 300.0);//键盘高度216
    NSLog(@"1height :%f",self.view.frame.size.height);
    NSLog(@"1width :%f",self.view.frame.size.width);
    NSLog(@"1height x :%f",self.view.frame.origin.x );
    NSLog(@"1width  y :%f",self.view.frame.origin.y);
    NSLog(@"2height :%f",frame.size.height);
    NSLog(@"2height :%f",frame.size.width);
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    upSuccess = YES;
    beizhuoffset=offset;
    if(offset > 0)
    {
        
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    [UIView commitAnimations];
    NSLog(@"1height 2 x :%f",self.view.frame.origin.x );
    NSLog(@"1width  2 y :%f",self.view.frame.origin.y);
    
    
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    //self.upSuccess = NO;
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@" textView height :%f",self.view.frame.size.height);
    NSLog(@"textView width :%f",self.view.frame.size.width);
    NSLog(@"textView height x :%f",self.view.frame.origin.x );
    NSLog(@"textView width  y :%f",self.view.frame.origin.y);
}



#pragma UITextFiledDelegate
//外卖  公司抬头  输入 控制
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    if (textField.tag ==1010)
    {
        CGRect frame = self.beizhu.frame;
        frame.origin.y = 600;
        int offset = frame.origin.y + 32 - (self.view.frame.size.height - 300.0);//键盘高度216
        NSLog(@"3height :%f",self.view.frame.size.height);
        NSLog(@"3width :%f",self.view.frame.size.width);
        NSLog(@"4height :%f",frame.size.height);
        NSLog(@"4height :%f",frame.size.width);
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            if (upSuccess == NO) {
                self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
                
                [UIView commitAnimations];
            }else{
                self.view.frame = CGRectMake(0.0f, -beizhuoffset, self.view.frame.size.width, self.view.frame.size.height);
                
                //[UIView commitAnimations];
                
            }

            
        
        
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1010) {
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
}





/**
 *  获取保存的菜品
 */
- (void)setOrderList:(NSMutableArray *)OrderList{
    
    _OrderList = OrderList;
    
}

/**
 *  获得当前时间字符串
 *
 *  @param format  时间格式字符串
 *
 *  @return 时间字符串
 */
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



#pragma mark - 弹出窗口

- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}



#pragma mark - 懒加载
- (NSMutableArray *)AllTable{
    
    if (_AllTable == nil) {
        _AllTable = [NSMutableArray array];
        
    }
    return _AllTable;
}

- (NSMutableArray *)AreasArr{
    
    if (_AreasArr == nil) {
        _AreasArr = [NSMutableArray array];
    }
    return _AreasArr;
}



- (NSMutableArray *)tmpArr{
    
    if (_tmpArr == nil) {
        _tmpArr = [NSMutableArray array];
    }
    return _tmpArr;
}

-(NSMutableArray *)sectionArr{
    
    if (_sectionArr == nil) {
        _sectionArr = [NSMutableArray array];
    }
    return _sectionArr;
}

- (NSMutableArray *)tmpAreasArr{
    
    if (_tmpAreasArr == nil) {
        _tmpAreasArr = [NSMutableArray array];
    }
    return _tmpAreasArr;
}

@end
