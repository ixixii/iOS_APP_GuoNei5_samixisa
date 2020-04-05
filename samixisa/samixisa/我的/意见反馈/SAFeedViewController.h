//
//  SAFeedViewController.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAFeedViewController : UIViewController
@property (nonatomic,weak) IBOutlet UITextView *xib_sa_textView;
- (IBAction)sa_sendBtnClicked;
@end

NS_ASSUME_NONNULL_END
