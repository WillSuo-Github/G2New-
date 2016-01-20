//
//  CaoZuoViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "CaoZuoViewController.h"
#import "HttpTool.h"
#import "NDLBusinessConfigure.h"
#import "NDLFrameworkHeader.h"



@interface CaoZuoViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
    NSString *ccdsId;
    NSString *_suopingIndex;
    NSString *_kaitaihouIndex;
    NSString *_yudinghouIndex;
    NSString *_xiandanquerenIndex;
    NSString *_xiadanhouIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *suopingseting;
@property (weak, nonatomic) IBOutlet UIButton *kaitaihou;
@property (weak, nonatomic) IBOutlet UIButton *yudinghou;
@property (weak, nonatomic) IBOutlet UIButton *xiadanqueren;
@property (weak, nonatomic) IBOutlet UIButton *xiadanhou;


//添加的tableView
@property (nonatomic, strong) UITableView *suopingTable;
@property (nonatomic, strong) UITableView *kaitaihouTable;
@property (nonatomic, strong) UITableView *yudinghouTable;
@property (nonatomic, strong) UITableView *xiadanquerenTable;
@property (nonatomic, strong) UITableView *xiadanhouTable;

//字体颜色
@property (weak, nonatomic) IBOutlet UILabel *likaisuoping;
@property (weak, nonatomic) IBOutlet UILabel *kaitaihou1;
@property (weak, nonatomic) IBOutlet UILabel *yudingchenggonghou1;

@property (weak, nonatomic) IBOutlet UILabel *xianshixiadanquerenchuangkou;
@property (weak, nonatomic) IBOutlet UILabel *xiadan1;
@property (weak, nonatomic) IBOutlet UIButton *quxiao1;
@property (weak, nonatomic) IBOutlet UIButton *queren1;

@end

@implementation CaoZuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    //字体颜色 边框圆角
    self.likaisuoping.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.kaitaihou1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.yudingchenggonghou1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.xianshixiadanquerenchuangkou.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.xiadan1.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    self.quxiao1.layer.cornerRadius=5;
    self.queren1.layer.cornerRadius=5;
    //“取消”文字的颜色
    [self.quxiao1 setTitleColor:[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1] forState:UIControlStateNormal];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
    self.suopingseting.layer.borderWidth = 1;
    self.suopingseting.layer.cornerRadius = 5;
    self.suopingseting.layer.masksToBounds = YES;
    self.suopingseting.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    self.kaitaihou.layer.borderWidth = 1;
    self.kaitaihou.layer.cornerRadius = 5;
    self.kaitaihou.layer.masksToBounds = YES;
    self.kaitaihou.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    self.yudinghou.layer.borderWidth = 1;
    self.yudinghou.layer.cornerRadius = 5;
    self.yudinghou.layer.masksToBounds = YES;
    self.yudinghou.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    self.xiadanqueren.layer.borderWidth = 1;
    self.xiadanqueren.layer.cornerRadius = 5;
    self.xiadanqueren.layer.masksToBounds = YES;
    self.xiadanqueren.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    self.xiadanhou.layer.borderWidth = 1;
    self.xiadanhou.layer.cornerRadius = 5;
    self.xiadanhou.layer.masksToBounds = YES;
    self.xiadanhou.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    
    [self setUpTableView];
    
    [self requestccdsId];
    
    [self readUserDefin];
}

- (void)readUserDefin{
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.tag = 1;
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:KSUOPINGINDEX];
    [self.suopingseting setTitle:[NSString stringWithFormat:@"%@分钟",str] forState:UIControlStateNormal];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:str.integerValue inSection:0];
    
    
    tableView.tag = 2;
    str = [[NSUserDefaults standardUserDefaults] objectForKey:KKAITAIHOUINDEX];
    indexPath = [NSIndexPath indexPathForRow:str.integerValue inSection:0];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    tableView.tag = 3;
    str = [[NSUserDefaults standardUserDefaults] objectForKey:KYUDINGHOUINDEX];
    indexPath = [NSIndexPath indexPathForRow:str.integerValue inSection:0];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    tableView.tag = 4;
    str = [[NSUserDefaults standardUserDefaults] objectForKey:KXIANDANQUERENINDEX];
    indexPath = [NSIndexPath indexPathForRow:str.integerValue inSection:0];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    tableView.tag = 5;
    str = [[NSUserDefaults standardUserDefaults] objectForKey:KXIADANHOUINDEX];
    indexPath = [NSIndexPath indexPathForRow:str.integerValue inSection:0];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}


