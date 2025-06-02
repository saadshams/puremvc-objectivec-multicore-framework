//
//  MacroCommandTestCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "ICommand.h"
#import "MacroCommandTestCommand.h"
#import "MacroCommandTestSub1Command.h"
#import "MacroCommandTestSub2Command.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MacroCommandTestCommand

- (void)initializeMacroCommand {
    [self addSubCommand:^id<ICommand> { return [MacroCommandTestSub1Command command]; } ];
    [self addSubCommand:^id<ICommand> { return [MacroCommandTestSub2Command command]; } ];
}

@end

NS_ASSUME_NONNULL_END
