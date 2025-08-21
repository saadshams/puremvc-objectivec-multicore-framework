//
//  Notification.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Notification.h"

NS_ASSUME_NONNULL_BEGIN

/**
A base `INotification` implementation.

PureMVC does not rely upon underlying event models such
as the one provided with Flash, and ActionScript 3 does
not have an inherent event model.

The Observer Pattern as implemented within PureMVC exists
to support event-driven communication between the
application and the actors of the MVC triad.

Notifications are not meant to be a replacement for Events
in Flex/Flash/Apollo. Generally, `IMediator` implementors
place event listeners on their view components, which they
then handle in the usual way. This may lead to the broadcast of `Notification`s to
trigger `ICommand`s or to communicate with other `IMediators`. `IProxy` and `ICommand`
instances communicate with each other and `IMediator`s
by broadcasting `INotification`s.

A key difference between Flash `Event`s and PureMVC
`Notification`s is that `Event`s follow the
'Chain of Responsibility' pattern, 'bubbling' up the display hierarchy
until some parent component handles the `Event`, while
PureMVC `Notification`s follow a 'Publish/Subscribe'
pattern. PureMVC classes need not be related to each other in a
parent/child relationship in order to communicate with one another
using `Notification`s.

`@see Observer`
*
*/
@implementation Notification

/**
 Creates a new `Notification` instance with the given name.

- parameter name: name of the `Notification` instance. (required)
*/
+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name body:nil type:nil];
}

/**
 Creates a new `Notification` instance with the given name and body.

- parameter name: name of the `Notification` instance. (required)
- parameter body: the `Notification` body. (optional)
*/
+ (instancetype)withName:(NSString *)name body:(id)body {
    return [[self alloc] initWithName:name body:body type:nil];
}

/**
 Creates a new `Notification` instance with the given name, body and type.

- parameter name: name of the `Notification` instance. (required)
- parameter body: the `Notification` body. (optional)
- parameter type: the type of the `Notification` (optional)
*/
+ (instancetype)withName:(NSString *)name body:(id)body type:(NSString *)type {
    return [[self alloc] initWithName:name body:body type:type];
}

/**
 Creates a new `Notification` instance with the given name, body and type.

- parameter name: name of the `Notification` instance. (required)
- parameter body: the `Notification` body. (optional)
- parameter type: the type of the `Notification` (optional)
*/
- (instancetype)initWithName:(NSString *)name body:(nullable id)body type:(nullable NSString *)type {
    if (self = [super init]) {
        _name = name;
        _body = body;
        _type = type;
    }
    return self;
}

/**
Get the string representation of the `Notification` instance.

- returns: the string representation of the `Notification` instance.
*/
- (NSString *)description {
    return [NSString stringWithFormat:@"Notification Name: %@\nBody: %@\nType: %@", _name, _body, _type];
}

@end

NS_ASSUME_NONNULL_END
