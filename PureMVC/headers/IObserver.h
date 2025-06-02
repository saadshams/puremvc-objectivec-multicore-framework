//
//  IObserver.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IObserver_h
#define IObserver_h

#import <Foundation/Foundation.h>
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IObserver

@property (nonatomic) SEL notify;
@property (nonatomic, weak) id context;

- (void)notifyObserver:(id<INotification>)notification;
- (BOOL)compareNotifyContext:(id)object;

@end

NS_ASSUME_NONNULL_END

#endif /* IObserver_h */
