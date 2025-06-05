//
//  ControllerTestCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef ControllerTestCommand_h
#define ControllerTestCommand_h

#import <Foundation/Foundation.h>
#import "SimpleCommand.h"

NS_ASSUME_NONNULL_BEGIN

/**
A SimpleCommand subclass used by ControllerTest.

`@see org.puremvc.swift.multicore.core.controller.ControllerTest ControllerTest`

`@see org.puremvc.swift.multicore.core.controller.ControllerTestVO ControllerTestVO`
*/
@interface ControllerTestCommand : SimpleCommand

@end

NS_ASSUME_NONNULL_END

#endif /* ControllerTestCommand_h */
