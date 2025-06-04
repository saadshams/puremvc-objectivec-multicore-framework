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

+ (id<IFacade>)getInstance:(NSString *)key factory:(id<IFacade> (^)(NSString *key))factory;
+ (BOOL)hasCore:(NSString *)key;
+ (void)removeCore:(NSString *)key;
+ (instancetype)withKey:(NSString *)key;

- (instancetype)initWithKey:(NSString *)key;

- (void)initializeFacade;
- (void)initializeController;
- (void)initializeModel;
- (void)initializeView;

@end

NS_ASSUME_NONNULL_END

#endif /* Facade_h */