- (void)requestccdsId{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting?returnJson=json",ceshiIP];
    
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
        NSDictionary *dict = [responseObject objectForKey:@"cashierDeskSetting"];
        ccdsId = [dict objectForKey:@"ccdsId"];
        
    } failure:^(NSError *error) {
        NSLog(@"CaoZuoViewController%@",error);
    }];
}
- (void)setUpTableView{
    //锁屏
    UITableView *suopingTable = [[UITableView alloc] init];
    suopingTable.tag = 1;
    suopingTable.delegate = self;
    suopingTable.dataSource = self;
    suopingTable.frame = CGRectMake(self.suopingseting.x, self.suopingseting.y + 34, self.suopingseting.width, 44 * 6);
    suopingTable.tableFooterView= [[UIView alloc] init];
    suopingTable.hidden = YES;
    _suopingTable = suopingTable;
    [self.view addSubview:suopingTable];
    suopingTable.layer.cornerRadius=5;
    suopingTable.layer.borderWidth=1;
    suopingTable.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    suopingTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //开台后
    UITableView *kaitaiTable = [[UITableView alloc] init];
    kaitaiTable.tag = 2;
    kaitaiTable.delegate = self;
    kaitaiTable.dataSource = self;
    kaitaiTable.frame = CGRectMake(self.kaitaihou.x, self.kaitaihou.y + 34, self.kaitaihou.width, 44 * 2);
    kaitaiTable.tableFooterView= [[UIView alloc] init];
    kaitaiTable.hidden = YES;
    _kaitaihouTable = kaitaiTable;
    [self.view addSubview:kaitaiTable];
    kaitaiTable.layer.cornerRadius=5;
    kaitaiTable.layer.borderWidth=1;
    kaitaiTable.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    kaitaiTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //预订成功后
    UITableView *yudinghouTable = [[UITableView alloc] init];
    yudinghouTable.tag = 3;
    yudinghouTable.delegate = self;
    yudinghouTable.dataSource = self;
    yudinghouTable.frame = CGRectMake(self.yudinghou.x, self.yudinghou.y + 34, self.yudinghou.width, 44 * 2);
    yudinghouTable.tableFooterView= [[UIView alloc] init];
    yudinghouTable.hidden = YES;
    _yudinghouTable = yudinghouTable;
    [self.view addSubview:yudinghouTable];
    yudinghouTable.layer.cornerRadius=5;
    yudinghouTable.layer.borderWidth=1;
    yudinghouTable.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    yudinghouTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //显示下单确认窗口
    UITableView *xiadanquerenTable = [[UITableView alloc] init];
    xiadanquerenTable.tag = 4;
    xiadanquerenTable.delegate = self;
    xiadanquerenTable.dataSource = self;
    xiadanquerenTable.frame = CGRectMake(self.xiadanqueren.x, self.xiadanqueren.y + 34, self.xiadanqueren.width, 44 * 2);
    xiadanquerenTable.tableFooterView= [[UIView alloc] init];
    xiadanquerenTable.hidden = YES;
    _xiadanquerenTable = xiadanquerenTable;
    [self.view addSubview:xiadanquerenTable];
    xiadanquerenTable.layer.cornerRadius=5;
    xiadanquerenTable.layer.borderWidth=1;
    xiadanquerenTable.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    xiadanquerenTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下单后
    UITableView *xiadanhouTable = [[UITableView alloc] init];
    xiadanhouTable.tag = 5;
    xiadanhouTable.delegate = self;
    xiadanhouTable.dataSource = self;
    xiadanhouTable.frame = CGRectMake(self.xiadanhou.x, self.xiadanhou.y + 34, self.xiadanhou.width, 44 * 3);
    xiadanhouTable.tableFooterView= [[UIView alloc] init];
    xiadanhouTable.hidden = YES;
    _xiadanhouTable = xiadanhouTable;
    [self.view addSubview:xiadanhouTable];
    xiadanhouTable.layer.cornerRadius=5;
    xiadanhouTable.layer.borderWidth=1;
    xiadanhouTable.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    xiadanhouTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self setUpOneTableViewWith:5 baseView:self.xiadanhou PlulicTable:self.xiadanhouTable cellNum:3];
}


