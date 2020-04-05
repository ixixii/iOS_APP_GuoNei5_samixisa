//
//  SALoginViewController.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SALoginViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_telephone;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_pwd;

- (IBAction)regitsterSAButtonClicked;
- (IBAction)loginSAButtonClicked;

- (IBAction)visitSAButtonClicked;
@end

NS_ASSUME_NONNULL_END
