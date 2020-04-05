//
//  SAFamilyHeadView.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAFamilyHeadView.h"

@implementation SAFamilyHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)saFamilyHeadView
{
    return [[NSBundle mainBundle]loadNibNamed:@"SAFamilyHeadView" owner:nil options:nil][0];
}

@end
