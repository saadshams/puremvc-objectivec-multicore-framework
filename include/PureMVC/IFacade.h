//
//  IFacade.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IFacade_h
#define IFacade_h

#import <Foundation/Foundation.h>
#import "INotifier.h"
#import "ICommand.h"
#import "IProxy.h"
#import "IMediator.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
The interface definition for a PureMVC Facade.

The Facade Pattern suggests providing a single
class to act as a central point of communication
for a subsystem.

In PureMVC, the Facade acts as an interface between
the core MVC actors (Model, View, Controller) and
the rest of your application.

`@see IModel`

`@see IView`

`@see IController`

`@see ICommand`

`@see INotification`
*/
@protocol IFacade

/**
Register an `ICommand` with the `Controller`.

- parameter notificationName: the name of the `INotification` to associate the `ICommand` with.
- parameter factory: closure that returns `ICommand`
*/
- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory;

/**
Check if a Command is registered for a given Notification

- parameter notificationName:
- returns: whether a Command is currently registered for the given `notificationName`.
*/
- (BOOL)hasCommand:(NSString *)notificationName;

/**
Remove a previously registered `ICommand` to `INotification` mapping from the Controller.

- parameter notificationName: the name of the `INotification` to remove the `ICommand` mapping for
*/
- (void)removeCommand:(NSString *)notificationName;

/**
Register an `IProxy` with the `Model` by name.

- parameter proxy: the `IProxy` to be registered with the `Model`.
*/
- (void)registerProxy:(id<IProxy>)proxy;

/**
Retrieve a `IProxy` from the `Model` by name.

- parameter proxyName: the name of the `IProxy` instance to be retrieved.
- returns: the `IProxy` previously regisetered by `proxyName` with the `Model`.
*/
- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName;

/**
Check if a Proxy is registered

- parameter proxyName:
- returns: whether a Proxy is currently registered with the given `proxyName`.
*/
- (BOOL)hasProxy:(NSString *)proxyName;

/**
Remove an `IProxy` instance from the `Model` by name.

- parameter proxyName: the `IProxy` to remove from the `Model`.
- returns: the `IProxy` that was removed from the `Model`
*/
- (nullable id<IProxy>)removeProxy:(NSString *)proxyName;

/**
Register an `IMediator` instance with the `View`.

- parameter mediator: a reference to the `IMediator` instance
*/
- (void)registerMediator:(id<IMediator>)mediator;

/**
Retrieve an `IMediator` instance from the `View`.

- parameter mediatorName: the name of the `IMediator` instance to retrievve
- returns: the `IMediator` previously registered with the given `mediatorName`.
*/
- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName;

/**
Check if a Mediator is registered or not

- parameter mediatorName:
- returns: whether a Mediator is registered with the given `mediatorName`.
*/
- (BOOL)hasMediator:(NSString *)mediatorName;

/**
Remove a `IMediator` instance from the `View`.

- parameter mediatorName: name of the `IMediator` instance to be removed.
- returns: the `IMediator` instance previously registered with the given `mediatorName`.
*/
- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName;

/**
Notify `Observer`s.

This method is left public mostly for backward
compatibility, and to allow you to send custom
notification classes using the facade.

Usually you should just call sendNotification
and pass the parameters, never having to
construct the notification yourself.

- parameter notification: the `INotification` to have the `View` notify `Observers` of.
*/
- (void)notifyObservers:(id<INotification>)notification;

/**
Send a `INotification`.

Convenience method to prevent having to construct new
notification instances in our implementation code.

- parameter notificationName: the name of the notification to send
- parameter body: the body of the notification
- parameter type: the type of the notification
*/
- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type;

/**
 * Send a notification with just a name.
 *
 * @param notificationName The name of the notification to send.
 */
- (void)sendNotification:(NSString *)notificationName;

/**
 * Send a notification with a name and body.
 *
 * @param notificationName The name of the notification to send.
 * @param body The body of the notification.
 */
- (void)sendNotification:(NSString *)notificationName body:(id)body;

/**
 * Send a notification with a name and type.
 *
 * @param notificationName The name of the notification to send.
 * @param type The type of the notification.
 */
- (void)sendNotification:(NSString *)notificationName type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END

#endif /* IFacade_h */
