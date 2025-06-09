//
//  FacadeTestVO.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef FacadeTestVO_h
#define FacadeTestVO_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
A utility class used by FacadeTest.

`@see org.puremvc.swift.multicore.patterns.facade.FacadeTest FacadeTest`

`@see org.puremvc.swift.multicore.patterns.facade.FacadeTestCommand FacadeTestCommand`
*/
@interface FacadeTestVO : NSObject

@property (nonatomic, assign, readonly) int input;
@property (nonatomic, assign) int result;

- (instancetype)initWithInput:(int)input;

@end

NS_ASSUME_NONNULL_END

#endif /* FacadeTestVO_h */
