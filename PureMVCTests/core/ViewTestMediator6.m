//
//  ViewTestMediator6.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ViewTestMediator6.h"
#import "INotification.h"
#import "ViewTestNotification.h"
#import "ViewTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ViewTestMediator6

+ (NSString *)NAME { return @"ViewTestMediator6"; }

- (NSArray<NSString *> *)listNotificationInterests {
    return @[NOTE6];
}

- (void)handleNotification:(id<INotification>)notification {
    // super.facade removeMediator(super.name);
}

- (void)onRemove {
    ((ViewTestVO *)self.view).counter++;
}

@end

NS_ASSUME_NONNULL_END
