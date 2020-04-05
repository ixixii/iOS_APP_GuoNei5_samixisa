//
//  SAMineHeadView.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAMineHeadView.h"

@implementation SAMineHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)saMineHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"SAMineHeadView" owner:nil options:nil][0];
}
@end
