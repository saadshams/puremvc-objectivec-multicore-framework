//
//  IController.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IController_h
#define IController_h

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IController

- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory;

- (void)executeCommand:(id<INotification>)notification;

- (BOOL)hasCommand:(NSString *)notificationName;

- (void)removeCommand:(NSString *)notificationName;

@end

NS_ASSUME_NONNULL_END

#endif /* IController_h */
