//
//  MacroCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "MacroCommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface MacroCommand()

@property (nonatomic, strong) NSMutableArray<id<ICommand> (^)(void)> *subCommands;

@end

/**
A base `ICommand` implementation that executes other `ICommand`s.

A `MacroCommand` maintains an list of
`ICommand` Class references called *SubCommands*.

When `execute` is called, the `MacroCommand`
retrieves `ICommands` by executing closures and then calls
`execute` on each of its *SubCommands* turn.
Each *SubCommand* will be passed a reference to the original
`INotification` that was passed to the `MacroCommand`'s
`execute` method.

Unlike `SimpleCommand`, your subclass
should not override `execute`, but instead, should
override the `initializeMacroCommand` method,
calling `addSubCommand` once for each *SubCommand*
to be executed.

`@see org.puremvc.swift.multicore.core.Controller Controller`

`@see org.puremvc.swift.multicore.patterns.observer.Notification Notification`

`@see org.puremvc.swift.multicore.patterns.command.SimpleCommand SimpleCommand`
*/
@implementation MacroCommand

+ (instancetype)command {
    return [[self alloc] init];
}

/**
Constructor.

You should not need to define a constructor,
instead, override the `initializeMacroCommand`
method.

If your subclass does define a constructor, be
sure to call `super()`.
*/
- (instancetype)init {
    if (self = [super init]) {
        _subCommands = [NSMutableArray array];
        [self initializeMacroCommand];
    }
    return self;
}

/**
Initialize the `MacroCommand`.

In your subclass, override this method to
initialize the `MacroCommand`'s *SubCommand*
list with closure references like
this:

    // Initialize MyMacroCommand
    public func addSubCommand(closure: () -> ICommand) {
        addSubCommand( { FirstCommand() } );
        addSubCommand( { SecondCommand() } );
        addSubCommand { ThirdCommand() }; // or by using a trailing closure
    }

Note that *SubCommands* may be any closure returning `ICommand`
implementor, `MacroCommands` or `SimpleCommands` are both acceptable.
*/
- (void)initializeMacroCommand {
    
}

/**
Add a *SubCommand*.

The *SubCommands* will be called in First In/First Out (FIFO)
order.

- parameter factory: reference that returns `ICommand`.
*/
- (void)addSubCommand:(id<ICommand> (^)(void))factory {
    [self.subCommands addObject:factory];
}

/**
Execute this `MacroCommand`'s *SubCommands*.

The *SubCommands* will be called in First In/First Out (FIFO)
order.

- parameter notification: the `INotification` object to be passsed to each *SubCommand*.
*/
- (void)execute:(id<INotification>)notification {
    while (self.subCommands.count > 0) {
        id<ICommand> (^factory)(void) = self.subCommands[0];
        [self.subCommands removeObjectAtIndex:0];
        
        id command = factory();
        //[instance initializeNotifier:self.multitonKey];
        [command execute:notification];
    }
}

@end

NS_ASSUME_NONNULL_END
