//
//  IProxy.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IProxy_h
#define IProxy_h

#import <Foundation/Foundation.h>
#import "INotifier.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IProxy <INotifier>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id data;

- (void)onRegister;

- (void)onRemove;

@end

NS_ASSUME_NONNULL_END

#endif /* IProxy_h */
