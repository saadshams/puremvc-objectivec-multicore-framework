//
//  MacroCommandTestSub2Command.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "MacroCommandTestSub2Command.h"
#import "INotification.h"
#import "MacroCommandTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MacroCommandTestSub2Command

- (void)execute:(id<INotification>)notification {
    MacroCommandTestVO *vo = [notification body];
    vo.result2 = vo.input * vo.input;
}

@end

NS_ASSUME_NONNULL_END
