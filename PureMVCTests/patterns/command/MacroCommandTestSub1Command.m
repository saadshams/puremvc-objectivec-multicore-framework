//
//  MacroCommandTestSub1Command.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "MacroCommandTestSub1Command.h"
#import "MacroCommandTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation MacroCommandTestSub1Command

/**
Fabricate a result by multiplying the input by 2

- parameter event: the `IEvent` carrying the `MacroCommandTestVO`
*/
- (void)execute:(id<INotification>)notification {
    MacroCommandTestVO *vo = [notification body];
    
    // Fabricate a result
    vo.result1 = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
