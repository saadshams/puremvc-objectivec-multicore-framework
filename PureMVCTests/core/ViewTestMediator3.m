//
//  ViewTestMediator3.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ViewTestMediator3.h"
#import "INotification.h"
#import "ViewTestNotification.h"
#import "ViewTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ViewTestMediator3

+ (NSString *)NAME { return @"ViewTestMediator3"; }

- (NSArray<NSString *> *)listNotificationInterests {
    return @[NOTE3];
}

- (void)handleNotification:(id<INotification>)notification {
    ((ViewTestVO *)notification.body).lastNotification = notification.name;
}

@end

NS_ASSUME_NONNULL_END
