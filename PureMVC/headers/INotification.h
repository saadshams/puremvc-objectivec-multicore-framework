//
//  INotification.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef INotification_h
#define INotification_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol INotification

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong, nullable) id body;
@property (nonatomic, copy, nullable) NSString *type;

- (NSString *)description;

@end

NS_ASSUME_NONNULL_END

#endif /* INotification_h */
