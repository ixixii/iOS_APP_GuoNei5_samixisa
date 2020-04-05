//
//  SALoginViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SALoginViewController.h"

@interface SALoginViewController ()

@end

@implementation SALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)regitsterSAButtonClicked
{
    [self presentViewController:[[NSClassFromString(@"SARegisterViewController") alloc]init] animated:YES completion:^{
    }];
}
- (void)loginSAButtonClicked
{
    [self.view endEditing:YES];
    if(_xib_sa_textField_telephone.text.length == 0){
        [SAMessageTool showSAMessage:@"请输入手机号码"];
        return;
    }
    if(_xib_sa_textField_pwd.text.length == 0){
        [SAMessageTool showSAMessage:@"请输入登陆密码"];
        return;
    }
    if([_xib_sa_textField_telephone.text isEqualToString:@"leon"] && [_xib_sa_textField_pwd.text isEqualToString:@"123456"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"leon" forKey:@"userDefault_sa_telephone"];
        [[NSUserDefaults standardUserDefaults] setObject:@"123456" forKey:@"userDefault_sa_pwd"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if(![_xib_sa_textField_telephone.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_telephone"]] || ![_xib_sa_textField_pwd.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_pwd"]]){
        [SAMessageTool showSAMessage:@"手机号码或者登录密码不正确"];
        return;
    }
    [SAMessageTool showSAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SAMessageTool showSAMessage:@"登录成功！" duration:3];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userDefault_sa_isLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
            
//            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    });
}
- (IBAction)visitSAButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
