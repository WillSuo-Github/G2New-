//
//  TiHuanController.m
//  G2TestDemo
//
//  Created by lcc on 15/9/7.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "TiHuanController.h"
#import "TiHuanCaiPinCell.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "replacePG.h"
#import "OrderViewController.h"
#import "JiKouCell.h"


@interface TiHuanController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
@property (weak, nonatomic) IBOutlet UICollectionView *jikouCollectView;

@property (nonatomic, strong) NSMutableArray *replaceArr;

@property (nonatomic, strong) UIButton *selectBtn;

@property(assign,nonatomic)int flag;

//忌口
@property (weak, nonatomic) IBOutlet UIButton *jila;
@property (weak, nonatomic) IBOutlet UIButton *jijiang;
@property (weak, nonatomic) IBOutlet UIButton *jisuan;
@property (weak, nonatomic) IBOutlet UIButton *jixiangcai;
@property (weak, nonatomic) IBOutlet UIButton *jihuajiao;
@property (weak, nonatomic) IBOutlet UIButton *jiconghua;
@property (weak, nonatomic) IBOutlet UIButton *huimingjikou;
@property (weak, nonatomic) IBOutlet UIButton *jiyou;


//忌口ID
@property(copy,nonatomic)NSMutableString *cdaId;
@property (strong,nonatomic)NSMutableArray *arrJiKou;
@end

@implementation TiHuanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrJiKou = [NSMutableArray array];
    self.cdaId = @"";
    [self jikouQingQiu];
    // Do any additional setup after loading the view from its nib.
    
    self.textView.layer.borderColor = UIColor.grayColor.CGColor;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    
//    self.selectBtn.selected = NO;
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.tag = 1;
    self.jikouCollectView.tag = 2;
    
//    self.collectView.allowsMultipleSelection = NO;
    //zhux注销套餐
