//
//  FacadeTestCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "FacadeTestCommand.h"
#import "FacadeTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FacadeTestCommand

/**
Fabricate a result by multiplying the input by 2

- parameter note: the Notification carrying the FacadeTestVO
*/
- (void)execute:(id<INotification>)notification {
    FacadeTestVO *vo = notification.body;
    
    // Fabricate a result
    vo.result = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
