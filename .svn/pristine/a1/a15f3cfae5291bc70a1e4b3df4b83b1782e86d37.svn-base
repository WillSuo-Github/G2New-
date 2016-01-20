//
//  GuQingViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#define GrayBiy [UIColor colorWithRed:105/250.0 green:105/250.0 blue:105/250.0 alpha:1]
#define BlueBiy [UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1]
#import "GuQingViewController.h"
#import "FoodCell.h"
#import "topRG.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "OrderTool.h"
#import "GuQingNumController.h"
#import "guqingonePg.h"
#import "CaiPG.h"

@interface GuQingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UIAlertViewDelegate,GuQingNumControllerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UICollectionViewDelegateFlowLayout>{
    NSString *_categoryId;
    NSString *_estimateStatus;
    NSString *_dishesType;

    
    
    
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *quanbu;
@property (weak, nonatomic) IBOutlet UIButton *yiguqing;
@property (weak, nonatomic) IBOutlet UIButton *weiguqing;
@property (weak, nonatomic) IBOutlet UIButton *yishouqing;
@property (weak, nonatomic) IBOutlet UIButton *jijiangshouwan;
@property (weak, nonatomic) IBOutlet UIView *topView;
//按钮圆角和字体颜色
@property (weak, nonatomic) IBOutlet UIButton *guqing1;
@property (weak, nonatomic) IBOutlet UIButton *quxiaoguqing1;
@property (weak, nonatomic) IBOutlet UIButton *quanbuquxiao1;
@property (weak, nonatomic) IBOutlet UILabel *shaixuan;
@property (weak, nonatomic) IBOutlet UITextField *searchBarTextField;
@property (weak, nonatomic) IBOutlet UILabel *guqingxuanxiang;
@property (nonatomic, strong) NSArray *topArr;
@property (nonatomic, strong) UIButton *selectBtn;
/**
 *  菜品数组
 */
@property (nonatomic, strong) NSArray *caiArr;
@property (nonatomic, strong) FoodCell *selectFoodCell;
@property (nonatomic, strong) GuQingNumController *guqingVc;
@property (nonatomic, strong) UIView *coverView;
@property (strong,nonatomic) CaiPG *caiPG;

//定义一个可记录的数组
@property (strong,nonatomic) NSMutableArray *duoxuanArr;
@end

@implementation GuQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化多选组组
    self.duoxuanArr = [[NSMutableArray alloc]init];
    self.quxiaoguqing1.backgroundColor = GrayBiy;
    self.quxiaoguqing1.userInteractionEnabled = NO;
    self.quanbuquxiao1.backgroundColor = BlueBiy;
    self.quanbuquxiao1.userInteractionEnabled = YES;
    self.guqing1.userInteractionEnabled = NO;
    self.guqing1.backgroundColor = GrayBiy;
//    self.quanbuquxiao1.userInteractionEnabled=NO;
    //刚进沽清界面是  只有全部沽清可以被点击颜色为蓝色  取消沽清和沽清不能点击为灰色  王京阳
    
//    self.quanbuquxiao1.userInteractionEnabled=YES;
//    self.quxiaoguqing1.userInteractionEnabled=NO;
//    self.guqing1.userInteractionEnabled=NO;
//    self.guqing1.backgroundColor = GrayBiy;
//    self.quxiaoguqing1.backgroundColor = GrayBiy;
//    self.quxiaoguqing1.backgroundColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
//    self.guqing1.backgroundColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
       
    
    //搜索框颜色
    self.searchBarTextField.layer.borderWidth=1;
    self.searchBarTextField.layer.borderColor=[UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1].CGColor;
    self.searchBarTextField.returnKeyType = UIReturnKeyDone;
    self.searchBarTextField.delegate = self;
    
    
    
