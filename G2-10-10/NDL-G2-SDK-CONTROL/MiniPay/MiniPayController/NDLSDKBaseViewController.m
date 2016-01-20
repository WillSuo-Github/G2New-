//
//  NDLSDKBaseViewController.m
//  G2TestDemo
//
//  Created by NDlan on 17/12/15.
//  Copyright © 2015年 ws. All rights reserved.
//

#import "NDLSDKBaseViewController.h"
#import "BluetoothConnectionViewController.h"
#import "Common.h"
#import "NDLBusinessConfigure.h"
@interface NDLSDKBaseViewController ()

@end

@implementation NDLSDKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)presentBluetoothConnectionVC{
    
    NSLog(@"presentBluetoothConnectionVC---%@",NSStringFromClass([self class]));
    
    if (MiniPosSDKDeviceState() < 0) {
        
        BluetoothConnectionViewController *bcVC = [[BluetoothConnectionViewController alloc]init];
        UINavigationController *nc = [[UINavigationController alloc]initWithRootViewController:bcVC];
        nc.modalPresentationStyle = UIModalPresentationFormSheet;
        [kKeyWindow.rootViewController presentViewController:nc animated:YES completion:^{
            self._nc = nc;
        }];
    }
    
}

-(void)dismissBluetoothConnectionVC{
    
    NSLog(@"dismissBluetoothConnectionVC---%@",NSStringFromClass([self class]));
    
    if (self._nc) {
        [self._nc dismissViewControllerAnimated:YES completion:nil];
    }
    
}



@end
