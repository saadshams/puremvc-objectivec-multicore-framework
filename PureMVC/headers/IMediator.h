//
//  IMediator.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IMediator_h
#define IMediator_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol IMediator

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id view;

- (void)onRegister;

- (void)onRemove;

@end

NS_ASSUME_NONNULL_END

#endif /* IMediator_h */