//    [self requestCanChangeInfo];
//    NSLog(@"%@",self.jikou);
}
-(void)jiKOuZhuangtai{
    if (self.jikou) {
        NSMutableArray *arrJ = [NSMutableArray arrayWithArray:[self.jikou componentsSeparatedByString:@","]];
        [arrJ removeObjectAtIndex:0];
        for (int i = 0 ; i < arrJ.count; i ++) {
            for (int j = 0; j < 8; j ++) {
                if ([arrJ[i] isEqualToString: self.arrJiKou[j]]) {
                    UILabel *la = [self.view viewWithTag:200 + j];
                    la.text = @"1";
                    UIButton *bu = [self.view viewWithTag:300 + j];
                    [bu setTitle:@"dfdf" forState:UIControlStateNormal];
//                    [bu removeFromSuperview];
                    bu.selected = NO;
                    [self setButtonStateImage:bu];
                }
            }
        }
        
        
    }

}
-(void)jikouQingQiu{
    NSString *url = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pop/dishCooking/update?returnJson=json",ceshiIP];
    NSString *str = self.jikou;
    [HttpTool GET:url parameters:nil success:^(id responseObject) {
        
        
        NSMutableArray *tmpArry = [responseObject objectForKey:@"dishesAvoidfoods"];
        NSMutableArray *arrJ = [NSMutableArray arrayWithArray:[str componentsSeparatedByString:@","]];
        for (int i = 0; i < tmpArry.count; i ++) {
            UILabel *la = [self.view viewWithTag:i + 200];
            la.text = tmpArry[i][@"name"];
            [self.arrJiKou addObject:tmpArry[i][@"cdaId"]];
           
        
            
            for (int k = 0 ; k < arrJ.count; k ++) {

                if ([arrJ[k] isEqualToString: self.arrJiKou[i]]){
                
                    UIButton *bu = [self.view viewWithTag:300 + i];
                    bu.selected = NO;
                    [self setButtonStateImage:bu];
                }
            }
          

        }
      
        
        
//        
//            NSMutableArray *arrJ = [NSMutableArray arrayWithArray:[self.jikou componentsSeparatedByString:@","]];
//        NSLog(@"2222%@",arrJ);
//            for (int i = 0 ; i < arrJ.count; i ++) {
//               
//                for (int j = 0; j < 8; j ++) {
//                  
//                    if ([arrJ[i] isEqualToString: self.arrJiKou[j]]) {
//                        
//                        UIButton *bu = [self.view viewWithTag:300 + j];
//                        [bu setTitle:@"dfdf" forState:UIControlStateNormal];
//                        //                    [bu removeFromSuperview];
//                        bu.selected = NO;
//                        [self setButtonStateImage:bu];
//                    }
//               }
//            }
        
            
        
//        UILabel *la= [self.view viewWithTag:200 + k];
//        la.text = @"1";
        
    } failure:^(NSError *error) {
        NSLog(@"失败");
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestCanChangeInfo{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/canyin-frontdesk/bill/pop/replaceDishesContent/%@/%@?returnJson=json",ceshiIP,self.taocanID,self.dedishID];
    NSLog(@"%@",urlStr);
    [HttpTool GET:urlStr parameters:nil success:^(id responseObject) {
        
//        NSLog(@"%@",responseObject);
        NSArray *arr = [responseObject objectForKey:@"dishesSetDishesReplaces"];
        self.replaceArr = [replacePG objectArrayWithKeyValuesArray:arr];
        NSLog(@"%@",self.replaceArr);
        [self.collectView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark - collectionView的数据源及代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
        //    return self.caiArr.count;
    if (self.collectView.tag == 1) {
        return self.replaceArr.count;
    }else{
        
        return 10;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.collectView.tag == 1) {
        
        static NSString *ID = @"collectCell";
        UINib *nib = [UINib nibWithNibName:@"TiHuanCaiPinCell" bundle:nil];
        
        [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
        
        
        TiHuanCaiPinCell *tihuancaipin = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        tihuancaipin.replacePg = self.replaceArr[indexPath.row];
        tihuancaipin.btn.tag = indexPath.row;
        [tihuancaipin.btn addTarget:self action:@selector(tihuanCellChick:) forControlEvents:UIControlEventTouchUpInside];
    
        return tihuancaipin;
    }else{
        
        static NSString *ID = @"CELL";
        UINib *nib = [UINib nibWithNibName:@"JiKouCell" bundle:nil];
        
        [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
        
        JiKouCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        
        return cell;
    }
    
    
}


- (void)tihuanCellChick:(UIButton *)btn{
    
    NSLog(@"1111");
    self.selectBtn.selected = NO;
    self.selectBtn = btn;
    self.selectBtn.selected = YES;
    replacePG *pg = self.replaceArr[btn.tag];
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"11"] forState:UIControlStateNormal];
    }else{
        
        [btn setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
    }
//    if ([_delegate respondsToSelector:@selector(TiHuanControllerDidChick:replacePG:)]) {
//        [self.delegate TiHuanControllerDidChick:self replacePG:pg];
//    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KChangeCaiNotif object:nil];
    
//    [OrderViewController sharedOrderView].replaceTaoCanID = self.taocanID;
//    [OrderViewController sharedOrderView].replaceInfo = pg;

    if ([_delegate respondsToSelector:@selector(TiHuanControllerDidChick:replacePG:taocanID:)]) {
        [self.delegate TiHuanControllerDidChick:self replacePG:pg taocanID:self.taocanID];
    }
    
}


-(void) setButtonStateImage:(UIButton *) sender

{
    if (sender.selected==NO) {
        [sender setImage:[UIImage imageNamed:@"11"] forState: UIControlStateSelected];
        sender.selected=YES;
       NSString *str = self.arrJiKou[sender.tag -300];
        self.cdaId = [NSMutableString stringWithFormat:@"%@,%@",self.cdaId,str];
    } else {
        
        [sender setImage:[UIImage imageNamed:@"12"] forState:UIControlStateNormal];
        sender.selected=NO;
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[self.cdaId componentsSeparatedByString:@","]];
        NSMutableArray *arr1 = [NSMutableArray arrayWithArray:arr];
        for (NSString *str in arr) {
            if ([str isEqualToString:self.arrJiKou[sender.tag -300]]) {
                [arr1 removeObject:str];
            }
        }
       self.cdaId = [arr1 componentsJoinedByString:@","];
        

    }
   
    
    if ([self.delegate respondsToSelector:@selector(sendJiKou:)]) {
        [self.delegate sendJiKou:self.cdaId];
    }
    
    
}








/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)replaceArr{
    
    if (_replaceArr == nil) {
        _replaceArr = [NSMutableArray array];
    }
    return _replaceArr;
}

- (IBAction)clickBtn:(id)sender {
    [self setButtonStateImage:sender];
    
    
    
}
@end
