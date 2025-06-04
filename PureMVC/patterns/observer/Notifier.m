//
//  Notifier.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Notifier.h"
#import "IFacade.h"
#import "Facade.h"

NS_ASSUME_NONNULL_BEGIN

@interface Notifier()

@property (nonatomic, copy, readonly) NSString *multitonKey;

@end

@implementation Notifier

- (nullable id<IFacade>)facade {
    if (self.multitonKey == nil) {
        [NSException raise:@"MultitonException" format:@"multitonKey for this Notifier not yet initialized!"];
    }
    return [Facade getInstance:self.multitonKey factory:^(NSString *key) { return [Facade withKey:key]; }];
}

- (void)initializeNotifier:(NSString *)key {
    _multitonKey = key;
}

- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type {
    [self sendNotification:notificationName body:body type:type];
}

- (void)sendNotification:(NSString *)notificationName {
    [self sendNotification:notificationName body:nil type:nil];
}

- (void)sendNotification:(NSString *)notificationName body:(id)body {
    [self sendNotification:notificationName body: body type: nil];
}

- (void)sendNotification:(NSString *)notificationName type:(NSString *)type {
    [self sendNotification:notificationName body: nil type:type];
}

@end

NS_ASSUME_NONNULL_END
