//
//  Model.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Model_h
#define Model_h

#import <Foundation/Foundation.h>
#import "IModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base Multiton `IModel` implementation.

 In PureMVC, the `Model` class is responsible for managing application data
 through registered `IProxy` instances. It provides methods for registering,
 retrieving, and removing proxies.
 */
@interface Model : NSObject <IModel>

/**
 Retrieve the `Model` instance for the given multiton key. If it does not exist,
 the factory block is called to create it.

 @param key The multiton key for the `Model` instance.
 @param factory A block that returns a new `IModel` instance if one does not exist.
 @return The singleton instance of the `Model` associated with the key.
 */
+ (id<IModel>) getInstance:(NSString *)key factory:(id<IModel> (^)(NSString *key))factory;

/**
 Remove the `Model` instance for a given key.

 @param key The multiton key of the `Model` instance to remove.
 */
+ (void) removeModel:(NSString *)key;

/**
 Factory method to create a new `Model` instance with a specific key.

 @param key The multiton key for this `Model` instance.
 @return A new `Model` instance.
 */
+ (instancetype) withKey:(NSString *)key;

/**
 Designated initializer.

 This constructor should not be called directly. Instead, use `getInstance:factory:`.

 @param key The multiton key for this `Model` instance.
 @return An initialized `Model` instance.
 */
- (instancetype) initWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

#endif /* Model_h */
