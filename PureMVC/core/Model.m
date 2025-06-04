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

@implementation Model

+ (id<IModel>)getInstance:(NSString *)key factory:(id<IModel> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

+ (void)removeModel:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

+ (instancetype)withKey:(NSString *)key {
    return [[Model alloc] initWithKey:key];
}

- (instancetype)initWithKey:(NSString *)key {
    if (instanceMap[key] != nil) {
        [NSException raise:@"ModelAlreadyExistsException" format:@"A Model instance already exists for key '%@'.", key];
    }
    if (self = [super init]) {
        _multitonKey = [key copy];
        [instanceMap setObject:self forKey:key];
        _proxyMap = [NSMutableDictionary dictionary];
        _proxyMapQueue = dispatch_queue_create("org.puremvc.model.proxyMapQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)registerProxy:(id<IProxy>)proxy {
    // [proxy initializeNotifier(multitonKey)]
    dispatch_barrier_sync(self.proxyMapQueue, ^{
        self.proxyMap[[proxy name]] = proxy;
    });
    [proxy onRegister];
}

- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName {
    __block id<IProxy> proxy = nil;
    dispatch_sync(self.proxyMapQueue, ^{
        proxy = self.proxyMap[proxyName];
    });
    return proxy;
}

- (BOOL)hasProxy:(NSString *)proxyName {
    __block BOOL exists = NO;
    dispatch_sync(self.proxyMapQueue, ^{
         exists = self.proxyMap[proxyName] != nil;
    });
    return exists;
}

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
