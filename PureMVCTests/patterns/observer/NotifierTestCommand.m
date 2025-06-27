//
//  NotifierTestCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "NotifierTestCommand.h"
#import "NotifierTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NotifierTestCommand

- (void)execute:(id<INotification>)notification {
    NotifierTestVO *vo = notification.body;
    
    vo.result = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
