//
//  SimpleCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "SimpleCommand.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
A base `ICommand` implementation.

Your subclass should override the `execute`
method where your business logic will handle the `INotification`.

`@see org.puremvc.swift.multicore.core.Controller Controller`

`@see org.puremvc.swift.multicore.patterns.observer.Notification Notification`

`@see org.puremvc.swift.multicore.patterns.command.MacroCommand MacroCommand`
*/
@implementation SimpleCommand

+ (instancetype)command {
    return [[self alloc] init];
}

/**
Fulfill the use-case initiated by the given `INotification`.

In the Command Pattern, an application use-case typically
begins with some user action, which results in an `INotification` being broadcast, which
is handled by business logic in the `execute` method of an
`ICommand`.

- parameter notification: the `INotification` to handle.
*/
- (void)execute:(id<INotification>)notification {
    
}

@end

NS_ASSUME_NONNULL_END
