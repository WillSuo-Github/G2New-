//
//  PromptSavingNoteViewController.m
//  G2TestDemo
//
//  Created by 吴狄 on 15/12/2.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "PromptSavingNoteViewController.h"

@interface PromptSavingNoteViewController ()

@end

@implementation PromptSavingNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(back) withObject:nil afterDelay:5.0];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
