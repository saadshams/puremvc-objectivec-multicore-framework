//
//  View.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "IView.h"
#import "View.h"
#import "IObserver.h"
#import "Observer.h"
#import "IMediator.h"

NS_ASSUME_NONNULL_BEGIN

@interface View()

@property (nonatomic, copy, readonly) NSString *multitonKey;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<id<IObserver>> *> *observerMap;
@property (nonatomic, strong) dispatch_queue_t observerMapQueue;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<IMediator>> *mediatorMap;
@property (nonatomic, strong) dispatch_queue_t mediatorMapQueue;

@end

static NSMutableDictionary<NSString *, id<IView>> *instanceMap = nil;

__attribute__((constructor()))
static void initialize(void) {
    instanceMap = [NSMutableDictionary dictionary];
}

@implementation View

+ (id<IView>)getInstance:(NSString *)key factory:(id<IView> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

+ (void)removeView:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

+ (instancetype)withKey:(NSString *)key {
    return [[View alloc] initWithKey:key];
}

- (instancetype)initWithKey:(NSString *)key {
    if (instanceMap[key] != nil) {
        [NSException raise:@"ViewAlreadyExistsException" format:@"A View instance already exists for key '%@'.", key];
    }
    if (self = [super init]) {
        _multitonKey = [key copy];
        [instanceMap setObject:self forKey:key];
        _mediatorMap = [NSMutableDictionary dictionary];
        _mediatorMapQueue = dispatch_queue_create("org.puremvc.view.mediatorMapQueue", DISPATCH_QUEUE_CONCURRENT);
        _observerMap = [NSMutableDictionary dictionary];
        _observerMapQueue = dispatch_queue_create("org.puremvc.view.observerMapQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer {
    dispatch_barrier_sync(self.observerMapQueue, ^{
        if (self.observerMap[notificationName] != nil) {
            [self.observerMap[notificationName] addObject:observer];
        } else {
            self.observerMap[notificationName] = [NSMutableArray arrayWithObject:observer];
        }
    });
}

- (void)notifyObservers:(id<INotification>)notification {
    __block NSArray<id<IObserver>> *observers = nil;
    dispatch_sync(self.observerMapQueue, ^{
        // Iteration Safe, the original array may change during the notification loop but irrespective of that all observers will be notified
        observers = [self.observerMap[notification.name] copy];
    });
    
    for (id<IObserver> observer in observers) {
        [observer notifyObserver:notification];
    }
}

- (void)removeObserver:(NSString *)notificationName context:(id)context {
    dispatch_barrier_sync(self.observerMapQueue, ^{
        NSMutableArray<id<IObserver>> *observers = self.observerMap[notificationName];
        
        for (id<IObserver> observer in observers) {
            if ([observer compareNotifyContext:context]) {
                [observers removeObject:observer];
                break;
            }
        }
        if ([observers count] == 0) {
            [self.observerMap removeObjectForKey:notificationName];
        }
    });
}

- (void)registerMediator:(id<IMediator>)mediator {
    __block BOOL exists = NO;
    dispatch_barrier_sync(self.mediatorMapQueue, ^{
        exists = self.mediatorMap[mediator.name] != nil;
        if (!exists)
            self.mediatorMap[mediator.name] = mediator;
    });
    
    if (exists) return;
    
    // [mediator initializeNotifier:multitonKey];
    
    id<IObserver> observer = [Observer withNotify:@selector(handleNotification:) context:mediator];
    
    NSArray *interests = [mediator listNotificationInterests];
    for (NSString *notificationName in interests) {
        [self registerObserver:notificationName observer:observer];
    }
    
    [mediator onRegister];
}

- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName {
    __block id<IMediator> mediator = nil;
    dispatch_sync(self.mediatorMapQueue, ^{
        mediator = self.mediatorMap[mediatorName];
    });
    return mediator;
}

- (BOOL)hasMediator:(NSString *)mediatorName {
    __block BOOL exists = NO;
    dispatch_sync(self.mediatorMapQueue, ^{
        exists = self.mediatorMap[mediatorName] != nil;
    });
    return exists;
}

- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName {
    __block id<IMediator> mediator = nil;
    dispatch_barrier_sync(self.mediatorMapQueue, ^{
        mediator = self.mediatorMap[mediatorName];
        [self.mediatorMap removeObjectForKey:mediatorName];
    });
    
    if (mediator == nil) return nil;
    
    NSArray *interests = [mediator listNotificationInterests];
    for (NSString *notificationName in interests) {
        [self removeObserver:notificationName context:mediator];
    }
    
    [mediator onRemove];
    return mediator;
}

@end

NS_ASSUME_NONNULL_END
