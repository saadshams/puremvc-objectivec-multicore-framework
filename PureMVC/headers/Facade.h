//
//  Facade.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Facade_h
#define Facade_h

#import <Foundation/Foundation.h>
#import "IFacade.h"

NS_ASSUME_NONNULL_BEGIN

@interface Facade : NSObject <IFacade>

/**
 * Returns the Multiton `Facade` instance for the given key.
 *
 * @param key The unique multiton key.
 * @param factory Closure that returns a new `IFacade` instance if none exists for the key.
 * @return The `Facade` instance associated with the key.
 */
+ (id<IFacade>)getInstance:(NSString *)key factory:(id<IFacade> (^)(NSString *key))factory;

/**
 * Checks if a Core (Facade) instance exists for the given key.
 *
 * @param key The multiton key.
 * @return YES if a Core exists for the key, NO otherwise.
 */
+ (BOOL)hasCore:(NSString *)key;

/**
 * Removes the Core (Facade) instance and its associated Model, View, Controller for the given key.
 *
 * @param key The multiton key of the Core to remove.
 */
+ (void)removeCore:(NSString *)key;

/**
 * Convenience constructor creating a new Facade instance with the given key.
 *
 * @param key The multiton key.
 * @return A new Facade instance initialized with the key.
 */
+ (instancetype)withKey:(NSString *)key;

/**
 * Initializes a new Facade instance with the given multiton key.
 *
 * @param key The multiton key.
 * @return An initialized Facade instance.
 */
- (instancetype)initWithKey:(NSString *)key;

/**
 * Initialize the Facade, including Model, View, and Controller.
 * Called by the constructor; override for subclass-specific initialization.
 */
- (void)initializeFacade;

/**
 * Initialize the Controller instance.
 * Override to customize Controller initialization or register Commands.
 */
- (void)initializeController;

/**
 * Initialize the Model instance.
 * Override to customize Model initialization or register Proxies.
 */
- (void)initializeModel;

/**
 * Initialize the View instance.
 * Override to customize View initialization or register Mediators.
 */
- (void)initializeView;

@end

NS_ASSUME_NONNULL_END

#endif /* Facade_h */
