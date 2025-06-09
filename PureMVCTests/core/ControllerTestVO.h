//
//  ControllerTestVO.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef ControllerTestVO_h
#define ControllerTestVO_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
A utility class used by ControllerTest.

`@see org.puremvc.swift.multicore.core.controller.ControllerTest ControllerTest`

`@see org.puremvc.swift.multicore.core.controller.ControllerTestCommand ControllerTestCommand`
*/
@interface ControllerTestVO : NSObject

@property (nonatomic, assign, readonly) int input;
@property (nonatomic, assign) int result;

- (instancetype)initWithInput:(int)input;

@end

NS_ASSUME_NONNULL_END

#endif /* ControllerTestVO_h */
