//
//  Controller.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Controller.h"
#import "ICommand.h"
#import "Observer.h"
#import "View.h"

NS_ASSUME_NONNULL_BEGIN

@interface Controller()

/// The Multiton Key for this app
@property (nonatomic, copy, readonly) NSString *multitonKey;

/// Mapping of Notification names to factories that instanties and returns `ICommand` Class instances
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<ICommand> (^)(void)> *commandMap;

/// Concurrent queue for commandMap
@property (nonatomic, strong) dispatch_queue_t commandMapQueue;

/// Local reference to View
@property (nonatomic, strong, nullable) id<IView> view;

@end

// The Multiton Controller instanceMap.
static NSMutableDictionary<NSString *, id<IController>> *instanceMap = nil;

/// Initializes the global `instanceMap` once per process.
__attribute__((constructor()))
static void initialize(void) {
    instanceMap = [NSMutableDictionary dictionary];
}

/**
A Multiton `IController` implementation.

In PureMVC, the `Controller` class follows the
'Command and Controller' strategy, and assumes these
responsibilities:

* Remembering which `ICommand`s are intended to handle which `INotifications`.
* Registering itself as an `IObserver` with the `View` for each `INotification` that it has an `ICommand` mapping for.
* Creating a new instance of the proper `ICommand` to handle a given `INotification` when notified by the `View`.
* Calling the `ICommand`'s `execute` method, passing in the `INotification`.

Your application must register `ICommands` with the
Controller.

The simplest way is to subclass `Facade`,
and use its `initializeController` method to add your
registrations.

`@see View`

`@see Observer`

`@see Notification`

`@see SimpleCommand`

`@see MacroCommand`
*/
@implementation Controller

/**
`Controller` Multiton Factory method.

- parameter key: multitonKey
- parameter factory: reference that returns `IController`
- returns: the Multiton instance
*/
+ (id<IController>)getInstance:(NSString *)key factory:(id<IController> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        // The Multiton Controller instanceMap.
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

/**
 Remove an IController instance

 - parameter key: of IController instance to remove
 */
+ (void)removeController:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

/**
 * Returns a new `Controller` instance for the given key.
 *
 * @param key The unique multiton key.
 * @return A new `Controller` instance.
 *
 * @note Raises an exception if an instance already exists for the key.
 */
+ (instancetype)withKey:(NSString *)key {
    return [[Controller alloc] initWithKey:key];
}

/**
Constructor.

This `IController` implementation is a Multiton,
so you should not call the constructor
directly, but instead call the static Factory method,
passing the unique key for this instance
`Controller.getInstance(multitonKey) { key in Controller(key: key) }`

@throws Error if instance for this Multiton key has already been constructed
*/
- (instancetype)initWithKey:(NSString *)key {
    if (instanceMap[key] != nil) {
        // Message constant
        [NSException raise:@"ControllerAlreadyExistsException" format:@"A Controller instance already exists for key '%@'.", key];
    }
    if (self = [super init]) {
        _multitonKey = [key copy];
        [instanceMap setObject:self forKey:key];
        _commandMap = [NSMutableDictionary dictionary];
        _commandMapQueue = dispatch_queue_create("org.puremvc.controller.proxyMapQueue", DISPATCH_QUEUE_CONCURRENT);
        [self initializeController];
    }
    return self;
}

/**
Initialize the Multiton `Controller` instance.

Called automatically by the constructor.

Note that if you are using a subclass of `View`
in your application, you should *also* subclass `Controller`
and override the `initializeController` method in the
following way:

    // ensure that the Controller is talking to my IView implementation
    - (void)initializeController {
        v[View getInstance:self.multitonKey factory:^(NSString *key){ return [View withKey:key]
    }
*/
- (void)initializeController {
    self.view = [View getInstance:self.multitonKey factory:^(NSString *key){ return [View withKey:key]; }];
}

/**
Register a particular `ICommand` class as the handler
for a particular `INotification`.

If an `ICommand` has already been registered to
handle `INotification`s with this name, it is no longer
used, the new `ICommand` is used instead.

The Observer for the new ICommand is only created if this the
first time an ICommand has been regisered for this Notification name.

- parameter notificationName: the name of the `INotification`
- parameter factory: reference that returns `ICommand`
*/
- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory {
    dispatch_barrier_sync(self.commandMapQueue, ^{
        if (self.commandMap[notificationName] == nil) { // weak reference to Controller (self) to avoid reference cycle with View and Observer
            id<IObserver> observer = [Observer withNotify:@selector(executeCommand:) context: self];
            [self.view registerObserver:notificationName observer:observer];
        }
        [self.commandMap setObject:factory forKey:notificationName];
    });
}

/**
If an `ICommand` has previously been registered
to handle a the given `INotification`, then it is executed.

- parameter notification: an `INotification`
*/
- (void)executeCommand:(id<INotification>)notification {
    __block id<ICommand> (^factory)(void) = nil;
    dispatch_sync(self.commandMapQueue, ^{
        factory = self.commandMap[notification.name];
    });
    if (factory == nil) return;
    id<ICommand> command = factory();
    // [command initializeNotifier:self.multitonKey];
    [command execute:notification];
}

/**
Check if a Command is registered for a given Notification

- parameter notificationName:
- returns: whether a Command is currently registered for the given `notificationName`.
*/
- (BOOL)hasCommand:(NSString *)notificationName {
    __block BOOL exists = NO;
    dispatch_sync(self.commandMapQueue, ^{
        exists = self.commandMap[notificationName] != nil;
    });
    return exists;
}

/**
Remove a previously registered `ICommand` to `INotification` mapping.

- parameter notificationName: the name of the `INotification` to remove the `ICommand` mapping for
*/
- (void)removeCommand:(NSString *)notificationName {
    dispatch_barrier_sync(self.commandMapQueue, ^{
        if (self.commandMap[notificationName] != nil) {
            [self.view removeObserver:notificationName context:self];
            [self.commandMap removeObjectForKey:notificationName];
        }
    });
}

@end

NS_ASSUME_NONNULL_END
