//
//  SAFamilyTableViewCell.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAFamilyTableViewCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_relation;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_description;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_writer;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_interest;

@property (nonatomic,weak) IBOutlet UIButton *xib_sa_button_delete;

+ (instancetype)saFamilyTableViewCell;

@end

NS_ASSUME_NONNULL_END
