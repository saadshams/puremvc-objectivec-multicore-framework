//
//  INotifier.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef INotifier_h
#define INotifier_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
The interface definition for a PureMVC Notifier.

`MacroCommand, Command, Mediator` and `Proxy`
all have a need to send `Notifications`.

The `INotifier` interface provides a common method called
`sendNotification` that relieves implementation code of
the necessity to actually construct `Notifications`.

The `Notifier` class, which all of the above mentioned classes
extend, also provides an initialized reference to the `Facade`
Singleton, which is required for the convienience method
for sending `Notifications`, but also eases implementation as these
classes have frequent `Facade` interactions and usually require
access to the facade anyway.

`@see IFacade`

`@see INotification`
*/
@protocol IFacade; // forward ref

@protocol INotifier

/**
Initialize this INotifier instance.

This is how a Notifier gets its multitonKey.
Calls to sendNotification or to access the
facade will fail until after this method
has been called.

- parameter key: the multitonKey for this INotifier to use
*/
- (void)initializeNotifier:(NSString *)key;

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

#endif /* INotifier_h */
