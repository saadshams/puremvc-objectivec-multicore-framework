//
//  Notifier.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef Notifier_h
#define Notifier_h

#import <Foundation/Foundation.h>
#import "INotifier.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IFacade;

@interface Notifier : NSObject <INotifier>
    
@property (nonatomic, weak) id<IFacade>facade;

@end

NS_ASSUME_NONNULL_END

#endif /* Notifier_h */
