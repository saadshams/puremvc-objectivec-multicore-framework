//
//  IMediator.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IMediator_h
#define IMediator_h

#import <Foundation/Foundation.h>
#import "INotifier.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IMediator <INotifier>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id view;

- (void)onRegister;

- (void)onRemove;

- (NSArray<NSString *> *)listNotificationInterests;

- (void)handleNotification:(id<INotification>)notification;

@end

NS_ASSUME_NONNULL_END

#endif /* IMediator_h */
