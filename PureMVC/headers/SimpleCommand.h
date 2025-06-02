//
//  SimpleCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef SimpleCommand_h
#define SimpleCommand_h

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleCommand : NSObject <ICommand>

+(instancetype)command;

- (void)execute:(id<INotification>)notification;

@end

NS_ASSUME_NONNULL_END

#endif /* SimpleCommand_h */
