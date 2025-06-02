//
//  ICommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef ICommand_h
#define ICommand_h

#import <Foundation/Foundation.h>
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ICommand

- (void)execute:(id<INotification>)notification;

@end

NS_ASSUME_NONNULL_END

#endif /* ICommand_h */
