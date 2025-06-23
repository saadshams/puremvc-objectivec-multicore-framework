//
//  Controller.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Controller_h
#define Controller_h

#import <Foundation/Foundation.h>
#import "IController.h"

NS_ASSUME_NONNULL_BEGIN

@interface Controller : NSObject <IController>

/**
 * Returns the Multiton `Controller` instance associated with the given key.
 *
 * @param key The unique multiton key.
 * @param factory A closure that returns a new `IController` instance if none exists for the key.
 * @return The `Controller` instance for the given key.
 */
+ (id<IController>) getInstance:(NSString *)key factory:(id<IController> (^)(NSString *key))factory;

/**
 * Removes the `Controller` instance associated with the given key.
 *
 * @param key The multiton key of the `Controller` instance to remove.
 */
+ (void) removeController:(NSString *)key;

/**
 * Convenience constructor that creates a new `Controller` instance with the given key.
 *
 * @param key The multiton key.
 * @return A new `Controller` instance initialized with the key.
 */
+ (instancetype) withKey:(NSString *)key;

/**
 * Initializes a new `Controller` instance with the given multiton key.
 *
 * @param key The multiton key.
 * @return An initialized `Controller` instance.
 */
- (instancetype) initWithKey:(NSString *)key;

/**
 Initialize the `Controller` instance.
 */
- (void)initializeController;

@end

NS_ASSUME_NONNULL_END

#endif /* Controller_h */
