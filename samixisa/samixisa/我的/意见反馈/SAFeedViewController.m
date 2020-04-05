//
//  SAFeedViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAFeedViewController.h"

@interface SAFeedViewController ()

@end

@implementation SAFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"反馈意见";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (IBAction)sa_sendBtnClicked
{
    if(self.xib_sa_textView.text.length > 0 && ![self.xib_sa_textView.text isEqualToString:@"请输入你的意见或建议"]){
        [self.view endEditing:YES];
        [SAMessageTool showSAMessage:@"发送中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SAMessageTool showSAMessage:@"发送成功!"];
            __weak __typeof__(self) weakSelf = self;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.view endEditing:YES];
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        });
    }else{
        [SAMessageTool showSAMessage:@"请输入内容后再发送"];
    }
}

@end
