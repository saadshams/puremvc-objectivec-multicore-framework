//
//  ModelTestProxy.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Proxy.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModelTestProxy : Proxy

+ (NSString *)NAME;
+ (NSString *)ON_REGISTER_CALLED;
+ (NSString *)ON_REMOVE_CALLED;

@end

NS_ASSUME_NONNULL_END
