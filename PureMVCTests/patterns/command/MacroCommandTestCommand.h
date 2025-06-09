//
//  MacroCommandTestCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef MacroCommandTestCommand_h
#define MacroCommandTestCommand_h

#import <Foundation/Foundation.h>
#import "MacroCommand.h"

NS_ASSUME_NONNULL_BEGIN

/**
A MacroCommand subclass used by MacroCommandTest.

`@see org.puremvc.swift.multicore.patterns.command.MacroCommandTest MacroCommandTest`

`@see org.puremvc.swift.multicore.patterns.command.MacroCommandTestSub1Command MacroCommandTestSub1Command`

`@see org.puremvc.swift.multicore.patterns.command.MacroCommandTestSub2Command MacroCommandTestSub2Command`

`@see org.puremvc.swift.multicore.patterns.command.MacroCommandTestVO MacroCommandTestVO`
*/
@interface MacroCommandTestCommand : MacroCommand

@end

NS_ASSUME_NONNULL_END

#endif /* MacroCommandTestCommand_h */
