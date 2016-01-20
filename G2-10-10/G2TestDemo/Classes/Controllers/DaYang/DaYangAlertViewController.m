//
//  DaYangAlertViewController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/17.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "DaYangAlertViewController.h"
#import "DaYangTable.h"
#import "DaYangTableCell.h"

//MenuViewController.m
@interface DaYangAlertViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *dayangView;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) NSMutableArray *collectArr;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (weak, nonatomic) IBOutlet UILabel *dayangLabel;
@property (weak, nonatomic) IBOutlet UILabel *tishi;
@property (weak, nonatomic) IBOutlet UIButton *cha;

@end

@implementation DaYangAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.cornerRadius=0;
    
//    [_collectView.layer setMasksToBounds:YES];
//    [_collectView.layer setBorderColor:[[UIColor grayColor]CGColor]];
    [_collectView.layer setCornerRadius:10.0];
    // Do any additional setup after loading the view from its nib.
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.okButton.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
//    self.dayangLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
//    self.tishi.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1];
    
    [self.okButton addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    [self.cha addTarget:self action:@selector(chahao) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)queding{
    
    if ([_delegate  respondsToSelector:@selector(DaYangAlertViewControllerDidChickQuDing:)]) {
        [self.delegate DaYangAlertViewControllerDidChickQuDing:self];
    }
}


-(void)chahao{
    
    if ([_delegate  respondsToSelector:@selector(dayangquxiao:)]) {
        [self.delegate dayangquxiao:self];
    }
//    [self.view removeFromSuperview];
    
}

- (void)setArr:(NSArray *)arr{
    
    _arr = arr;
    self.collectArr = (NSMutableArray *)arr;
    [self.collectView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - collectionView的代理和数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.collectArr.count;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    UINib *nib = [UINib nibWithNibName:@"DaYangTableCell" bundle:nil];
    
    [collectionView registerNib:nib forCellWithReuseIdentifier:ID];
    
    DaYangTableCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    NSLog(@"%@",self.collectArr);
    DaYangTable *dayangTable = self.collectArr[indexPath.row];
    cell.tableName = dayangTable.tabNo;
    
    return cell;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSMutableArray *)collectArr{
    
    if (_collectArr == nil) {
        _collectArr = [NSMutableArray array];
    }
    return _collectArr;
}

@end
