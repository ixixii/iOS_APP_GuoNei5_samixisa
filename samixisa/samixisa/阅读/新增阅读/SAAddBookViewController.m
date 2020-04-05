//
//  SAAddBookViewController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAAddBookViewController.h"

@interface SAAddBookViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *_sa_familyArr;
}

@end

@implementation SAAddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加阅读";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    _sa_familyArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_familyArr"];
    
    if(_model){
        self.title = @"阅读详情";
        _xib_sa_textField_book.text = _model[@"sa_book"];
        _xib_sa_textField_author.text = _model[@"sa_author"];
        _xib_sa_textField_count.text = _model[@"sa_count"];
        _xib_sa_textField_remark.text = _model[@"sa_remark"];
        _xib_sa_textField_date.text = _model[@"sa_date"];
        _xib_sa_textField_family.text = _model[@"sa_family"];
        
        _xib_sa_button_add.hidden = YES;
        _xib_sa_button_family.userInteractionEnabled = NO;
        _xib_sa_imageView_arrow.hidden = YES;
        
        _xib_sa_textField_book.userInteractionEnabled = NO;
        _xib_sa_textField_author.userInteractionEnabled = NO;
        _xib_sa_textField_count.userInteractionEnabled = NO;
        _xib_sa_textField_remark.userInteractionEnabled = NO;
        _xib_sa_textField_date.userInteractionEnabled = NO;
    }
}

#pragma mark - 按钮事件
- (void)btnSAFamilyClicked:(UIButton *)sender
{
    [self.view endEditing:YES];
    _xib_sa_pickerView.hidden = NO;
    _xib_sa_button_mask.hidden = NO;
    _xib_sa_btn_pickConfirm.hidden = NO;
    _xib_sa_toolbar.hidden = NO;
}
#pragma mark - pickerView
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _sa_familyArr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_sa_familyArr[row] objectForKey:@"sa_relation"];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView setHidden:YES];
    _xib_sa_button_mask.hidden = YES;
    _xib_sa_textField_family.text = [_sa_familyArr[row] objectForKey:@"sa_relation"];
    
    _xib_sa_btn_pickConfirm.hidden = YES;
    _xib_sa_toolbar.hidden = YES;
}
- (void)saButtonMaskClicked:(UIButton *)sender
{
    sender.hidden = YES;
    _xib_sa_pickerView.hidden = YES;
    _xib_sa_btn_pickConfirm.hidden = YES;
    _xib_sa_toolbar.hidden = YES;
}
- (IBAction)saPickConfirmBtnClicked:(UIButton *)sender
{
    NSInteger row = [_xib_sa_pickerView selectedRowInComponent:0];
    _xib_sa_textField_family.text = [_sa_familyArr[row] objectForKey:@"sa_relation"];
    
    _xib_sa_button_mask.hidden = YES;
    _xib_sa_pickerView.hidden = YES;
    _xib_sa_btn_pickConfirm.hidden = YES;
    _xib_sa_toolbar.hidden = YES;
}
#pragma mark - btn 事件
- (void)addSABtnClicked:(UIButton *)sender
{
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"userDefault_sa_isLogin"]){
        [self.navigationController pushViewController:[[NSClassFromString(@"SALoginViewController") alloc] init] animated:YES];
        return;
    }
    
    if(_xib_sa_textField_book.text.length == 0){
        [SAMessageTool showSAMessage:@"书名不能为空"];
        return;
    }
    if(_xib_sa_textField_author.text.length == 0){
        [SAMessageTool showSAMessage:@"作者不能为空"];
        return;
    }
    if(_xib_sa_textField_count.text.length == 0){
        [SAMessageTool showSAMessage:@"字数不能为空"];
        return;
    }
    if(_xib_sa_textField_remark.text.length == 0){
        [SAMessageTool showSAMessage:@"心得不能为空"];
        return;
    }
    if(_xib_sa_textField_date.text.length == 0){
        [SAMessageTool showSAMessage:@"阅读时间不能为空"];
        return;
    }
    if(_xib_sa_textField_family.text.length == 0){
        [SAMessageTool showSAMessage:@"所属家人不能为空"];
        return;
    }
    
    NSString *tmpRemarker = _xib_sa_textField_remark.text;
    if(_xib_sa_textField_remark.text.length == 0){
        tmpRemarker = @"---";
    }
    NSArray *accountArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"userDefault_sa_bookArr"];
    NSDictionary *newTAAccount = @{
        @"sa_book": _xib_sa_textField_book.text,
        @"sa_author": _xib_sa_textField_author.text,
        @"sa_count": _xib_sa_textField_count.text,
        @"sa_remark": tmpRemarker,
        @"sa_date": _xib_sa_textField_date.text,
        @"sa_family": _xib_sa_textField_family.text
    };
    NSMutableArray *mTAArr = [NSMutableArray arrayWithArray:accountArr];
    [mTAArr addObject:newTAAccount];
    [[NSUserDefaults standardUserDefaults] setObject:mTAArr forKey:@"userDefault_sa_bookArr"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.view endEditing:YES];
    [SAMessageTool showSAMessage:@"发送中..." duration:3];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SAMessageTool showSAMessage:@"添加阅读成功" duration:3];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    });
}

@end
