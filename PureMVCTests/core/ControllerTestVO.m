//
//  ControllerTestVO.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "ControllerTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ControllerTestVO

/**
Constructor.

- parameter input: the number to be fed to the ControllerTestCommand
*/
- (instancetype)initWithInput:(int)input {
    if(self = [super init]) {
        _input = input;
    }
    return self;
}

@end

NS_ASSUME_NONNULL_END
