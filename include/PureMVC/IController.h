//
//  IController.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IController_h
#define IController_h

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
The interface definition for a PureMVC Controller.

In PureMVC, an `IController` implementor
follows the 'Command and Controller' strategy, and
assumes these responsibilities:

* Remembering which `ICommand`s are intended to handle which `INotifications`.
* Registering itself as an `IObserver` with the `View` for each `INotification` that it has an `ICommand` mapping for.
* Creating a new instance of the proper `ICommand` to handle a given `INotification` when notified by the `View`.
* Calling the `ICommand`'s `execute` method, passing in the `INotification`.

`@see INotification`

`@see ICommand`
*/
@protocol IController

/**
Register a particular `ICommand` class as the handler
for a particular `INotification`.

- parameter notificationName: the name of the `INotification`
- parameter factory: reference that returns `ICommand`
*/
- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory;

/**
Execute the `ICommand` previously registered as the
handler for `INotification`s with the given notification name.

- parameter notification: the `INotification` to execute the associated `ICommand` for
*/
- (void)executeCommand:(id<INotification>)notification;

/**
Check if a Command is registered for a given Notification

- parameter notificationName:
- returns: whether a Command is currently registered for the given `notificationName`.
*/
- (BOOL)hasCommand:(NSString *)notificationName;

/**
Remove a previously registered `ICommand` to `INotification` mapping.

- parameter notificationName: the name of the `INotification` to remove the `ICommand` mapping for
*/
- (void)removeCommand:(NSString *)notificationName;

@end

NS_ASSUME_NONNULL_END

#endif /* IController_h */
