//
//  Observer.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Observer_h
#define Observer_h

#import <Foundation/Foundation.h>
#import "IObserver.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base `IObserver` implementation.

 In PureMVC, `Observer` encapsulates information about an interested object with a method
 that should be called when a particular `INotification` is broadcast.

 The `Observer` class assumes these responsibilities:

 - Encapsulate the `context` (the object to notify).
 - Encapsulate the `notify` selector (the method to call on the context).
 - Provide a method for comparing notification contexts.
 - Provide a method for calling the encapsulated method on the context.

 @see org.puremvc.swift.multicore.patterns.observer.Notification Notification
 */
@interface Observer : NSObject <IObserver>

/// The selector to call on the `context` when a notification is dispatched.
@property (nonatomic) SEL notify;

/// The object that should be notified when a notification is dispatched.
@property (nonatomic, weak) id context;

/**
 Factory method to create a new `Observer`.

 @param notify The selector to call when notification is triggered.
 @param context The object to notify.
 @return An instance of `Observer`.
 */
+ (instancetype)withNotify:(nullable SEL)notify context:(nullable id)context;


/**
 Designated initializer.

 @param notify The selector to call when notification is triggered.
 @param context The object to notify.
 @return An initialized `Observer` instance.
 */
- (instancetype)initWithNotify:(nullable SEL)notify context:(nullable id)context;

@end

NS_ASSUME_NONNULL_END

#endif /* Observer_h */
