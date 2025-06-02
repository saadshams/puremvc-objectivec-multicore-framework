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

@implementation MacroCommand

+ (instancetype)command {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        _subCommands = [NSMutableArray array];
        [self initializeMacroCommand];
    }
    return self;
}

- (void)initializeMacroCommand {
    
}

- (void)addSubCommand:(id<ICommand> (^)(void))factory {
    [self.subCommands addObject:factory];
}

- (void)execute:(id<INotification>)notification {
    while (self.subCommands.count > 0) {
        id<ICommand> (^factory)(void) = [self.subCommands firstObject];
        [self.subCommands removeObjectAtIndex:0];
        
        id command = factory();
        //[instance initializeNotifier:self.multitonKey];
        [command execute:notification];
    }
}

@end

NS_ASSUME_NONNULL_END
