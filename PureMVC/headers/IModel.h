//
//  IModel.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IModel_h
#define IModel_h

#import <Foundation/Foundation.h>
#import "IProxy.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IModel

- (void)registerProxy:(id<IProxy>)proxy;

- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName;

- (BOOL)hasProxy:(NSString *)proxyName;

- (nullable id<IProxy>)removeProxy:(NSString *)proxyName;

@end

NS_ASSUME_NONNULL_END

#endif /* IModel_h */
