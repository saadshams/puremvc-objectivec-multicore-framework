//
//  FacadeTestVO.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FacadeTestVO : NSObject

@property (nonatomic, assign, readonly) int input;
@property (nonatomic, assign) int result;

- (instancetype)initWithInput:(int)input;

@end

NS_ASSUME_NONNULL_END
