//
//  SAAddFamilyViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAAddFamilyViewController.h"

@implementation SAAddFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加家人";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)addSAFamilyBtnClicked
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:YES];
        return;
    }
    
    if(_xib_sa_textField_relation.text.length == 0){
        [SAMessageTool showSAMessage:@"请输入家人关系"];
        return;
    }
    if(_xib_sa_textField_description.text.length == 0){
        [SAMessageTool showSAMessage:@"请输入家人描述"];
        return;
    }
    if(_xib_sa_textField_writer.text.length == 0){
        [SAMessageTool showSAMessage:@"请输入喜欢作者"];
        return;
    }
    if(_xib_sa_textField_interest.text.length == 0){
        [SAMessageTool showSAMessage:@"请输入阅读热点"];
        return;
    }
    NSArray *saFamilyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_familyArr"];
    NSDictionary *newSAFamily = @{
        @"sa_relation": _xib_sa_textField_relation.text,
        @"sa_description": _xib_sa_textField_description.text,
        @"sa_writer": _xib_sa_textField_writer.text,
        @"sa_interest": _xib_sa_textField_interest.text,
        
    };
    NSMutableArray *mSAArr = [NSMutableArray arrayWithArray:saFamilyArr];
    [mSAArr addObject:newSAFamily];
    [[NSUserDefaults standardUserDefaults] setObject:mSAArr forKey:@"userDefault_sa_familyArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view endEditing:YES];
    [SAMessageTool showSAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SAMessageTool showSAMessage:@"添加成功" duration:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}
@end
