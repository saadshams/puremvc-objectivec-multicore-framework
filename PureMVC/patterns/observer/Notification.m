//
//  Notification.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Notification.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Notification

+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name body:nil type:nil];
}

+ (instancetype)withName:(NSString *)name body:(id)body {
    return [[self alloc] initWithName:name body:body type:nil];
}

+ (instancetype)withName:(NSString *)name body:(id)body type:(NSString *)type {
    return [[self alloc] initWithName:name body:body type:type];
}

- (instancetype)initWithName:(NSString *)name body:(nullable id)body type:(nullable NSString *)type {
    if (self = [super init]) {
        _name = name;
        _body = body;
        _type = type;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Notification Name: %@\nBody: %@\nType: %@", _name, _body, _type];
}

@end

NS_ASSUME_NONNULL_END
