//
//  Facade.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "IFacade.h"
#import "Facade.h"
#import "IController.h"
#import "Controller.h"
#import "IModel.h"
#import "Model.h"
#import "IView.h"
#import "View.h"
#import "INotification.h"
#import "Notification.h"

NS_ASSUME_NONNULL_BEGIN

@interface Facade()

@property (nonatomic, copy, readonly) NSString *multitonKey;
@property (nonatomic, strong, nullable) id<IController> controller;
@property (nonatomic, strong, nullable) id<IModel> model;
@property (nonatomic, strong, nullable) id<IView> view;

@end

static NSMutableDictionary<NSString *, id<IFacade>> *instanceMap = nil;

__attribute__((constructor()))
static void initialize(void) {
    instanceMap = [NSMutableDictionary dictionary];
}

@implementation Facade

+ (id<IFacade>)getInstance:(NSString *)key factory:(id<IFacade> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

+ (BOOL)hasCore:(NSString *)key {
    @synchronized (instanceMap) {
        return instanceMap[key] != nil;
    }
}

+ (void)removeCore:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

+ (instancetype)withKey:(NSString *)key {
    return [[Facade alloc] initWithKey:key];
}

- (instancetype)initWithKey:(NSString *)key {
    if (instanceMap[key] != nil) {
        [NSException raise:@"FacadeAlreadyExistsException" format:@"A Facade instance already exists for key '%@'.", key];
    }
    if (self = [super init]) {
        [self initializeNotifier:key];
        [instanceMap setObject:self forKey:key];
        [self initializeFacade];
    }
    return self;
}

- (void)initializeFacade {
    [self initializeModel];
    [self initializeController];
    [self initializeView];
}

- (void)initializeController {
    self.controller = [Controller getInstance:self.multitonKey factory:^(NSString *key){ return [Controller withKey:key]; }];
}

- (void)initializeModel {
    self.model = [Model getInstance:self.multitonKey factory:^(NSString *key) { return [Model withKey:key]; }];
}

- (void)initializeView {
    self.view = [View getInstance:self.multitonKey factory:^(NSString *key) { return [View withKey:key]; }];
}

- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory {
    [self.controller registerCommand:notificationName factory:factory];
}

- (BOOL)hasCommand:(NSString *)notificationName {
    return [self.controller hasCommand:notificationName];
}

- (void)removeCommand:(NSString *)notificationName {
    [self.controller removeCommand:notificationName];
}

- (void)registerProxy:(id<IProxy>)proxy {
    [self.model registerProxy:proxy];
}

- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName {
    return [self.model retrieveProxy:proxyName];
}

- (BOOL)hasProxy:(NSString *)proxyName {
    return [self.model hasProxy:proxyName];
}

- (nullable id<IProxy>)removeProxy:(NSString *)proxyName {
    return [self.model removeProxy:proxyName];
}

- (void)registerMediator:(id<IMediator>)mediator {
    [self.view registerMediator:mediator];
}

- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName {
    return [self.view retrieveMediator:mediatorName];
}

- (BOOL)hasMediator:(NSString *)mediatorName {
    return [self.view hasMediator:mediatorName];
}

- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName {
    return [self.view removeMediator:mediatorName];
}

- (void)notifyObservers:(id<INotification>)notification {
    [self.view notifyObservers:notification];
}

- (void)initializeNotifier:(NSString *)key {
    _multitonKey = [key copy];
}

- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type {
    [self notifyObservers:[Notification withName:notificationName body:body type:type]];
}

-(void)sendNotification:(NSString *)notificationName {
    [self sendNotification:notificationName body:nil type:nil];
}

-(void)sendNotification:(NSString *)notificationName body:(id)body {
    [self sendNotification:notificationName body:body type:nil];
}

-(void)sendNotification:(NSString *)notificationName type:(NSString *)type {
    [self sendNotification:notificationName body:nil type:type];
}

@end

NS_ASSUME_NONNULL_END
