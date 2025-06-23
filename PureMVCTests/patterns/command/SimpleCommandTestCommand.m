//
//  SimpleCommandTestCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "SimpleCommandTestCommand.h"
#import "SimpleCommandTestVO.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SimpleCommandTestCommand

/**
Fabricate a result by multiplying the input by 2

- parameter event: the `INotification` carrying the `SimpleCommandTestVO`
*/
- (void)execute:(id<INotification>)notification {
    SimpleCommandTestVO *vo = [notification body];
    
    //Fabricate a result
    vo.result = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
