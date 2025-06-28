//
//  Mediator.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Mediator.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
A base `IMediator` implementation.

`@see View`
*/
@implementation Mediator

/**
The name of the `Mediator`.

Typically, a `Mediator` will be written to serve
one specific control or group controls and so,
will not have a need to be dynamically named.
*/
+ (NSString *)NAME { return @"Mediator"; }

+ (instancetype)mediator {
    return [[self alloc] initWithName:[[self class] NAME] component:nil];
}

/// The mediator name
+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name component:nil];
}

/// The view component
+ (instancetype)withComponent:(id)component {
    return [[self alloc] initWithName:[[self class] NAME] component:component];
}

/**
 * Convenience constructor that creates and returns an instance
 * initialized with the given name and view.
 *
 * @param name The unique name identifier for this instance.
 * @param component The associated view object.
 * @return A new instance initialized with the specified name and view.
 */
+ (instancetype)withName:(NSString *)name component:(id)component {
    return [[self alloc] initWithName:name component:component];
}

/**
Constructor.

- parameter name: the mediator name
- parameter component: view component instance
*/
- (instancetype)initWithName:(nullable NSString *)name component:(nullable id)component {
    if (self = [super init]) {
        _name = (name == nil) ? [[self class] NAME] : [name copy];
        _component = component;
    }
    return self;
}

/// Called by the View when the Mediator is registered
- (void)onRegister {
    
}

/// Called by the View when the Mediator is removed
- (void)onRemove {
    
}

/**
List the `INotification` names this
`Mediator` is interested in being notified of.

- returns: Array the list of `INotification` names
*/
- (NSArray<NSString *> *)listNotificationInterests {
    return @[];
}

/**
Handle `INotification`s.

Typically this will be handled in a switch statement,
with one 'case' entry per `INotification`
the `Mediator` is interested in.
*/
- (void)handleNotification:(id<INotification>)notification {
    
}

@end

NS_ASSUME_NONNULL_END
