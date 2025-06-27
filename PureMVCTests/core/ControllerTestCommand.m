//
//  ControllerTestCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ControllerTestCommand.h"
#import "ControllerTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ControllerTestCommand

/**
Fabricate a result by multiplying the input by 2

- parameter note: the note carrying the ControllerTestVO
*/
- (void)execute:(id<INotification>)notification {
    ControllerTestVO *vo = notification.body;
    
    // Fabricate a result
    vo.result = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
