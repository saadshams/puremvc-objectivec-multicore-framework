//
//  Proxy.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Proxy_h
#define Proxy_h

#import <Foundation/Foundation.h>
#import "IProxy.h"
#import "Notifier.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base `IProxy` implementation.

 In PureMVC, `Proxy` classes are used to manage parts of the application’s data model.

 Proxies assume these responsibilities:

 - Implement a common method interface for setting and getting data.
 - Provide named access to encapsulated data.
 - Send `INotification`s when their data changes.
 - Typically register themselves with the `Model` and expose their data through public methods.

 @see IProxy
 @see Notification
 */
@interface Proxy : Notifier <IProxy>

/// The name of the `Proxy`.
@property (nonatomic, copy, readonly) NSString *name;

/// The encapsulated data object managed by this `Proxy`.
@property (nonatomic, strong, nullable) id data;

/**
 Returns the default name for the `Proxy`.

 @return A static string name.
 */
+ (NSString *)NAME;

/**
 Creates a new `Proxy` with the default name.

 @return A new `Proxy` instance.
 */
+ (instancetype)proxy;

/**
 Creates a new `Proxy` with the given name.

 @param name The name of the `Proxy`.
 @return A new `Proxy` instance with the specified name.
 */
+ (instancetype)withName:(NSString *)name;

/**
 Creates a new `Proxy` with the given data.

 @param data The data to be managed by the `Proxy`.
 @return A new `Proxy` instance with the specified data.
 */
+ (instancetype)withData:(id)data;

/**
 Creates a new `Proxy` with the given name and data.

 @param name The name of the `Proxy`.
 @param data The data to be managed by the `Proxy`.
 @return A new `Proxy` instance.
 */
+ (instancetype)withName:(NSString *)name data:(id)data;

/**
 Initializes a `Proxy` with the given name and data.

 @param name The name of the `Proxy`.
 @param data The data to be managed by the `Proxy`.
 @return An initialized `Proxy` instance.
 */
- (instancetype)initWithName:(nullable NSString *)name data:(nullable id)data;

@end

NS_ASSUME_NONNULL_END

#endif /* Proxy_h */
