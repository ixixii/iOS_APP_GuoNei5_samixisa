//
//  SAPrivacyViewController.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAPrivacyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *xib_sa_webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *xib_sa_indicator;
- (IBAction)closeTAButtonClicked;

@end

NS_ASSUME_NONNULL_END
