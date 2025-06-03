//
//  ViewTestVO.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "ViewTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewTestVO : NSObject

@property (nonatomic, copy, nullable) NSString *lastNotification;
@property (nonatomic, assign) BOOL onRegisterCalled;
@property (nonatomic, assign) BOOL onRemoveCalled;
@property (nonatomic, assign) int counter;

@end

NS_ASSUME_NONNULL_END
