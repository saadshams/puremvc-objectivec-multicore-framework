//
//  MacroCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef MacroCommand_h
#define MacroCommand_h

#import <Foundation/Foundation.h>
#import "Notifier.h"
#import "ICommand.h"

NS_ASSUME_NONNULL_BEGIN

/**
 A base class for commands that execute other commands in sequence.

 A `MacroCommand` maintains a list of subcommands. When `execute:` is called,
 each subcommand is instantiated via its factory block and executed in FIFO order.
 */
@interface MacroCommand : Notifier <ICommand>

/**
 Factory method to create a new `MacroCommand` instance.

 @return A new instance of `MacroCommand`.
 */
+ (instancetype)command;

/**
 Constructor.

 You should not override this method. Instead, override `initializeMacroCommand`
 in your subclass to register subcommands using `addSubCommand:`.
 */
- (instancetype)init;

/**
 Initialize the list of subcommands.

 Override this method in your subclass and add subcommands by calling
 `addSubCommand:` with blocks that return `ICommand` instances.
 */
- (void)initializeMacroCommand;

/**
 Add a subcommand factory block to the list.

 Subcommands will be executed in the order they are added (FIFO).

 @param factory A block that returns an object conforming to `ICommand`.
 */
- (void)addSubCommand:(id<ICommand> (^)(void))factory;

@end

NS_ASSUME_NONNULL_END

#endif /* MacroCommand_h */
