//
//  SAMineCell.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAMineCell.h"

@implementation SAMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)saMineCell
{
    NSArray *tmpArr = [[NSBundle mainBundle]loadNibNamed:@"SAMineCell" owner:nil options:nil];
    return tmpArr[0];
}
@end