////尝试着抽出公共的方法，但是不知道为什么不起作用0.0
//- (void)setUpOneTableViewWith:(NSInteger)tag baseView:(UIButton *)button PlulicTable:(UITableView *)Ptable cellNum:(NSInteger)num{
//    
//    UITableView *tableView = [[UITableView alloc] init];
//    tableView.tag = tag;
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    tableView.frame = CGRectMake(button.x, button.y + 34, button.width, 44 * num);
//    tableView.tableFooterView = [[UIView alloc] init];
//    tableView.hidden = YES;
//    Ptable = tableView;
//    [self.view addSubview:tableView];
//}


- (IBAction)suoping:(id)sender {
    

    [self HiddenOtherWithOneTable:self.suopingTable];
    
}
- (IBAction)kaitaihou:(id)sender {

    [self HiddenOtherWithOneTable:self.kaitaihouTable];
}
- (IBAction)yudinghou:(id)sender {

    [self HiddenOtherWithOneTable:self.yudinghouTable];
}
- (IBAction)xiadanqueren:(id)sender {

    [self HiddenOtherWithOneTable:self.xiadanquerenTable];
}
- (IBAction)xiadanhou:(id)sender {

    [self HiddenOtherWithOneTable:self.xiadanhouTable];
}

- (void)HiddenOtherWithOneTable:(UITableView *)tableView{
    
    self.suopingTable.hidden = YES;
    self.kaitaihouTable.hidden = YES;
    self.yudinghouTable.hidden = YES;
    self.xiadanquerenTable.hidden = YES;
    self.xiadanhouTable.hidden = YES;
    tableView.hidden = NO;
}

- (IBAction)cancle:(id)sender {
    
    
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"取消更改设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    
}

   
    
    
    

- (IBAction)queding:(id)sender {

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:ccdsId,@"id",_kaitaihouIndex,@"isStartEnterOrder",_yudinghouIndex,@"isOrderEnterDesk",_xiandanquerenIndex,@"isShowPlaceBillConfirmWindow",_xiadanhouIndex,@"billPlaceEnterDeskOrPay", nil];
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting/update",ceshiIP];
    [HttpTool POST:urlStr parameters:dict success:^(id responseObject) {
        
        NSString *message = [responseObject objectForKey:@"message"];
        

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alertView show];
    } failure:^(NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:ccdsId,@"otherId",_suopingIndex,@"leaveTime", nil];
    NSString *str = [NSString stringWithFormat:@"%@/canyin-frontdesk/system/setting/updateOther",ceshiIP];
    [HttpTool POST:str parameters:dic success:^(id responseObject) {
        

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 1) {
        return 6;
    }else if (tableView.tag == 2){
        return 2;
    }else if (tableView.tag == 3){
        return 2;
    }else if (tableView.tag == 4){
        return 2;
    }else if (tableView.tag == 5){
        return 3;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
   
    if (tableView.tag == 1) {
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"不锁屏";
                break;
            case 1:
                cell.textLabel.text = @"5分钟";
                break;
            case 2:
                cell.textLabel.text = @"10分钟";
                break;
            case 3:
                cell.textLabel.text = @"20分钟";
                break;
            case 4:
                cell.textLabel.text = @"30分钟";
                break;
            case 5:
                cell.textLabel.text = @"60分钟";
                break;
            default:
                break;
        }
        cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
        
    }else if (tableView.tag == 2){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"留在空白页面";
                break;
            case 1:
                cell.textLabel.text = @"进入点餐界面";
                break;
            default:
                break;
        }
        cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    }else if (tableView.tag == 3){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"留在预定页";
                break;
            case 1:
                cell.textLabel.text = @"进入点餐界面";
                break;
            default:
                break;
        }
        cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    }else if (tableView.tag == 4){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"关闭";
                break;
            case 1:
                cell.textLabel.text = @"开启";
                break;
            default:
                break;
        }
        cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    }else if (tableView.tag == 5){
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"空闲台";
                break;
            case 1:
                cell.textLabel.text = @"进入餐台界面";
                break;
            case 2:
                cell.textLabel.text = @"进入结账界面";
                break;
            default:
                break;
        }
        cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
        
    }
