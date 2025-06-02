//
//  Notification.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Notification_h
#define Notification_h

#import <Foundation/Foundation.h>
#import "INotification.h"

NS_ASSUME_NONNULL_BEGIN

@interface Notification : NSObject <INotification>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id body;
@property (nonatomic, copy, nullable) NSString *type;

+ (instancetype)withName:(NSString *)name;
+ (instancetype)withName:(NSString *)name body:(id)body;
+ (instancetype)withName:(NSString *)name body:(id)body type:(NSString *)type;

- (instancetype)initWithName:(NSString *)name body:(nullable id)body type:(nullable NSString *)type;
- (NSString *)description;

@end

NS_ASSUME_NONNULL_END

#endif /* Notification_h */
