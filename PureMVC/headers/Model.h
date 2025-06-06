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

@interface Model : NSObject <IModel>

+ (id<IModel>) getInstance:(NSString *)key factory:(id<IModel> (^)(NSString *key))factory;
+ (void) removeModel:(NSString *)key;
+ (instancetype) withKey:(NSString *)key;

- (instancetype) initWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

#endif /* Model_h */
