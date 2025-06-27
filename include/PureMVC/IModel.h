//
//  IModel.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef IModel_h
#define IModel_h

#import <Foundation/Foundation.h>
#import "IProxy.h"

NS_ASSUME_NONNULL_BEGIN

/**
The interface definition for a PureMVC Model.

In PureMVC, `IModel` implementors provide
access to `IProxy` objects by named lookup.

An `IModel` assumes these responsibilities:

* Maintain a cache of `IProxy` instances
* Provide methods for registering, retrieving, and removing `IProxy` instances
*/
@protocol IModel

/**
Register an `IProxy` instance with the `Model`.

- parameter proxy: an object reference to be held by the `Model`.
*/
- (void)registerProxy:(id<IProxy>)proxy;

/**
Retrieve an `IProxy` instance from the Model.

- parameter proxyName:
- returns: the `IProxy` instance previously registered with the given `proxyName`.
*/
- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName;

/**
Check if a Proxy is registered

- parameter proxyName:
- returns: whether a Proxy is currently registered with the given `proxyName`.
*/
- (BOOL)hasProxy:(NSString *)proxyName;

/**
Remove an `IProxy` instance from the Model.

- parameter proxyName: name of the `IProxy` instance to be removed.
- returns: the `IProxy` that was removed from the `Model`
*/
- (nullable id<IProxy>)removeProxy:(NSString *)proxyName;

@end

NS_ASSUME_NONNULL_END

#endif /* IModel_h */
