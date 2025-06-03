//
//  IView.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IView_h
#define IView_h

#import <Foundation/Foundation.h>
#import "IObserver.h"
#import "IMediator.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IView

- (void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer;

- (void)notifyObservers:(id<INotification>)notification;

- (void)removeObserver:(NSString *)notificationName context:(id)context;

- (void)registerMediator:(id<IMediator>)mediator;

- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName;

- (BOOL)hasMediator:(NSString *)mediatorName;

- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName;

@end

NS_ASSUME_NONNULL_END

#endif /* IView_h */
