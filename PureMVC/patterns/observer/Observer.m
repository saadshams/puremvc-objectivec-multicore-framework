//
//  Observer.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Observer.h"

NS_ASSUME_NONNULL_BEGIN

@implementation Observer

// Static Convienence Constructor
+ (instancetype)withNotify:(nullable SEL)notify context:(nullable id)context {
    return [[self alloc] initWithNotify:notify context:context];
}

- (instancetype)initWithNotify:(nullable SEL)notify context:(nullable id)context {
    if (self = [super init]) {
        _notify = notify;
        _context = context;
    }
    return self;
}

- (void)notifyObserver:(id<INotification>)notification {
    if (self.notify && [self.context respondsToSelector:self.notify]) {
        // Suppress "performSelector may cause leak" warning
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.context performSelector:self.notify withObject:notification];
        #pragma clang diagnostic pop
    }
}

- (BOOL)compareNotifyContext:(id)object {
    return object == self.context;
}

@end

NS_ASSUME_NONNULL_END
