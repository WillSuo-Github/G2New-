//
//  LoginViewController.h
//  GITestDemo
//
//  Created by Femto03 on 14/11/25.
//  Copyright (c) 2014年 Kyson. All rights reserved.
//

#import "G1BaseViewController.h"
#import "QCheckBox.h"
@interface LoginViewController : G1BaseViewController


@property (strong, nonatomic) IBOutlet UITextField *phoneNo;
@property (strong, nonatomic) IBOutlet UITextField *password;


@property (strong, nonatomic) IBOutlet UIButton *siginButton;


@property (strong, nonatomic) IBOutlet UIButton *connectDeviceButton;
@property (strong, nonatomic) IBOutlet UIView *protocolView;

- (IBAction)connectDeviceAction:(UIButton *)sender;



- (IBAction)siginAction:(UIButton *)sender;


@end
