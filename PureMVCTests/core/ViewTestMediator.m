//
//  ViewTestMediator.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "ViewTestMediator.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ViewTestMediator

/**
The Mediator name
*/
+ (NSString *)NAME { return @"ViewTestMediator"; }

- (NSArray<NSString *> *)listNotificationInterests {
    // Be sure that the mediator has some Observers created
    // in order to test removeMediator
    return @[@"ABC", @"DEF", @"GHI"];
}

@end

NS_ASSUME_NONNULL_END