    //按钮圆角
    self.guqingxuanxiang.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    self.guqing1.layer.cornerRadius=5;
    self.quxiaoguqing1.layer.cornerRadius=5;
    self.quanbuquxiao1.layer.cornerRadius=5;
    self.quanbu.layer.cornerRadius=5;
    self.yiguqing.layer.cornerRadius=5;
    self.weiguqing.layer.cornerRadius=5;
    self.yishouqing.layer.cornerRadius=5;
    self.jijiangshouwan.layer.cornerRadius=5;
    self.shaixuan.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
    
    
    // Do any additional setup after loading the view from its nib.
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(108, 150)];//设置cell的尺寸
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);//设置其边界
    self.collectionView.collectionViewLayout = flowLayout;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self RequestTopView];
    
    _categoryId = @"";
    _estimateStatus = @"";

}
- (IBAction)guqing:(id)sender {
    
   
   UIView * baseView= [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.width- 238, self.view.height)];
    baseView.backgroundColor = [UIColor blackColor];
    baseView.alpha = 0.2;
    self.coverView = baseView;
    [kKeyWindow addSubview:baseView];
    
    GuQingNumController *guqingNum = [[GuQingNumController alloc] init];
    //菜名属性传旨 
    guqingNum.caimingStr= self.caiPG.dishesName;
    guqingNum.view.frame = CGRectMake(280, 90, 390, 440);
    guqingNum.delegate = self;
    
    self.guqingVc = guqingNum;
    
    [kKeyWindow addSubview:guqingNum.view];
//    [self.collectionView reloadData];
//    [self.guqingVc.view removeFromSuperview];
    

    
    
}




- (IBAction)quxiaoguqing:(id)sender {
   
    if ([self.selectFoodCell.caipg.dishAndSetDiv isEqualToString:@"2"]) {
        _dishesType = @"2";
        [self.collectionView reloadData];
       
        
    }else{
        self.quxiaoguqing1.selected=NO;
        _dishesType = @"1";
      
    }
   
    guqingonePg *guqingpg = [[guqingonePg alloc] init];
    guqingpg.dishesId = self.selectFoodCell.caipg.dishesId;
    NSString *str = nil;
    if (self.duoxuanArr.count == 1) {
        str = [NSString stringWithFormat:@"取消“%@”沽清？",self.caiPG.dishesName];
    }
    else{
       str = @"确定取消所选菜品沽清？";
    }
    
    //王洪昌
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 1314;
    [alert show];
    
}

- (IBAction)quanbuquxiao:(id)sender {
    
    if (!self.quanbuquxiao1.selected) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"全部取消" message:@"确定取消菜品沽清？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 1;
        [alert show];
        

    }
    
    [self.collectionView reloadData];
   
    
}

- (IBAction)quanbu:(id)sender {
    
    _estimateStatus = @"";
    [self requestCaiArr];
}
- (IBAction)yiguqing:(id)sender {
    
    _estimateStatus = @"1";
    [self requestCaiArr];
}
- (IBAction)weiguqing:(id)sender {
    
    _estimateStatus = @"4";
    [self requestCaiArr];
}
- (IBAction)yishouqing:(id)sender {
    
    _estimateStatus = @"2";
    [self requestCaiArr];
}
- (IBAction)jijiangshouwan:(id)sender {
    
    _estimateStatus = @"3";
    [self requestCaiArr];
}

- (void)RequestTopView{
    
    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/estimate/ajax/dishes/list?estimateStatus=&categoryId=&dsCategoryId=&returnJson=json",ceshiIP];
//    NSString *urlString = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/ajax/diancaiContent?billType=1&billId=297efab34e2444cb014e24472b5b0006&returnJson=json",ceshiIP];
    [HttpTool POST:urlString parameters:nil success:^(id responseObject) {
        
        _topArr = [responseObject objectForKey:@"dishesCategorys"];
        _topArr = [topRG objectArrayWithKeyValuesArray:self.topArr];
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = 100;
        [self topButtonChick:btn];
        self.quxiaoguqing1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.userInteractionEnabled = NO;
        self.quanbuquxiao1.backgroundColor = BlueBiy;
        self.quanbuquxiao1.userInteractionEnabled = YES;
        self.guqing1.userInteractionEnabled = NO;
        self.guqing1.backgroundColor = GrayBiy;
        NSLog(@"category count :%@",self.topArr);
        [self setUpTopViewWithCount:_topArr.count];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)topButtonChick:(UIButton *)sender {
    
    self.selectBtn.selected = NO;
    self.selectBtn = sender;
    self.selectBtn.selected = YES;

    
    NSString *pragram;
    if (sender.tag == 100) {
        pragram = @"";
    }else{
        topRG *topPg = self.topArr[sender.tag];
        pragram = topPg.categoryId;
    }
    _categoryId = pragram;
    [self requestCaiArr];
    
}

- (void)requestCaiArr{
    
    //以后需要添加 关键字
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/estimate/ajax/dishes/list?returnJson=json&estimateStatus=%@&categoryId=%@",ceshiIP,_estimateStatus,_categoryId];
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"dishes"];
        NSArray *arr = [dict objectForKey:@"content"];
        self.caiArr = [CaiPG objectArrayWithKeyValuesArray:arr];
        [self.collectionView reloadData];

        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setUpTopViewWithCount:(NSInteger)count{
    
    CGFloat btnx;
    CGFloat btnY;
    CGFloat btnW = 80;
    CGFloat btnH;
    
    UIScrollView *topScrollView = [[UIScrollView alloc] initWithFrame:self.topView.bounds];
    topScrollView.contentSize = CGSizeMake(btnW * (count + 1), self.topView.height);
    [self.topView addSubview:topScrollView];
    
    UIButton *quanbuBtn  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnW, self.topView.height)];
    [self setTopBtnStyleWithBtn:quanbuBtn title:@"全部"];
    quanbuBtn.tag = 100;
    quanbuBtn.selected = YES;
    [quanbuBtn setTitleColor:[UIColor colorWithRed:105/250.0 green:109/250.0 blue:113/250.0 alpha:1] forState:UIControlStateNormal];
    self.selectBtn = quanbuBtn;
    [topScrollView addSubview:quanbuBtn];
    
    for (int i = 0; i < count; ++i)
    {
        UIButton *btn = [[UIButton alloc] init];
        btnH = self.topView.height;
        btnx = (i + 1) * btnW;
        btnY = 0;
        btn.frame = CGRectMake(btnx, btnY, btnW, btnH);
        topRG *topPg = self.topArr[i];
        btn.tag = i;
        [self setTopBtnStyleWithBtn:btn title:topPg.categoryName];
        [topScrollView addSubview:btn];
        [btn setTitleColor:[UIColor colorWithRed:105/255.0 green:109/255.0 blue:113/255.0 alpha:1] forState:UIControlStateNormal];
    }
}

