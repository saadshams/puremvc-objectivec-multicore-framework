//
//  Mediator.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Mediator.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Mediator

+ (NSString *)NAME { return @"Mediator"; }

+ (instancetype)mediator {
    return [[self alloc] initWithName:[[self class] NAME] view:nil];
}

+ (instancetype)withName:(NSString *)name {
    return [[self alloc] initWithName:name view:nil];
}

+ (instancetype)withView:(id)view {
    return [[self alloc] initWithName:[[self class] NAME] view:view];
}

+ (instancetype)withName:(NSString *)name view:(id)view {
    return [[self alloc] initWithName:name view:view];
}

- (instancetype)initWithName:(nullable NSString *)name view:(nullable id)view {
    if (self = [super init]) {
        _name = (name == nil) ? [[self class] NAME] : [name copy];
        _view = view;
    }
    return self;
}

- (void)onRegister {
    
}

- (void)onRemove {
    
}

- (NSArray<NSString *> *)listNotificationInterests {
    return @[];
}

- (void)handleNotification:(id<INotification>)notification {
    
}

@end

NS_ASSUME_NONNULL_END
