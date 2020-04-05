//
//  SAMessageTool.h
//  samixisa
//
//  Created by beyond on 2020/04/04.
//  Copyright © 2020 samixisa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAMessageTool : NSObject
+(void)showSAMessage:(NSString *)message;
+(void)showSAMessage:(NSString *)message duration:(NSInteger)duration;
+(void)showSAMessage:(NSString *)message duration:(NSInteger)duration positionY:(NSInteger)positionY;
@end

NS_ASSUME_NONNULL_END
