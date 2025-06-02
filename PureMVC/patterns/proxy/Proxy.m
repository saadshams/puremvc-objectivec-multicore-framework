//
//  Proxy.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Proxy.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Proxy

+ (NSString *)NAME { return @"Proxy"; }

+ (instancetype)proxy {
    return [[self alloc] initWithName:[[self class] NAME] data: nil];
}

+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name data:nil];
}

+ (instancetype)withData:(id)data {
    return [[self alloc] initWithName:[[self class] NAME] data:nil];
}

+ (instancetype)withName:(NSString *)name data:(id)data {
    return [[self alloc] initWithName:name data:data];
}

- (instancetype)initWithName:(nullable NSString *)name data:(nullable id)data {
    if (self = [super init]) {
        _name = (name == nil) ? [[self class] NAME] : [name copy];
        _data = data;
    }
    return self;
}

- (void)onRegister {
    
}

- (void)onRemove {
    
}

@end

NS_ASSUME_NONNULL_END
