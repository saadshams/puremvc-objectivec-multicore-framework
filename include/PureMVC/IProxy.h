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

/**
The interface definition for a PureMVC Proxy.

In PureMVC, `IProxy` implementors assume these responsibilities:

* Implement a common method which returns the name of the Proxy.
* Provide methods for setting and getting the data object.

Additionally, `IProxy`s typically:

* Maintain references to one or more pieces of model data.
* Provide methods for manipulating that data.
* Generate `INotifications` when their model data changes.
* Expose their name as a `public static const` called `NAME`, if they are not instantiated multiple times.
* Encapsulate interaction with local or remote services used to fetch and persist model data.
*/
@protocol IProxy <INotifier>

/// Get the Proxy name
@property (nonatomic, copy, readonly) NSString *name;

/// Get or set the data object
@property (nonatomic, strong, nullable) id data;

/// Called by the Model when the Proxy is registered
- (void)onRegister;

/// Called by the Model when the Proxy is removed
- (void)onRemove;

@end

NS_ASSUME_NONNULL_END

#endif /* IProxy_h */
