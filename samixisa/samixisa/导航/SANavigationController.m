//
//  SANavigationController.m
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import "SANavigationController.h"

@interface SANavigationController ()

@end

@implementation SANavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetSATabBarItemTextColor];
    [self resetSANavigationBarTitleFont];
}
- (void)resetSATabBarItemTextColor
{
    [self.navigationBar setBackgroundImage:[self sa_imageFromColor:sa_yellowColor] forBarMetrics:(UIBarMetricsDefault)];
    
    [self.xib_sa_tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObject:sa_yellowColor forKey:NSForegroundColorAttributeName] forState:UIControlStateSelected];
}
- (void)resetSANavigationBarTitleFont
{
    [self.navigationBar setTitleTextAttributes:
    @{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
      NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (UIImage *)sa_imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([NSStringFromClass([viewController class]) isEqualToString:@"SAMineViewController"] ) {
        viewController.hidesBottomBarWhenPushed = NO;
    }else{
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
@end
