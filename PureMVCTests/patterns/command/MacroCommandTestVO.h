//
//  MacroCommandTestVO.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef MacroCommandTestVO_h
#define MacroCommandTestVO_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MacroCommandTestVO : NSObject

@property (nonatomic, assign, readonly) int input;
@property (nonatomic, assign) int result1;
@property (nonatomic, assign) int result2;

- (instancetype)initWithInput:(int)input;

@end

NS_ASSUME_NONNULL_END

#endif /* MacroCommandTestVO_h */
