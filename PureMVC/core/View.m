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

/**
A Multiton `IView` implementation.

In PureMVC, the `View` class assumes these responsibilities:

* Maintain a cache of `IMediator` instances.
* Provide methods for registering, retrieving, and removing `IMediators`.
* Notifiying `IMediators` when they are registered or removed.
* Managing the observer lists for each `INotification` in the application.
* Providing a method for attaching `IObservers` to an `INotification`'s observer list.
* Providing a method for broadcasting an `INotification`.
* Notifying the `IObservers` of a given `INotification` when it broadcast.

`@see org.puremvc.swift.multicore.patterns.mediator.Mediator Mediator`

`@see org.puremvc.swift.multicore.patterns.observer.Observer Observer`

`@see org.puremvc.swift.multicore.patterns.observer.Notification Notification`
*/
@implementation View

/**
View Multiton Factory method.

- parameter key: multitonKey
- parameter factory: reference that returns `IView`
- returns: the Multiton instance returned by executing the passed closure
*/
+ (id<IView>)getInstance:(NSString *)key factory:(id<IView> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

/**
Remove an IView instance

- parameter key: of IView instance to remove
*/
+ (void)removeView:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

+ (instancetype)withKey:(NSString *)key {
    return [[View alloc] initWithKey:key];
}

/**
Constructor.

This `IView` implementation is a Multiton,
so you should not call the constructor
directly, but instead call the static Multiton
Factory method `View.getInstance( multitonKey )`

- parameter key: multitonKey

@throws Error if instance for this Multiton key has already been constructed
*/
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

/**
Register an `IObserver` to be notified
of `INotifications` with a given name.

- parameter notificationName: the name of the `INotifications` to notify this `IObserver` of
- parameter observer: the `IObserver` to register
*/
- (void)registerObserver:(NSString *)notificationName observer:(id<IObserver>)observer {
    dispatch_barrier_sync(self.observerMapQueue, ^{
        if (self.observerMap[notificationName] != nil) {
            [self.observerMap[notificationName] addObject:observer];
        } else {
            self.observerMap[notificationName] = [NSMutableArray arrayWithObject:observer];
        }
    });
}

/**
Notify the `IObservers` for a particular `INotification`.

All previously attached `IObservers` for this `INotification`'s
list are notified and are passed a reference to the `INotification` in
the order in which they were registered.

- parameter notification: the `INotification` to notify `IObservers` of.
*/
- (void)notifyObservers:(id<INotification>)notification {
    __block NSArray<id<IObserver>> *observers = nil;
    dispatch_sync(self.observerMapQueue, ^{
        // Iteration Safe, the original array may change during the notification loop but irrespective of that all observers will be notified
        observers = [self.observerMap[notification.name] copy];
    });
    
    // Notify Observers
    for (id<IObserver> observer in observers) {
        [observer notifyObserver:notification];
    }
}

/**
Remove the observer for a given notifyContext from an observer list for a given Notification name.

- parameter notificationName: which observer list to remove from
- parameter notifyContext: remove the observer with this object as its notifyContext
*/
- (void)removeObserver:(NSString *)notificationName context:(id)context {
    dispatch_barrier_sync(self.observerMapQueue, ^{
        // the observer list for the notification under inspection
        NSMutableArray<id<IObserver>> *observers = self.observerMap[notificationName];
        
        // find the observer for the notifyContext
        for (id<IObserver> observer in observers) {
            if ([observer compareNotifyContext:context]) {
                // there can only be one Observer for a given notifyContext
                // in any given Observer list, so remove it and break
                [observers removeObject:observer];
                break;
            }
        }
        
        // Also, when a Notification's Observer list length falls to
        // zero, delete the notification key from the observer map
        if ([observers count] == 0) {
            [self.observerMap removeObjectForKey:notificationName];
        }
    });
}

/**
Register an `IMediator` instance with the `View`.

Registers the `IMediator` so that it can be retrieved by name,
and further interrogates the `IMediator` for its
`INotification` interests.

If the `IMediator` returns any `INotification`
names to be notified about, an `Observer` is created encapsulating
the `IMediator` instance's `handleNotification` method
and registering it as an `Observer` for all `INotifications` the
`IMediator` is interested in.

- parameter mediator: a reference to the `IMediator` instance
*/
- (void)registerMediator:(id<IMediator>)mediator {
    __block BOOL exists = NO;
    dispatch_barrier_sync(self.mediatorMapQueue, ^{
        // do not allow re-registration (you must to removeMediator fist)
        exists = self.mediatorMap[mediator.name] != nil;
        if (!exists)
            // Register the Mediator for retrieval by name
            self.mediatorMap[mediator.name] = mediator;
    });
    
    if (exists) return;
    
    // [mediator initializeNotifier:multitonKey];
    
    // Create Observer referencing this mediator's handleNotification method
    id<IObserver> observer = [Observer withNotify:@selector(handleNotification:) context:mediator];
    
    NSArray *interests = [mediator listNotificationInterests];
    // Register Mediator as an observer for each notification of interests
    for (NSString *notificationName in interests) {
        [self registerObserver:notificationName observer:observer];
    }
    
    // alert the mediator that it has been registered
    [mediator onRegister];
}

/**
Retrieve an `IMediator` from the `View`.

- parameter mediatorName: the name of the `IMediator` instance to retrieve.
- returns: the `IMediator` instance previously registered with the given `mediatorName`.
*/
- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName {
    __block id<IMediator> mediator = nil;
    dispatch_sync(self.mediatorMapQueue, ^{
        mediator = self.mediatorMap[mediatorName];
    });
    return mediator;
}

/**
Check if a Mediator is registered or not

- parameter mediatorName:
- returns: whether a Mediator is registered with the given `mediatorName`.
*/
- (BOOL)hasMediator:(NSString *)mediatorName {
    __block BOOL exists = NO;
    dispatch_sync(self.mediatorMapQueue, ^{
        exists = self.mediatorMap[mediatorName] != nil;
    });
    return exists;
}

/**
Remove an `IMediator` from the `View`.

- parameter mediatorName: name of the `IMediator` instance to be removed.
- returns: the `IMediator` that was removed from the `View`
*/
- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName {
    __block id<IMediator> mediator = nil;
    dispatch_barrier_sync(self.mediatorMapQueue, ^{
        // remove the mediator from the map
        mediator = self.mediatorMap[mediatorName];
        [self.mediatorMap removeObjectForKey:mediatorName];
    });
    
    if (mediator == nil) return nil;
    
    // for every notification this mediator is interested in...
    NSArray *interests = [mediator listNotificationInterests];
    for (NSString *notificationName in interests) {
        // remove the observer linking the mediator
        // to the notification interest
        [self removeObserver:notificationName context:mediator];
    }
    
    // alert the mediator that it has been removed
    [mediator onRemove];
    return mediator;
}

@end

NS_ASSUME_NONNULL_END
