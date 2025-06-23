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
#import "INotifier.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

/**
The interface definition for a PureMVC Command.

`@see org.puremvc.swift.multicore.interfaces INotification
*/
@protocol ICommand <INotifier>

/**
Execute the `ICommand`'s logic to handle a given `INotification`.

- parameter notification: an `INotification` to handle.
*/
- (void)execute:(id<INotification>)notification;

@end

NS_ASSUME_NONNULL_END

#endif /* ICommand_h */
