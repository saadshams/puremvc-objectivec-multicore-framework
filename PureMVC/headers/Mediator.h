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
#import "IMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface Mediator : NSObject <IMediator>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id view;

+ (NSString *)NAME;
+ (instancetype)mediator;
+ (instancetype)withName:(NSString *)name;
+ (instancetype)withView:(id)view;
+ (instancetype)withName:(NSString *)name view:(id)view;

- (instancetype)initWithName:(nullable NSString *)name view:(nullable id)view;

@end

NS_ASSUME_NONNULL_END

#endif /* Mediator_h */
