//
//  EntPersonInfoViewController.h
//  GITestDemo
//
//  Created by 吴狄 on 15/6/8.
//  Copyright (c) 2015年 Kyson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
@interface EntPersonInfoViewController : RootViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *password; //登录密码  tag:1
@property (strong, nonatomic) IBOutlet UITextField *rePassword; //确认密码   tag:2
@property (strong, nonatomic) IBOutlet UITextField *name; //姓名   tag:3
@property (strong, nonatomic) IBOutlet UITextField *ID; //身份证  tag:4
@property (strong, nonatomic) IBOutlet UITextField *certExpdate; //身份证有效期   tag:5
@property (strong, nonatomic) IBOutlet UIButton *IDPhotoFront; //身份证正面
@property (strong, nonatomic) IBOutlet UIButton *IDPhotoBack;  //身份证背面
@property (strong, nonatomic) IBOutlet UIButton *IDPhotoAndPerson; //法人手持正面
@property (strong, nonatomic) IBOutlet UIButton *KaiHuXuKeZheng; //开户许可证
@property (strong, nonatomic) IBOutlet UIButton *XianChangZhaoPian; //现场照片

@property (strong,nonatomic) UIActionSheet *actionSheet;

@property (strong,nonatomic) NSString *imagePath1; //身份证正面路径
@property (strong,nonatomic) NSString *imagePath2; //身份证背面路径
@property (strong,nonatomic) NSString *imagePath3; //法人手持正面路径
@property (strong,nonatomic) NSString *imagePath5; //开户许可证路径
@property (strong,nonatomic) NSString *imagePath10; //现场照片路径
@end
