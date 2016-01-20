//
//  ChangeStatusController.m
//  G2TestDemo
//
//  Created by lcc on 15/8/6.
//  Copyright (c) 2015年 ws. All rights reserved.
//

#import "ChangeStatusController.h"

@interface ChangeStatusController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIButton *tingyong;

@property (weak, nonatomic) IBOutlet UIButton *guashi;
@property (weak, nonatomic) IBOutlet UIButton *tuika;
@end

@implementation ChangeStatusController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tingyong.layer.cornerRadius = 5;
    self.tingyong.layer.masksToBounds= YES;
    
    [self.tingyong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.guashi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.tuika setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.guashi.layer.cornerRadius = 5;
    self.guashi.layer.masksToBounds= YES;
    
    
    self.tuika.layer.cornerRadius = 5;
    self.tuika.layer.masksToBounds= YES;
    
    
    [self tuika];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)tingyong:(id)sender {
    NSLog(@"停用");
    self.image.image = [UIImage imageNamed:@"hlk_ty"];
    
    [self.tingyong setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.guashi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tuika setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    self.tingyong.backgroundColor=[UIColor  colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    
    self.guashi.backgroundColor=[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];
    self.tuika.backgroundColor=[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];
    
    

    
    }
- (IBAction)guashi:(id)sender {
    NSLog(@"挂失");
    self.image.image = [UIImage imageNamed:@"hlk_gs"];
    
    [self.guashi setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.tingyong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tuika setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    self.guashi.backgroundColor=[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.tingyong.backgroundColor=[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];
    self.tuika.backgroundColor=[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];

}
- (IBAction)tuika:(id)sender {
    NSLog(@"退卡");
    self.image.image = [UIImage imageNamed:@"hlk_zc"];
    
    [self.tuika setTitleColor:[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.tingyong setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.guashi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    

    
    
    self.tuika.backgroundColor=[UIColor  colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.tingyong.backgroundColor=[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];
    self.guashi.backgroundColor=[UIColor colorWithRed:75/255.0 green:138/255.0 blue:221/255.0 alpha:1];
   
}

//- (IBAction)quxiao:(id)sender {
//    
//    UIAlertView *alertView1 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定取消？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alertView1.tag = 1;
//    [alertView1 show];
//    
//    }
//
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            NSLog(@"取消");
            if ([self.delegate respondsToSelector:@selector(ChangeStatusQuxiaoBtnChick)]) {
                [self.delegate ChangeStatusQuxiaoBtnChick];
            }

        }else if (buttonIndex == 1){
        
        }
    }else if (alertView.tag == 2){
        if (buttonIndex == 0) {
            NSLog(@"确定");
        }else if (buttonIndex == 1) {
            NSLog(@"取消");
        }
    }
}


//- (IBAction)queding:(id)sender {
//    NSLog(@"确定");
//    UIAlertView *alertView2 = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定选择？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//    alertView2.tag = 2;
//    [alertView2 show];
//}




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
