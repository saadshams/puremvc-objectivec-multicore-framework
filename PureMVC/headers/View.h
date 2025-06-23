//
//  View.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef View_h
#define View_h

#import <Foundation/Foundation.h>
#import "IView.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A Multiton `IView` implementation.

 In PureMVC, the `View` class assumes the following responsibilities:

 - Caching `IMediator` instances.
 - Registering, retrieving, and removing `IMediator`s.
 - Managing the observer lists for `INotification`s.
 - Notifying registered `IObserver`s when a `INotification` is broadcast.

 @see Mediator
 @see Observer
 @see Notification
 */
@interface View : NSObject <IView>

/**
 View Multiton Factory method.

 Returns the `IView` instance for the specified Multiton key,
 creating it using the supplied factory block if necessary.

 @param key The Multiton key.
 @param factory A block returning a new `IView` instance if needed.
 @return The existing or newly created `IView` instance.
 */
+ (id<IView>) getInstance:(NSString *)key factory:(id<IView> (^)(NSString *key))factory;

/**
 Remove a `IView` instance for a given key.

 @param key The Multiton key of the `IView` instance to remove.
 */
+ (void)removeView:(NSString *)key;

/**
 Internal convenience initializer for use by the factory.

 @param key The Multiton key.
 @return A new instance of `View` tied to the given key.
 */
+ (instancetype) withKey:(NSString *)key;

/**
 Initialize the `View` Multiton instance.

 You should not call this constructor directly. Use `getInstance:factory:` instead.

 @param key The Multiton key.
 @return An initialized `View` instance.
 */
- (instancetype) initWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

#endif /* View_h */
