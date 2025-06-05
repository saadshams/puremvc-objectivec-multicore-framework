//
//  Controller.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "IController.h"
#import "Controller.h"
#import "ICommand.h"
#import "IObserver.h"
#import "Observer.h"
#import "IView.h"
#import "View.h"

NS_ASSUME_NONNULL_BEGIN

@interface Controller()

/// The Multiton Key for this app
@property (nonatomic, copy, readonly) NSString *multitonKey;

@property (nonatomic, strong) NSMutableDictionary<NSString *, id<ICommand> (^)(void)> *commandMap;
@property (nonatomic, strong) dispatch_queue_t commandMapQueue;

/// Local reference to View
@property (nonatomic, strong, nullable) id<IView> view;

@end

static NSMutableDictionary<NSString *, id<IController>> *instanceMap = nil;

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

`@see org.puremvc.swift.multicore.core.View View`

`@see org.puremvc.swift.multicore.patterns.observer.Observer Observer`

`@see org.puremvc.swift.multicore.patterns.observer.Notification Notification`

`@see org.puremvc.swift.multicore.patterns.command.SimpleCommand SimpleCommand`

`@see org.puremvc.swift.multicore.patterns.command.MacroCommand MacroCommand`
*/
@implementation Controller

+ (id<IController>)getInstance:(NSString *)key factory:(id<IController> (^)(NSString *key))factory {
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
    return [[Controller alloc] initWithKey:key];
}

- (instancetype)initWithKey:(NSString *)key {
    if (instanceMap[key] != nil) {
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

- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory {
    dispatch_barrier_sync(self.commandMapQueue, ^{
        if (self.commandMap[notificationName] == nil) {
            id<IObserver> observer = [Observer withNotify:@selector(executeCommand:) context: self];
            [self.view registerObserver:notificationName observer:observer];
        }
        [self.commandMap setObject:factory forKey:notificationName];
    });
}

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

- (BOOL)hasCommand:(NSString *)notificationName {
    __block BOOL exists = NO;
    dispatch_sync(self.commandMapQueue, ^{
        exists = self.commandMap[notificationName] != nil;
    });
    return exists;
}

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