cell.textLabel.textAlignment=NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1) {
        
        
        self.suopingTable.hidden =YES;
        switch (indexPath.row) {
            case 0:
                [self.suopingseting setTitle:@"不锁屏" forState:UIControlStateNormal];
                _suopingIndex = @"0";
                break;
            case 1:
                _suopingIndex = @"5";
                [self.suopingseting setTitle:@"5分钟" forState:UIControlStateNormal];
                break;
            case 2:
                _suopingIndex = @"10";
                [self.suopingseting setTitle:@"10分钟" forState:UIControlStateNormal];
                break;
            case 3:
                _suopingIndex = @"20";
                [self.suopingseting setTitle:@"20分钟" forState:UIControlStateNormal];
                break;
            case 4:
                _suopingIndex = @"30";
                [self.suopingseting setTitle:@"30分钟" forState:UIControlStateNormal];
                break;
            case 5:
                _suopingIndex = @"60";
                [self.suopingseting setTitle:@"60分钟" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }else if (tableView.tag == 2){
        self.kaitaihouTable.hidden = YES;
        _kaitaihouIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
        
        switch (indexPath.row) {
            case 0:
                
                [self.kaitaihou setTitle:@"留在空白台页面" forState:UIControlStateNormal];
                break;
            case 1:
                [self.kaitaihou setTitle:@"进入点餐界面" forState:UIControlStateNormal];
                
                break;
            
            default:
                break;
        }
                
    }else if (tableView.tag == 3){
        self.yudinghouTable.hidden = YES;
        _yudinghouIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
        

        switch (indexPath.row) {
            case 0:
                
                [self.yudinghou setTitle:@"留在预定页" forState:UIControlStateNormal];
                break;
            case 1:
                [self.yudinghou setTitle:@"进入点餐界面" forState:UIControlStateNormal];
                
                break;
                
            default:
                break;
        }
    }else if (tableView.tag == 4){
        self.xiadanquerenTable.hidden = YES;
        _xiandanquerenIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
        

        switch (indexPath.row) {
            case 0:
                
                [self.xiadanqueren setTitle:@"关闭" forState:UIControlStateNormal];
                break;
            case 1:
                [self.xiadanqueren setTitle:@"开启" forState:UIControlStateNormal];
                
                break;
                
            default:
                break;
        }
    }else if (tableView.tag == 5){
        self.xiadanhouTable.hidden = YES;
        _xiadanhouIndex = [NSString stringWithFormat:@"%ld",indexPath.row];
        

        switch (indexPath.row) {
            case 0:
                
                [self.xiadanhou setTitle:@"哪也不去" forState:UIControlStateNormal];
                break;
            case 1:
                [self.xiadanhou setTitle:@"进入餐台界面" forState:UIControlStateNormal];
                
                break;
            case 2:
                
                [self.xiadanhou setTitle:@"进入结账界面" forState:UIControlStateNormal];
                break;
                
            default:
                break;
        }
        
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.suopingTable.hidden = YES;
    self.kaitaihouTable.hidden = YES;
    self.xiadanhouTable.hidden = YES;
    self.yudinghouTable.hidden = YES;
    self.xiadanquerenTable.hidden = YES;
}

#pragma mark - alertView的代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        [self readUserDefin];
    }
}

@end
