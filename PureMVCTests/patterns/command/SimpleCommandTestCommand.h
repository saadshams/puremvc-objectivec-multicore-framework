//
//  SimpleCommandTestCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef SimpleCommandTestCommand_h
#define SimpleCommandTestCommand_h

#import <Foundation/Foundation.h>
#import "SimpleCommand.h"

NS_ASSUME_NONNULL_BEGIN

/**
A SimpleCommand subclass used by SimpleCommandTest.

`@see org.puremvc.swift.multicore.patterns.command.SimpleCommandTest SimpleCommandTest`
`@see org.puremvc.swift.multicore.patterns.command.SimpleCommandTestVO SimpleCommandTestVO`
*/
@interface SimpleCommandTestCommand : SimpleCommand

@end

NS_ASSUME_NONNULL_END

#endif /* SimpleCommandTestCommand_h */
