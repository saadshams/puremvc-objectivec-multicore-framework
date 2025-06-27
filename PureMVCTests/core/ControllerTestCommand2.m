//
//  ControllerTestCommand2.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ControllerTestCommand2.h"
#import "ControllerTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ControllerTestCommand2
/**
Fabricate a result by multiplying the input by 2 and adding to the existing result

This tests accumulation effect that would show if the command were executed more than once.

- parameter note: the note carrying the ControllerTestVO
*/
- (void)execute:(id<INotification>)notification {
    ControllerTestVO *vo = notification.body;
    
    // Fabricate a result
    vo.result = vo.result + (2 * vo.input);
}

@end

NS_ASSUME_NONNULL_END
