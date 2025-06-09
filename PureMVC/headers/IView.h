//
//  IView.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IView_h
#define IView_h

#import <Foundation/Foundation.h>
#import "IObserver.h"
#import "IMediator.h"

NS_ASSUME_NONNULL_BEGIN

/**
The interface definition for a PureMVC View.

In PureMVC, `IView` implementors assume these responsibilities:

In PureMVC, the `View` class assumes these responsibilities:

* Maintain a cache of `IMediator` instances.
* Provide methods for registering, retrieving, and removing `IMediators`.
* Managing the observer lists for each `INotification` in the application.
* Providing a method for attaching `IObservers` to an `INotification`'s observer list.
* Providing a method for broadcasting an `INotification`.
* Notifying the `IObservers` of a given `INotification` when it broadcast.

`@see org.puremvc.swift.multicore.interfaces.IMediator IMediator`

`@see org.puremvc.swift.multicore.interfaces.IObserver IObserver`

`@see org.puremvc.swift.multicore.interfaces.INotification INotification`
*/
@protocol IView

/**
Register an `IObserver` to be notified
of `INotifications` with a given name.

- parameter notificationName: the name of the `INotifications` to notify this `IObserver` of
- parameter observer: the `IObserver` to register
*/
- (void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer;

/**
Notify the `IObservers` for a particular `INotification`.

All previously attached `IObservers` for this `INotification`'s
list are notified and are passed a reference to the `INotification` in
the order in which they were registered.

- parameter notification: the `INotification` to notify `IObservers` of.
*/
- (void)notifyObservers:(id<INotification>)notification;

/**
Remove a group of observers from the observer list for a given Notification name.

- parameter notificationName: which observer list to remove from
- parameter notifyContext: removed the observers with this object as their notifyContext
*/
- (void)removeObserver:(NSString *)notificationName context:(id)context;

/**
Register an `IMediator` instance with the `View`.

Registers the `IMediator` so that it can be retrieved by name,
and further interrogates the `IMediator` for its
`INotification` interests.

If the `IMediator` returns any `INotification`
names to be notified about, an `Observer` is created encapsulating
the `IMediator` instance's `handleNotification` method
and registering it as an `Observer` for all `INotifications` the
`IMediator` is interested in.

- parameter mediator: a reference to the `IMediator` instance
*/
- (void)registerMediator:(id<IMediator>)mediator;

/**
Retrieve an `IMediator` from the `View`.

- parameter mediatorName: the name of the `IMediator` instance to retrieve.
- returns: the `IMediator` instance previously registered with the given `mediatorName`.
*/
- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName;

/**
Check if a Mediator is registered or not

- parameter mediatorName:
- returns: whether a Mediator is registered with the given `mediatorName`.
*/
- (BOOL)hasMediator:(NSString *)mediatorName;

/**
Remove an `IMediator` from the `View`.

- parameter mediatorName: name of the `IMediator` instance to be removed.
- returns: the `IMediator` that was removed from the `View`
*/
- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName;

@end

NS_ASSUME_NONNULL_END

#endif /* IView_h */
