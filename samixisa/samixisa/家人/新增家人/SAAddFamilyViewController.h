//
//  SAAddFamilyViewController.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAAddFamilyViewController : UIViewController

@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_relation;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_description;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_writer;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_interest;

- (IBAction)addSAFamilyBtnClicked;


@end

NS_ASSUME_NONNULL_END
