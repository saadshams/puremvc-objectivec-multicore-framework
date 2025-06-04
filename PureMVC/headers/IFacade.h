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
#import "INotifier.h"
#import "ICommand.h"
#import "IProxy.h"
#import "IMediator.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IFacade <INotifier>

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

@end

NS_ASSUME_NONNULL_END

#endif /* IFacade_h */
