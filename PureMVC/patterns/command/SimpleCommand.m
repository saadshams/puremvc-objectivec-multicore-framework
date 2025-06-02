//
//  SimpleCommand.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "SimpleCommand.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SimpleCommand

+ (instancetype)command {
    return [[self alloc] init];
}

- (void)execute:(id<INotification>)notification {
    
}

@end

NS_ASSUME_NONNULL_END
