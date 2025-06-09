//
//  Model.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Model()

@property (nonatomic, copy, readonly) NSString *multitonKey;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<IProxy>> *proxyMap;
@property (nonatomic, strong) dispatch_queue_t proxyMapQueue;

@end

static NSMutableDictionary<NSString *, id<IModel>> *instanceMap = nil;

__attribute__((constructor))
static void initialize(void) {
    instanceMap = [NSMutableDictionary dictionary];
}

/**
A Multiton `IModel` implementation.

In PureMVC, the `Model` class provides
access to model objects (Proxies) by named lookup.

The `Model` assumes these responsibilities:

* Maintain a cache of `IProxy` instances.
* Provide methods for registering, retrieving, and removing `IProxy` instances.

Your application must register `IProxy` instances
with the `Model`. Typically, you use an
`ICommand` to create and register `IProxy`
instances once the `Facade` has initialized the Core
actors.

`@see org.puremvc.swift.multicore.patterns.proxy.Proxy Proxy`

`@see org.puremvc.swift.multicore.interfaces.IProxy IProxy`
*/
@implementation Model

/**
`Model` Multiton Factory method.

- parameter key: multitonKey
- parameter factory: reference that returns `IModel`
- returns: the instance returned by the passed closure
*/
+ (id<IModel>)getInstance:(NSString *)key factory:(id<IModel> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

/**
Remove an IModel instance

- parameter key: of IModel instance to remove
*/
+ (void)removeModel:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

+ (instancetype)withKey:(NSString *)key {
    return [[Model alloc] initWithKey:key];
}

/**
Constructor.

This `IModel` implementation is a Multiton,
so you should not call the constructor
directly, but instead call the static Multiton
Factory method `Model.getInstance( multitonKey )`

- parameter key: multitonKey

@throws Error if instance for this Multiton key instance has already been constructed
*/
- (instancetype)initWithKey:(NSString *)key {
    // The Multiton Model instanceMap
    if (instanceMap[key] != nil) {
        // Message constant
        [NSException raise:@"ModelAlreadyExistsException" format:@"A Model instance already exists for key '%@'.", key];
    }
    if (self = [super init]) {
        _multitonKey = [key copy];
        [instanceMap setObject:self forKey:key];
        
        // Mapping of proxyNames to IProxy instances
        _proxyMap = [NSMutableDictionary dictionary];
        
        // Concurrent queue for proxyMap
        // for speed and convenience of running concurrently while reading, and thread safety of blocking while mutating
        _proxyMapQueue = dispatch_queue_create("org.puremvc.model.proxyMapQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

/**
Register an `IProxy` with the `Model`.

- parameter proxy: an `IProxy` to be held by the `Model`.
*/
- (void)registerProxy:(id<IProxy>)proxy {
    // [proxy initializeNotifier(multitonKey)]
    dispatch_barrier_sync(self.proxyMapQueue, ^{
        self.proxyMap[[proxy name]] = proxy;
    });
    [proxy onRegister];
}

/**
Retrieve an `IProxy` from the `Model`.

- parameter proxyName:
- returns: the `IProxy` instance previously registered with the given `proxyName`.
*/
- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName {
    __block id<IProxy> proxy = nil;
    dispatch_sync(self.proxyMapQueue, ^{
        proxy = self.proxyMap[proxyName];
    });
    return proxy;
}

/**
Check if a Proxy is registered

- parameter proxyName:
- returns: whether a Proxy is currently registered with the given `proxyName`.
*/
- (BOOL)hasProxy:(NSString *)proxyName {
    __block BOOL exists = NO;
    dispatch_sync(self.proxyMapQueue, ^{
         exists = self.proxyMap[proxyName] != nil;
    });
    return exists;
}

/**
Remove an `IProxy` from the `Model`.

- parameter proxyName: name of the `IProxy` instance to be removed.
- returns: the `IProxy` that was removed from the `Model`
*/
- (nullable id<IProxy>)removeProxy:(NSString *)proxyName {
    __block id<IProxy> proxy = nil;
    dispatch_barrier_sync(self.proxyMapQueue, ^{
        proxy = self.proxyMap[proxyName];
        self.proxyMap[proxyName] = nil;
    });
    
    [proxy onRemove];
    return proxy;
}

@end

NS_ASSUME_NONNULL_END
