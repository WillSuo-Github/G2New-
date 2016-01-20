//
//  HelpDocumentViewController.m
//  G2TestDemo
//
//  Created by ws on 15/12/14.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "HelpDocumentViewController.h"
#import "NDLBusinessConfigure.h"

@interface HelpDocumentViewController ()<UIWebViewDelegate>
@property (strong,nonatomic)UIScrollView *backgroundView;

@end

@implementation HelpDocumentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUIAutoLayout];
    
}

-(void)setUIAutoLayout
{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
    webView.delegate = self;
    NSString *str= [NSString stringWithFormat:@"%@/help/index.html",ceshiIP];
    NSLog(@"help document URL:%@",str);
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:webView];
    
    
    
    
    
    
    
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
