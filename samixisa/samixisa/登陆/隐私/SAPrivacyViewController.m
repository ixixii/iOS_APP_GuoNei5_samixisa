//
//  SAPrivacyViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAPrivacyViewController.h"

@interface SAPrivacyViewController ()<UIWebViewDelegate>

@end

@implementation SAPrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.xib_sa_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://shimo.im/docs/wydhJRyPXKCj9kXt"] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.2]];
    self.xib_sa_webView.delegate = self;
    [self.xib_sa_indicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.xib_sa_indicator removeFromSuperview];
}
- (IBAction)closeTAButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
