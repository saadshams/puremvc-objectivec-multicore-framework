//
//  FacadeTestCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "FacadeTestCommand.h"
#import "INotification.h"
#import "FacadeTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation FacadeTestCommand

- (void)execute:(id<INotification>)notification {
    FacadeTestVO *vo = notification.body;
    
    vo.result = 2 * vo.input;
}

@end

NS_ASSUME_NONNULL_END
