//
//  SARegisterViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SARegisterViewController.h"

@interface SARegisterViewController ()

@end

@implementation SARegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)loginSAButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)privacySAButtonClicked
{
    UIViewController *ctrl = [[NSClassFromString(@"SAPrivacyViewController") alloc] init];
    [self presentViewController:ctrl animated:YES completion:nil];
}
- (void)registerSAButtonClicked
{
    if(_xib_sa_textField_telephone.text.length == 0){
        [SAMessageTool showSAMessage:@"手机号码不能为空"];
        return;
    }
    if(_xib_sa_textField_pwd.text.length == 0){
        [SAMessageTool showSAMessage:@"注册密码不能为空"];
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:_xib_sa_textField_telephone.text forKey:@"userDefault_sa_telephone"];
    [[NSUserDefaults standardUserDefaults] setObject:_xib_sa_textField_pwd.text forKey:@"userDefault_sa_pwd"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [SAMessageTool showSAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SAMessageTool showSAMessage:@"注册成功，请前往登录" duration:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}
@end
