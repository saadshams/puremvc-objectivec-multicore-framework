//
//  Notifier.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Notifier.h"
#import "Facade.h"

NS_ASSUME_NONNULL_BEGIN

@interface Notifier()

@property (nonatomic, copy, readonly) NSString *multitonKey;

@end

/**
A Base `INotifier` implementation.

`MacroCommand, Command, Mediator` and `Proxy`
all have a need to send `Notifications`.

The `INotifier` interface provides a common method called
`sendNotification` that relieves implementation code of
the necessity to actually construct `Notifications`.

The `Notifier` class, which all of the above mentioned classes
extend, provides an initialized reference to the `Facade`
Multiton, which is required for the convienience method
for sending `Notifications`, but also eases implementation as these
classes have frequent `Facade` interactions and usually require
access to the facade anyway.

NOTE: In the MultiCore version of the framework, there is one caveat to
notifiers, they cannot send notifications or reach the facade until they
have a valid multitonKey.

The multitonKey is set:
* on a Command when it is executed by the Controller
* on a Mediator is registered with the View
* on a Proxy is registered with the Model.

`@see Proxy`

`@see Facade`

`@see Mediator`

`@see MacroCommand`

`@see SimpleCommand`
*/
@implementation Notifier

/// Reference to the Facade Multiton
- (nullable id<IFacade>)facade {
    if (self.multitonKey == nil) {
        // Message constant
        [NSException raise:@"MultitonException" format:@"multitonKey for this Notifier not yet initialized!"];
    }
    // returns instance mapped to multitonKey if it exists otherwise defaults to Facade
    return [Facade getInstance:self.multitonKey factory:^(NSString *key) { return [Facade withKey:key]; }];
}

/**
Initialize this INotifier instance.

This is how a Notifier gets its multitonKey.
Calls to sendNotification or to access the
facade will fail until after this method
has been called.

Mediators, Commands or Proxies may override
this method in order to send notifications
or access the Multiton Facade instance as
soon as possible. They CANNOT access the facade
in their constructors, since this method will not
yet have been called.

- parameter key: the multitonKey for this INotifier to use
*/
- (void)initializeNotifier:(NSString *)key {
    _multitonKey = key;
}

/**
Create and send an `INotification`.

Keeps us from having to construct new INotification
instances in our implementation code.

- parameter notificationName: the name of the notification to send
- parameter body: the body of the notification (optional)
- parameter type: the type of the notification (optional)
*/
- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type {
    [self sendNotification:notificationName body:body type:type];
}

/**
 * Send an `INotification` with name only.
 *
 * @param notificationName The name of the notification to send.
 */
-(void)sendNotification:(NSString *)notificationName {
    [self sendNotification:notificationName body:nil type:nil];
}

/**
 * Send an `INotification` with a name and body.
 *
 * @param notificationName The name of the notification.
 * @param body The body content of the notification.
 */
-(void)sendNotification:(NSString *)notificationName body:(id)body {
    [self sendNotification:notificationName body:body type:nil];
}

/**
 * Send an `INotification` with a name and type.
 *
 * @param notificationName The name of the notification.
 * @param type The type string of the notification.
 */
-(void)sendNotification:(NSString *)notificationName type:(NSString *)type {
    [self sendNotification:notificationName body:nil type:type];
}

@end

NS_ASSUME_NONNULL_END
