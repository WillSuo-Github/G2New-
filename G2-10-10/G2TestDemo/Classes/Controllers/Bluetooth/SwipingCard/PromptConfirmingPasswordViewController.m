//
//  PromptConfirmingPasswordViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptConfirmingPasswordViewController.h"

@interface PromptConfirmingPasswordViewController ()
@property (nonatomic,strong) NSString *amount; //消费金额
@end

@implementation PromptConfirmingPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)recvMiniPosSDKStatus{
    [super recvMiniPosSDKStatus];
    
    if ([self.statusStr isEqualToString:@"获取密码"]) {
        
        //[self performSegueWithIdentifier:@"next" sender:self];
        
    }
    if ([self.statusStr isEqualToString:@"消费下一步"]) {
        
        [self performSegueWithIdentifier:@"next" sender:self];
        
    }
    
    
    if ([self.statusStr isEqualToString:@"取消刷卡交易"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    self.statusStr  =@"";
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
