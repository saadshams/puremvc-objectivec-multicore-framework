//
//  SimpleCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef SimpleCommand_h
#define SimpleCommand_h

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "Notifier.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base `ICommand` implementation.

 `SimpleCommand` defines a basic behavior for handling `INotification`s via the Command Pattern.

 In PureMVC, `SimpleCommand` instances are typically created by the `Controller` in response
 to a specific `INotification`. Your subclass should override the `execute:` method
 to implement the application's specific business logic.

 @see ICommand
 @see Notification
 @see MacroCommand
 */
@interface SimpleCommand : Notifier <ICommand>

/// Factory method to return a new instance of `SimpleCommand`.
+(instancetype)command;

/**
 Fulfill the use-case initiated by the given `INotification`.

 Override this method in your subclass to handle application-specific logic.

 @param notification The `INotification` to handle.
 */
- (void)execute:(id<INotification>)notification;

@end

NS_ASSUME_NONNULL_END

#endif /* SimpleCommand_h */
