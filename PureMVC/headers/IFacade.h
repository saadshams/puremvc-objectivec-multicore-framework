//
//  IFacade.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IFacade_h
#define IFacade_h

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "IProxy.h"
#import "IMediator.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IFacade

- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory;
- (BOOL)hasCommand:(NSString *)notificationName;
- (void)removeCommand:(NSString *)notificationName;

- (void)registerProxy:(id<IProxy>)proxy;
- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName;
- (BOOL)hasProxy:(NSString *)proxyName;
- (nullable id<IProxy>)removeProxy:(NSString *)proxyName;

- (void)registerMediator:(id<IMediator>)mediator;
- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName;
- (BOOL)hasMediator:(NSString *)mediatorName;
- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName;

- (void)notifyObservers:(id<INotification>)notification;


// todo: delete
- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type;
- (void)sendNotification:(NSString *)notificationName;
- (void)sendNotification:(NSString *)notificationName body:(id)body;
- (void)sendNotification:(NSString *)notificationName type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END

#endif /* IFacade_h */
