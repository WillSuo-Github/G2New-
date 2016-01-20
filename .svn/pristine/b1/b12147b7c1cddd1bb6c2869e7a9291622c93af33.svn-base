//
//  ViewController.m
//  test
//
//  Created by wd on 15/12/22.
//  Copyright © 2015年 wd. All rights reserved.
//

#import "TestViewController.h"
#import "NDlMPosCoreSDK.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //[self initBLESDK];
    
    [NDlMPosCoreSDK shardNDlMPosManager];
    
    [[NDlMPosCoreSDK shardNDlMPosCoreSDK] initMiniPosSDKAddDelegate];
    
}

-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
}



- (IBAction)loginAction:(id)sender {
    
    if ([[ NDlMPosCoreSDK shardNDlMPosCoreSDK] deviceIsConnected]) {
        
        [[NDlMPosCoreSDK shardNDlMPosCoreSDK] initMiniPosSDKAddDelegate];
        
        [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
    
            NSLog(@"签到成功-------1");
            //MiniPosSDKSetCurrentSessionType(SESSION_POS_UNKNOWN);
            [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                //MiniPosSDKSetCurrentSessionType(SESSION_POS_UNKNOWN);
                NSLog(@"签到成功-------2");
                [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                    //MiniPosSDKSetCurrentSessionType(SESSION_POS_UNKNOWN);
                    NSLog(@"签到成功-------3");
                    [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                        NSLog(@"签到成功-------4");
                        [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                            NSLog(@"签到成功-------5");
                            [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                                NSLog(@"签到成功-------6");
                                [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                                    NSLog(@"签到成功-------7");
                                    [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                                        NSLog(@"签到成功-------8");
                                        [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                                            NSLog(@"签到成功-------9");
                                            [[NDlMPosCoreSDK shardNDlMPosCoreSDK] signInMPosSuceess:^{
                                                NSLog(@"签到成功-------10");
                                                
                                                
                                            } Fail:^(SessionCodeResult *result) {
                                                
                                                NSLog(@"签到失败");
                                            }];
                                            
                                            
                                        } Fail:^(SessionCodeResult *result) {
                                            
                                            NSLog(@"签到失败");
                                        }];
                                        
                                        
                                    } Fail:^(SessionCodeResult *result) {
                                        
                                        NSLog(@"签到失败");
                                    }];
                                    
                                } Fail:^(SessionCodeResult *result) {
                                    
                                    NSLog(@"签到失败");
                                }];
                                
                            } Fail:^(SessionCodeResult *result) {
                                
                                NSLog(@"签到失败");
                            }];
                            
                        } Fail:^(SessionCodeResult *result) {
                            
                            NSLog(@"签到失败");
                        }];
                        
                    } Fail:^(SessionCodeResult *result) {
                        
                        NSLog(@"签到失败");
                    }];
                    
                } Fail:^(SessionCodeResult *result) {
                    
                    NSLog(@"签到失败");
                }];
                
            } Fail:^(SessionCodeResult *result) {
                
                NSLog(@"签到失败");
            }];
//
            
            
        } Fail:^(SessionCodeResult *result) {
            
            NSLog(@"签到失败");
        }];
        
    }else{
        [self presentBluetoothConnectionVC];
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
