//
//  View.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef View_h
#define View_h

#import <Foundation/Foundation.h>
#import "IView.h"

NS_ASSUME_NONNULL_BEGIN

@interface View : NSObject <IView>

+ (id<IView>) getInstance:(NSString *)key factory:(id<IView> (^)(NSString *key))factory;
+ (void)removeView:(NSString *)key;
+ (instancetype) withKey:(NSString *)key;

- (instancetype) initWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END

#endif /* View_h */
