//
//  INotifier.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef INotifier_h
#define INotifier_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IFacade;

@protocol INotifier

- (void)initializeNotifier:(NSString *)key;

- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type;
- (void)sendNotification:(NSString *)notificationName;
- (void)sendNotification:(NSString *)notificationName body:(id)body;
- (void)sendNotification:(NSString *)notificationName type:(NSString *)type;

@end

NS_ASSUME_NONNULL_END

#endif /* INotifier_h */
