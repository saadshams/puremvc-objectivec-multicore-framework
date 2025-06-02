//
//  Observer.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Observer_h
#define Observer_h

#import <Foundation/Foundation.h>
#import "IObserver.h"
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface Observer : NSObject <IObserver>

@property (nonatomic) SEL notify;
@property (nonatomic, weak) id context;

+ (instancetype)withNotify:(nullable SEL)notify context:(nullable id)context;

- (instancetype)initWithNotify:(nullable SEL)notify context:(nullable id)context;

@end

NS_ASSUME_NONNULL_END

#endif /* Observer_h */
