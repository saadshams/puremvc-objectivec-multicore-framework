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
#import "ICommand.h"

NS_ASSUME_NONNULL_BEGIN

@interface MacroCommand : NSObject <ICommand>

+ (instancetype)command;

- (instancetype)init;
- (void)initializeMacroCommand;
- (void)addSubCommand:(id<ICommand> (^)(void))factory;

@end

NS_ASSUME_NONNULL_END

#endif /* MacroCommand_h */
