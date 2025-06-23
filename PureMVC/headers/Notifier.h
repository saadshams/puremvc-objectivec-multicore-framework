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


@protocol IFacade; // forward reference

/**
 A base class that provides an implementation of the `INotifier` protocol.

 `Notifier` is designed to be extended by other classes (e.g., `Command`, `Mediator`, `Proxy`)
 that need to send `INotification`s via the `Facade`.

 It provides a reference to the `IFacade` instance associated with its `multitonKey`.

 Subclasses must call `initializeNotifier:` with the proper key before using `sendNotification`.
 */
@interface Notifier : NSObject <INotifier>

/// The Multiton `Facade` through which notifications are sent.
@property (nonatomic, weak) id<IFacade>facade;

@end

NS_ASSUME_NONNULL_END

#endif /* Notifier_h */
