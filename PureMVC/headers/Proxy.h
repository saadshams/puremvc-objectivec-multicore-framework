//
//  Proxy.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Proxy_h
#define Proxy_h

#import <Foundation/Foundation.h>
#import "Notifier.h"
#import "IProxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface Proxy : Notifier <IProxy>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id data;

+ (NSString *)NAME;
+ (instancetype)proxy;
+ (instancetype)withName:(NSString *)name;
+ (instancetype)withData:(id)data;
+ (instancetype)withName:(NSString *)name data:(id)data;

- (instancetype)initWithName:(nullable NSString *)name data:(nullable id)data;

@end

NS_ASSUME_NONNULL_END

#endif /* Proxy_h */
