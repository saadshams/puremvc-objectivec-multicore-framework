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

+ (id<IController>) getInstance:(NSString *)key factory:(id<IController> (^)(NSString *key))factory;
+ (void) removeModel:(NSString *)key;
+ (instancetype) withKey:(NSString *)key;

- (instancetype) initWithKey:(NSString *)key;

/**
 Initialize the `Controller` instance.
 */
- (void)initializeController;

@end

NS_ASSUME_NONNULL_END

#endif /* Controller_h */
