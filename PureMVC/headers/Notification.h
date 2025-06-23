//
//  Notification.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Notification_h
#define Notification_h

#import <Foundation/Foundation.h>
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base `INotification` implementation.

 `Notification` is used to encapsulate and convey information within the PureMVC system.
 It consists of a `name`, an optional `body` (payload), and an optional `type` to provide context.
 */
@interface Notification : NSObject <INotification>

/// The name of the notification. This is a required value.
@property (nonatomic, copy, readonly) NSString *name;

/// The body of the notification. Typically used to pass application-specific data.
@property (nonatomic, strong, nullable) id body;

/// The type of the notification. Often used to provide additional context.
@property (nonatomic, copy, nullable) NSString *type;

/**
 Factory method to create a `Notification` with just a name.

 @param name The name of the notification.
 @return A new `Notification` instance.
 */
+ (instancetype)withName:(NSString *)name;

/**
 Factory method to create a `Notification` with a name and a body.

 @param name The name of the notification.
 @param body The optional payload for the notification.
 @return A new `Notification` instance.
 */
+ (instancetype)withName:(NSString *)name body:(id)body;

/**
 Factory method to create a `Notification` with name, body, and type.

 @param name The name of the notification.
 @param body The optional payload.
 @param type The optional type descriptor.
 @return A new `Notification` instance.
 */
+ (instancetype)withName:(NSString *)name body:(id)body type:(NSString *)type;


/**
 Designated initializer.

 @param name The name of the notification.
 @param body The optional body object.
 @param type The optional type string.
 @return An initialized `Notification` instance.
 */
- (instancetype)initWithName:(NSString *)name body:(nullable id)body type:(nullable NSString *)type;


/**
 Returns a textual representation of the `Notification`, useful for debugging.

 @return A string describing the notification.
 */
- (NSString *)description;

@end

NS_ASSUME_NONNULL_END

#endif /* Notification_h */
