//
//  MacroCommandTestSub1Command.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "MacroCommandTestSub1Command.h"
#import "INotification.h"
#import "MacroCommandTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MacroCommandTestSub1Command

- (void)execute:(id<INotification>)notification {
    MacroCommandTestVO *vo = [notification body];
    vo.result1 = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
