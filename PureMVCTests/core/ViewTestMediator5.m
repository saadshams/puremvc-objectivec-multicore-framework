//
//  ViewTestMediator5.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ViewTestMediator5.h"
#import "INotification.h"
#import "ViewTestNotification.h"
#import "ViewTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ViewTestMediator5

/**
The Mediator name
*/
+ (NSString *)NAME { return @"ViewTestMediator5"; }

- (NSArray<NSString *> *)listNotificationInterests {
    return @[NOTE5];
}

- (void)handleNotification:(id<INotification>)notification {
    ((ViewTestVO *)notification.body).counter++;
}

@end

NS_ASSUME_NONNULL_END
