//
//  SAAddBookViewController.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAAddBookViewController : UIViewController


@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_book;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_author;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_count;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_remark;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_date;
@property (nonatomic,weak) IBOutlet UITextField *xib_sa_textField_family;

- (IBAction)btnSAFamilyClicked:(UIButton *)sender;
- (IBAction)addSABtnClicked:(UIButton *)sender;

@property (nonatomic,strong) NSDictionary *model;

@property (nonatomic,weak) IBOutlet UIButton *xib_sa_button_add;
@property (nonatomic,weak) IBOutlet UIButton *xib_sa_button_family;
@property (nonatomic,weak) IBOutlet UIImageView *xib_sa_imageView_arrow;

@property (nonatomic,weak) IBOutlet UIButton *xib_sa_button_mask;
@property (nonatomic,weak) IBOutlet UIPickerView *xib_sa_pickerView;
- (IBAction)saButtonMaskClicked:(UIButton *)sender;

@property (nonatomic,weak) IBOutlet UILabel *xib_sa_toolbar;
@property (nonatomic,weak) IBOutlet UIButton *xib_sa_btn_pickConfirm;

- (IBAction)saPickConfirmBtnClicked:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
