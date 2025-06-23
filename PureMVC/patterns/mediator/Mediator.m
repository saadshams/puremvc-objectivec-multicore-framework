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

`@see org.puremvc.swift.multicore.core.View View`
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
    return [[self alloc] initWithName:[[self class] NAME] view:nil];
}

/// The mediator name
+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name view:nil];
}

/// The view component
+ (instancetype)withView:(id)view {
    return [[self alloc] initWithName:[[self class] NAME] view:view];
}

/**
 * Convenience constructor that creates and returns an instance
 * initialized with the given name and view.
 *
 * @param name The unique name identifier for this instance.
 * @param view The associated view object.
 * @return A new instance initialized with the specified name and view.
 */
+ (instancetype)withName:(NSString *)name view:(id)view {
    return [[self alloc] initWithName:name view:view];
}

/**
Constructor.

- parameter name: the mediator name
- parameter viewComponent: viewComponent instance
*/
- (instancetype)initWithName:(nullable NSString *)name view:(nullable id)view {
    if (self = [super init]) {
        _name = (name == nil) ? [[self class] NAME] : [name copy];
        _view = view;
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
