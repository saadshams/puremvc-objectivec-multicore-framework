//
//  ControllerTestCommand2.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ControllerTestCommand2.h"
#import "INotification.h"
#import "ControllerTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ControllerTestCommand2

- (void)execute:(id<INotification>)notification {
    ControllerTestVO *vo = notification.body;
    
    vo.result = vo.result + (2 * vo.input);
}

@end

NS_ASSUME_NONNULL_END
