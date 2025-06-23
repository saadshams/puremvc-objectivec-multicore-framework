//
//  Mediator.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Mediator_h
#define Mediator_h

#import <Foundation/Foundation.h>
#import "Notifier.h"
#import "IMediator.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base `IMediator` implementation.

 In PureMVC, `Mediator` acts as an intermediary between the view components
 and the rest of the application. It listens for `INotification`s and handles
 interaction logic related to the view it encapsulates.
 */
@interface Mediator : Notifier <IMediator>

/// The name of the `Mediator` instance.
@property (nonatomic, copy, readonly) NSString *name;

/// The view component associated with this `Mediator`.
@property (nonatomic, strong, nullable) id view;

/**
 Returns the default name used for this `Mediator`.

 @return A constant string name.
 */
+ (NSString *)NAME;

/**
 Factory method to create a `Mediator` with default name and no view.

 @return A new `Mediator` instance.
 */
+ (instancetype)mediator;

/**
 Factory method to create a `Mediator` with a specified name.

 @param name The name of the `Mediator`.
 @return A new `Mediator` instance.
 */
+ (instancetype)withName:(NSString *)name;

/**
 Factory method to create a `Mediator` with a view component.

 @param view The view component to associate with the `Mediator`.
 @return A new `Mediator` instance.
 */
+ (instancetype)withView:(id)view;

/**
 Factory method to create a `Mediator` with both name and view.

 @param name The name of the `Mediator`.
 @param view The view component to associate with the `Mediator`.
 @return A new `Mediator` instance.
 */
+ (instancetype)withName:(NSString *)name view:(id)view;

/**
 Designated initializer.

 @param name The name of the `Mediator`. If `nil`, the default name will be used.
 @param view The view component to associate with the `Mediator`.
 @return An initialized `Mediator` instance.
 */
- (instancetype)initWithName:(nullable NSString *)name view:(nullable id)view;

@end

NS_ASSUME_NONNULL_END

#endif /* Mediator_h */
