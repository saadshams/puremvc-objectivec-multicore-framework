//
//  Proxy.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Proxy.h"

NS_ASSUME_NONNULL_BEGIN

/**
A base `IProxy` implementation.

In PureMVC, `Proxy` classes are used to manage parts of the
application's data model.

A `Proxy` might simply manage a reference to a local data object,
in which case interacting with it might involve setting and
getting of its data in synchronous fashion.

`Proxy` classes are also used to encapsulate the application's
interaction with remote services to save or retrieve data, in which case,
we adopt an asyncronous idiom; setting data (or calling a method) on the
`Proxy` and listening for a `Notification` to be sent
when the `Proxy` has retrieved the data from the service.

`@see Model`
*/
@implementation Proxy

/// Default proxy name
+ (NSString *)NAME { return @"Proxy"; }

/**
 * Convenience constructor that creates and returns a Proxy instance
 *
 * @return A new instance initialized with the default name.
 */
+ (instancetype)proxy {
    return [[self alloc] initWithName:[[self class] NAME] data: nil];
}

/**
 * Convenience constructor that creates and returns an instance initialized with the given name
 *
 * @param name The name identifier for this instance.
 * @return A new instance initialized with the specified name.
 */
+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name data:nil];
}

/**
 * Convenience constructor that creates and returns an instance initialized with the given data.
 *
 * @param data The associated data object.
 * @return A new instance initialized with the specified data.
 */
+ (instancetype)withData:(id)data {
    return [[self alloc] initWithName:[[self class] NAME] data:nil];
}

/**
 * Convenience constructor that creates and returns an instance initialized with the given name and data.
 *
 * @param name The name identifier for this instance.
 * @param data The associated data object.
 * @return A new instance initialized with the specified name and data.
 */
+ (instancetype)withName:(NSString *)name data:(id)data {
    return [[self alloc] initWithName:name data:data];
}

/// Constructor
- (instancetype)initWithName:(nullable NSString *)name data:(nullable id)data {
    if (self = [super init]) {
        _name = (name == nil) ? [[self class] NAME] : [name copy];
        _data = data;
    }
    return self;
}

/// Called by the Model when the Proxy is registered
- (void)onRegister {
    
}

/// Called by the Model when the Proxy is removed
- (void)onRemove {
    
}

@end

NS_ASSUME_NONNULL_END
