//
//  FacadeTestCommand.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef FacadeTestCommand_h
#define FacadeTestCommand_h

#import <Foundation/Foundation.h>
#import "SimpleCommand.h"

NS_ASSUME_NONNULL_BEGIN

/**
A SimpleCommand subclass used by FacadeTest.

`@see org.puremvc.swift.multicore.patterns.facade.FacadeTest FacadeTest`

`@see org.puremvc.swift.multicore.patterns.facade.FacadeTestVO FacadeTestVO`
*/
@interface FacadeTestCommand : SimpleCommand

@end

NS_ASSUME_NONNULL_END

#endif /* FacadeTestCommand_h */