- (void)setTopBtnStyleWithBtn:(UIButton *)btn title:(NSString *)title{
    
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"dck"] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(topButtonChick:) forControlEvents:UIControlEventTouchUpInside];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - collectionView的数据源和代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.caiArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"collectCell";
    
    UINib *nib = [UINib nibWithNibName:@"FoodCell" bundle:nil];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    
    
    FoodCell *food = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];

    food.caipg = self.caiArr[indexPath.row];
    food.image.image = [UIImage imageNamed:@"right_w"];
    food.isSelect = NO;
    return food;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"11111");
//    [self RequestTopView];
    int k = 0;
    for (NSIndexPath *inide in self.duoxuanArr) {
        if (inide == indexPath) {
            k = 1;
        }
    }if (k) {
        
        
         FoodCell *food = (FoodCell *)[collectionView cellForItemAtIndexPath:indexPath];
        food.image.image = [UIImage imageNamed:@"right_w"];
        [self.duoxuanArr removeObject:indexPath];
        if (self.duoxuanArr.count == 0) {
            self.quxiaoguqing1.backgroundColor = GrayBiy;
            self.quxiaoguqing1.userInteractionEnabled = NO;
            self.quanbuquxiao1.backgroundColor = BlueBiy;
            self.quanbuquxiao1.userInteractionEnabled = YES;
            self.guqing1.userInteractionEnabled = NO;
            self.guqing1.backgroundColor = GrayBiy;
        }
        
        
    }else{
        self.quxiaoguqing1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.userInteractionEnabled = NO;
        self.quanbuquxiao1.backgroundColor = BlueBiy;
        self.quanbuquxiao1.userInteractionEnabled = YES;
        self.guqing1.userInteractionEnabled = NO;
        self.guqing1.backgroundColor = GrayBiy;
       self.caiPG =  self.caiArr[indexPath.row];
       FoodCell *food = (FoodCell *)[collectionView cellForItemAtIndexPath:indexPath];
       CaiPG *cai = _caiArr[indexPath.row];
      if ((!food.shouqing.hidden)||[cai.estimate intValue]) {
        [self.duoxuanArr addObject:indexPath];
        
        
      }
      else{
        
        for (NSIndexPath *index in self.duoxuanArr) {
            FoodCell *cell1 = (FoodCell *)[collectionView cellForItemAtIndexPath:index];
            cell1.image.image = [UIImage imageNamed:@"right_w"];
        }
    
         [self.duoxuanArr removeAllObjects];
    
        
        
        
        
    }
    // 王洪昌 2015 11 23
    food.isSelect = NO;
    
    if (!food.isSelect) {
        if (((food.shouqing.hidden)&&(![cai.estimate intValue]))||(self.duoxuanArr.count == 1)) {
              self.selectFoodCell.image.image = [UIImage imageNamed:@"right_w"];
        }
    
        
        food.image.image = [UIImage imageNamed:@"right_g"];
        food.isSelect = YES;
        self.selectFoodCell = food;
        self.quanbuquxiao1.userInteractionEnabled=YES;
        self.quxiaoguqing1.userInteractionEnabled=YES;
        self.guqing1.userInteractionEnabled=YES;
        
    }else{
//                self.selectFoodCell.isSelect = NO;
        
        food.image.image = [UIImage imageNamed:@"right_w"];
        self.quanbuquxiao1.userInteractionEnabled=NO;
        self.quxiaoguqing1.userInteractionEnabled=NO;
        self.guqing1.userInteractionEnabled=NO;
        food.isSelect = NO;
        
        [self.duoxuanArr removeObject:indexPath];

    }
    
    
   
//    NSLog(@"%@",food.bageLable.text);
    
    
    
    //王京阳
    if ([cai.estimate intValue]) {
        self.quanbuquxiao1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.backgroundColor = BlueBiy;
        self.quxiaoguqing1.userInteractionEnabled = YES;
        self.quanbuquxiao1.userInteractionEnabled = NO;
        self.guqing1.userInteractionEnabled=NO;
        self.guqing1.backgroundColor=GrayBiy;

    }else if (food.shouqing.hidden){
    
        self.quanbuquxiao1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.userInteractionEnabled = NO;
        self.quanbuquxiao1.userInteractionEnabled = NO;
        self.guqing1.userInteractionEnabled=YES;
        self.guqing1.backgroundColor=BlueBiy;

    
    }
    else {
        
        self.quxiaoguqing1.backgroundColor=BlueBiy;
        self.quxiaoguqing1.userInteractionEnabled=YES;
        self.guqing1.userInteractionEnabled=NO;
        self.guqing1.backgroundColor=GrayBiy;
        self.quanbuquxiao1.userInteractionEnabled=NO;
        self.quanbuquxiao1.backgroundColor=GrayBiy;

        
    }
    //

    NSLog(@"%d",self.duoxuanArr.count);
    if (self.duoxuanArr.count>=2) {
        self.guqing1.userInteractionEnabled = NO;
        self.guqing1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.backgroundColor = BlueBiy;
        self.quxiaoguqing1.userInteractionEnabled = YES;
        self.quanbuquxiao1.backgroundColor = GrayBiy;
        self.quanbuquxiao1.userInteractionEnabled = NO  ;
    }else if (self.duoxuanArr.count == 0){
        self.quxiaoguqing1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.userInteractionEnabled = NO;
        self.quanbuquxiao1.backgroundColor = GrayBiy;
        self.quanbuquxiao1.userInteractionEnabled = NO;
        self.guqing1.userInteractionEnabled = YES;
        self.guqing1.backgroundColor = BlueBiy;
    } else if (self.duoxuanArr.count == 1){
        self.quxiaoguqing1.backgroundColor = BlueBiy;
        self.quxiaoguqing1.userInteractionEnabled = YES;
        self.quanbuquxiao1.backgroundColor = GrayBiy;
        self.quanbuquxiao1.userInteractionEnabled = NO;
        self.guqing1.userInteractionEnabled = YES;
        self.guqing1.backgroundColor = BlueBiy;
    
    }
        
        //
    }
    
}


