//
//  Observer.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Observer.h"

NS_ASSUME_NONNULL_BEGIN

/**
A base `IObserver` implementation.

An `Observer` is an object that encapsulates information
about an interested object with a method that should
be called when a particular `INotification` is broadcast.

In PureMVC, the `Observer` class assumes these responsibilities:

* Encapsulate the notification (callback) method of the interested object.
* Encapsulate the notification context (this) of the interested object.
* Provide methods for setting the notification method and context.
* Provide a method for notifying the interested object.

`@see View`

`@see Notification`
*/
@implementation Observer

/**
 * Creates and returns an instance initialized with the given notification selector and context.
 *
 * @param notify The selector to be called for notification (nullable).
 * @param context The context object for the notification (nullable).
 * @return A new instance initialized with the specified notification selector and context.
 */
+ (instancetype)withNotify:(nullable SEL)notify context:(nullable id)context {
    return [[self alloc] initWithNotify:notify context:context];
}

/**
Constructor.

The notification method on the interested object should take
one parameter of type `INotification`

- parameter notifyMethod: the notification method of the interested object
- parameter notifyContext: the notification context of the interested object
*/
- (instancetype)initWithNotify:(nullable SEL)notify context:(nullable id)context {
    if (self = [super init]) {
        _notify = notify;
        _context = context;
    }
    return self;
}

/**
Notify the interested object.

- parameter notification: the `INotification` to pass to the interested object's notification method.
*/
- (void)notifyObserver:(id<INotification>)notification {
    if (self.notify && [self.context respondsToSelector:self.notify]) {
        // Suppress "performSelector may cause leak" warning
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.context performSelector:self.notify withObject:notification];
        #pragma clang diagnostic pop
    }
}

/**
Compare an object to the notification context.

- parameter object: the object to compare
- returns: boolean indicating if the object and the notification context are the same
*/
- (BOOL)compareNotifyContext:(id)object {
    return object == self.context;
}

@end

NS_ASSUME_NONNULL_END
