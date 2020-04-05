//
//  SAMessageTool.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SAMessageTool.h"

#define sa_ScreenBounds [UIScreen mainScreen].bounds
#define sa_ScreenWidth sa_ScreenBounds.size.width
#define sa_ScreenHeight sa_ScreenBounds.size.height

typedef NS_ENUM(NSInteger, SAMessagePositionY){
  SAMessagePositionY_top = 0,
  SAMessagePositionY_center,
  SAMessagePositionY_bottom
};

@implementation SAMessageTool

+(void)showSAMessage:(NSString *)message
{
    [SAMessageTool showSAMessage:message duration:3];
}
+(void)showSAMessage:(NSString *)message duration:(NSInteger)duration
{
    [SAMessageTool showSAMessage:message duration:duration positionY:SAMessagePositionY_center];
}
+(void)showSAMessage:(NSString *)message duration:(NSInteger)duration positionY:(NSInteger)positionY
{
    UIView *saShowView =  [[UIView alloc]init];
    saShowView.backgroundColor = [UIColor blackColor];
    saShowView.alpha = 1.0f;
    saShowView.layer.cornerRadius = 5.0f;
    saShowView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:saShowView];
    
    UILabel *saLabel = [[UILabel alloc]init];
    CGSize saLabelSize = [message sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:CGSizeMake(sa_ScreenWidth, 9999)];
    saLabel.frame = CGRectMake(10, 5, saLabelSize.width, saLabelSize.height);
    saLabel.text = message;
    saLabel.numberOfLines = 0;
    saLabel.textColor = [UIColor whiteColor];
    saLabel.textAlignment = 1;
    saLabel.backgroundColor = [UIColor clearColor];
    saLabel.font = [UIFont boldSystemFontOfSize:20];
    [saShowView addSubview:saLabel];
    NSInteger messageY = 0;
    switch (positionY) {
        case SAMessagePositionY_top:
            {
                messageY = 100;
            }
            break;
        case SAMessagePositionY_center:
            {
                messageY = sa_ScreenHeight/2 - saLabelSize.height/2;
            }
            break;
        case SAMessagePositionY_bottom:
            {
                messageY = sa_ScreenHeight - 100;
            }
            break;
        default:
            break;
    }
    saShowView.frame = CGRectMake((sa_ScreenWidth - saLabelSize.width - 20)/2, messageY, saLabelSize.width+20, saLabelSize.height+10);
    [UIView animateWithDuration:duration animations:^{
        saShowView.alpha = 0;
    } completion:^(BOOL finished) {
        [saShowView removeFromSuperview];
    }];
}

@end
