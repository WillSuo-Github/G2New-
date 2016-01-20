//
//  JYTuiHuoViewController.m
//  G2TestDemo
//
//  Created by wjy on 15/12/7.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "JYTuiHuoViewController.h"
#import "JYJiaoYiJiLuViewController.h"
#import "JYMainViewController.h"
#import "UIView+AdjustFrame.h"
BOOL hidden;
@interface JYTuiHuoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *TopView;
@property (weak, nonatomic) IBOutlet UILabel *TuiHuoYuanYin;
@property (weak, nonatomic) IBOutlet UIButton *TiJiaoButton;
@property (weak, nonatomic) IBOutlet UILabel *TuiHuoJinE;
@property (weak, nonatomic) IBOutlet UILabel *JinEFangShi;
//退货理由显示
@property (weak, nonatomic) IBOutlet UIButton *TuiHuoLiYou;
//支付方式
@property (weak, nonatomic) IBOutlet UILabel *payTypeNameLabel;

//添加的理由tableView
@property (nonatomic, strong) UITableView *LiYouTableView;

@end

@implementation JYTuiHuoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //支付方式和实收金额属性传值
    self.TuihuoNamber.text=self.consumption;
    self.payTypeNameLabel.text=self.ArrPayTypeName;
    
    NSLog(@"%@",self.consumption);
    self.TuiHuoLiYou.layer.borderWidth=1;
    self.TuiHuoLiYou.layer.cornerRadius=5;
    self.TuiHuoLiYou.layer.borderColor=[UIColor blackColor].CGColor;
    
    self.TuihuoNamber.layer.borderWidth=1;
    self.TuihuoNamber.layer.cornerRadius=5;
    self.TuihuoNamber.layer.borderColor=[UIColor blackColor].CGColor;

    self.TuiHuoYuanYin.layer.borderWidth=1;
    self.TuiHuoYuanYin.layer.cornerRadius=5;
    self.TuiHuoYuanYin.layer.borderColor=[UIColor blackColor].CGColor;
    
    self.TuiHuoJinE.layer.borderWidth=1;
    self.TuiHuoJinE.layer.cornerRadius=5;
    self.TuiHuoJinE.layer.borderColor=[UIColor blackColor].CGColor;
    
    self.JinEFangShi.layer.borderWidth=1;
    self.JinEFangShi.layer.cornerRadius=5;
    self.JinEFangShi.layer.borderColor=[UIColor blackColor].CGColor;
    
    self.payTypeNameLabel.layer.borderWidth=1;
    self.payTypeNameLabel.layer.cornerRadius=5;
    self.payTypeNameLabel.layer.borderColor=[UIColor blackColor].CGColor;
    
    
    self.TopView.backgroundColor=[UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
    self.TiJiaoButton.layer.cornerRadius=5;
    self.TiJiaoButton.backgroundColor=[UIColor colorWithRed:27/255.0 green:156/255.0 blue:253/255.0 alpha:1];
    //调用下拉选项方法
    [self setUpTableView];
    
}

    // Do any additional setup after loading the view from its nib.
//返回
- (IBAction)FanHuiButton:(id)sender {
    JYJiaoYiJiLuViewController *JY=[[JYJiaoYiJiLuViewController alloc]init];
    [[JYMainViewController sharedMainView]MainViewInsertSubviewWith:JY];
}
- (IBAction)LIYou:(id)sender {
    
 [self XiaLaCaiDan:self.LiYouTableView and:nil];
}

//下拉菜单点击
-(void)XiaLaCaiDan:(UITableView *)senderA and:(UITableView *)senderB{

    if (senderA.hidden==NO) {
        senderA.hidden=YES;
        senderB.hidden=YES;
        hidden=NO;
        
    } else {
        
        senderA.hidden=NO;
        senderB.hidden=YES;
        hidden=YES;
        
    }
}

//提交
- (IBAction)TiJiao:(id)sender {
    
    
    
    
}
-(void)setUpTableView{
    
    //退货理由
    UITableView *TuiHuo=[[UITableView alloc]init];
    TuiHuo.tag=1;
    TuiHuo.delegate=self;
    TuiHuo.dataSource=self;
    TuiHuo.frame=CGRectMake(self.TuiHuoLiYou.x, self.TuiHuoLiYou.y+50, self.TuiHuoLiYou.width, 45*5);
    TuiHuo.hidden = YES;
    _LiYouTableView = TuiHuo;
    [self.view addSubview:TuiHuo];
    TuiHuo.layer.cornerRadius=5;
    TuiHuo.layer.borderWidth=1;
    TuiHuo.layer.borderColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1].CGColor;
    TuiHuo.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (tableView.tag==1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"不喜欢";
                break;
            case 1:
                cell.textLabel.text = @"不喜欢";
                break;
            case 2:
                cell.textLabel.text = @"不喜欢";
                break;
            case 3:
                cell.textLabel.text = @"不喜欢";
                break;
            case 4:
                cell.textLabel.text = @"不喜欢";
                break;
            default:
                break;
                
                
        }

        
    }
    cell.textLabel.textAlignment=NSTextAlignmentCenter;

    cell.textLabel.textColor=[UIColor colorWithRed:105/255.0 green:105/255.0 blue:105/255.0 alpha:1];
            return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.LiYouTableView.hidden=YES;
    if (tableView.tag==1) {
        switch (indexPath.row) {
            case 0:
                [self.TuiHuoLiYou setTitle:@"不喜欢" forState:UIControlStateNormal];
                break;
            case 1:
                [self.TuiHuoLiYou setTitle:@"不喜欢" forState:UIControlStateNormal];
                break;
                
            case 2:
                [self.TuiHuoLiYou setTitle:@"不喜欢" forState:UIControlStateNormal];
                break;
                
            case 3:
                [self.TuiHuoLiYou setTitle:@"不喜欢" forState:UIControlStateNormal];
                break;
                
            case 4:
                [self.TuiHuoLiYou setTitle:@"不喜欢" forState:UIControlStateNormal];
                break;
                
                
            default:
                break;
        }
        
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    self.LiYouTableView.hidden=YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
