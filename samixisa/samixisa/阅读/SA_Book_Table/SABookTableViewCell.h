//
//  SABookTableViewCell.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SABookTableViewCell : UITableViewCell

+ (instancetype)saTableViewCell;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_book;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_author;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_count;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_remark;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_date;
@property (nonatomic,weak) IBOutlet UILabel *xib_sa_label_family;
@property (nonatomic,weak) IBOutlet UIButton *xib_sa_btn_del;

@end

NS_ASSUME_NONNULL_END
