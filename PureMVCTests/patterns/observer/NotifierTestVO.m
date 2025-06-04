//
//  NotifierTestVO.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "NotifierTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NotifierTestVO

- (instancetype)initWithInput:(int)input {
    if (self = [super init]) {
        _input = input;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
