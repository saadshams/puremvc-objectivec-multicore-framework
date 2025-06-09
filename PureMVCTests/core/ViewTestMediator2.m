//
//  ViewTestMediator2.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ViewTestMediator2.h"
#import "INotification.h"
#import "ViewTestNotification.h"
#import "ViewTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ViewTestMediator2

/**
The Mediator name
*/
+ (NSString *)NAME { return @"ViewTestMediator2"; }

- (NSArray<NSString *> *)listNotificationInterests {
    // Be sure that the mediator has some Observers created
    // in order to test removeMediator
    return @[NOTE1, NOTE2];
}

- (void)handleNotification:(id<INotification>)notification {
    ((ViewTestVO *)notification.body).lastNotification = notification.name;
}

@end

NS_ASSUME_NONNULL_END