#pragma mark - alertView的代理方法

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            NSString *str = [NSString stringWithFormat:@"%@/canyin-frontdesk/estimate/allQxguqing",ceshiIP];
            [HttpTool GET:str parameters:nil success:^(id responseObject) {
//                NSLog(@"%@",responseObject);
                self.quanbuquxiao1.backgroundColor = GrayBiy;
                [self showAlertViewWithMessage:@"全部取消成功"];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    }
    else if (alertView.tag == 1314){
        if (buttonIndex == 1) {
            NSMutableString * duoXuan = [NSMutableString string];
            for (NSIndexPath *index in self.duoxuanArr) {
                CaiPG * duoCai = self.caiArr[index.row];
                duoXuan = [NSMutableString stringWithFormat:@"%@,%@",duoXuan,duoCai.dishesId];
            }
            
            [duoXuan deleteCharactersInRange:NSMakeRange(0, 1)];
//            NSLog(@"9833333%@",duoXuan);
            self.quxiaoguqing1.backgroundColor=GrayBiy;
            self.quanbuquxiao1.userInteractionEnabled = NO;
            NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/estimate/qxguqingd/%@?dishesType=%@",ceshiIP,duoXuan,_dishesType];
            NSLog(@"983978787%@",urlStr);
            [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
                [self RequestTopView];
                //(@"取消沽清%ld成功",self.caiArr)
                
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
            
            
        }
        

    
    }
    else{
        
        [self.coverView removeFromSuperview];
        [self.guqingVc.view removeFromSuperview];
        [self RequestTopView];
    }

}

#pragma mark - guqingNum的代理方法

- (void)GuQingNumControllerDidChick:(GuQingViewController *)guqingVc num:(NSString *)num{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/estimate/pop/estimate/update",ceshiIP];
    self.selectFoodCell.bageNum = num;
    guqingonePg *guqing = [[guqingonePg alloc] init];
//    guqing.dishesId = self.selectFoodCell.caipg.d
//    NSLog(@"%@",self.selectFoodCell.caipg.dishesName);
    guqing.dishesId = self.selectFoodCell.caipg.dishesId;
    guqing.estimate = num.floatValue;
//    NSLog(@"%@",self.selectFoodCell.caipg.dishAndSetDiv);
    if ([self.selectFoodCell.caipg.dishAndSetDiv isEqualToString:@"2"]) {
        guqing.dishesType = @"2";
    }else{
        
        guqing.dishesType = @"1";
    }
    
//    NSLog(@"%@",guqing.keyValues);
    [HttpTool POST:urlStr parameters:guqing.keyValues success:^(id responseObject) {
//        NSLog(@"%@",responseObject);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"沽清成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 2;
        [alert show];
        //gu沽清成功后默认键盘 王洪昌
        self.quxiaoguqing1.backgroundColor = GrayBiy;
        self.quxiaoguqing1.userInteractionEnabled = NO;
        self.quanbuquxiao1.backgroundColor = BlueBiy;
        self.quanbuquxiao1.userInteractionEnabled = YES;
        self.guqing1.userInteractionEnabled = NO;
        self.guqing1.backgroundColor = GrayBiy;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
-(void)guqingChahao:(GuQingNumController *)guqingCha{
    
    [self.guqingVc.view removeFromSuperview];
    [self.coverView removeFromSuperview];
  

       
}
- (void)showAlertViewWithMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}


/**
 *  此方法 实现条件查询
 *
 *
 */
#pragma UITextFiledDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.searchBarTextField resignFirstResponder];
    [self getConditionSearchTextResultMethod:textField.text];
    return YES;
}


/**
 *  此方法 实现条件查询
 *
 *
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self getConditionSearchTextResultMethod:textField.text];
    
}

-(void)getConditionSearchTextResultMethod:(NSString *)conditionStr
{
    
    NSString *categoryStr = [self getDishCategory];
    NSLog(@"categoryStr:%@",categoryStr);
    
    if ([categoryStr isEqualToString:@"全部"]) {
        categoryStr = @"";
        
    }
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/estimate/ajax/dishes/list?returnJson=json&estimateStatus=%@&keywords=%@",ceshiIP,_estimateStatus,conditionStr];
     NSDictionary *dic = @{@"categoryId=%@":categoryStr};
    NSLog(@"estimate  request URL:%@",urlStr);
    [HttpTool GET:urlStr parameters:dic success:^(id responseObject) {
        NSLog(@"estimate   response %@",responseObject);
        NSDictionary *dict = [responseObject objectForKey:@"dishes"];
        NSArray *arr = [dict objectForKey:@"content"];
        self.caiArr = [CaiPG objectArrayWithKeyValuesArray:arr];
        [self.collectionView reloadData];
        //self.searchBarTextField.text = @"";
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


/**
 *  此方法  获取菜品分类
 *
 *
 */
-(NSString *)getDishCategory
{
    NSString *categoryStr = nil;
    
    
    //NSLog(@"subView count :%ld",self.topView.subviews.count);
    
   // UIView *backgroundView = [self.topView.subviews objectsAtIndexes:];
    
    for (UIView *background  in self.topView.subviews) {
        if ([background isKindOfClass:[UIScrollView class]]) {
            for (UIView *tmpButton in background.subviews ) {
                
                if ([tmpButton isKindOfClass:[UIButton class]]) {
                    UIButton *tmpButton2 =(UIButton *)tmpButton;
                    
                    
                    if (tmpButton2.selected == YES) {
                        
                        categoryStr = tmpButton2.titleLabel.text;
                        break;
                        
                    }
                }
            }
        }
    }
    
    return categoryStr;
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
