//
//  Facade.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <Foundation/Foundation.h>
#import "Facade.h"
#import "Controller.h"
#import "Model.h"
#import "View.h"
#import "Notification.h"

NS_ASSUME_NONNULL_BEGIN

@interface Facade()

/// The unique Multiton key for this Facade instance.
@property (nonatomic, copy, readonly) NSString *multitonKey;

/// Reference to the Controller instance for this Facade.
@property (nonatomic, strong, nullable) id<IController> controller;

/// Reference to the Model instance for this Facade.
@property (nonatomic, strong, nullable) id<IModel> model;

/// Reference to the View instance for this Facade.
@property (nonatomic, strong, nullable) id<IView> view;

@end

// Static dictionary storing all Facade instances keyed by multitonKey.
static NSMutableDictionary<NSString *, id<IFacade>> *instanceMap = nil;

// Automatically invoked when the module loads.
// Initializes the static instanceMap dictionary.
__attribute__((constructor()))
static void initialize(void) {
    instanceMap = [NSMutableDictionary dictionary];
}

/**
A base Multiton `IFacade` implementation.

`@see org.puremvc.swift.multicore.core.Model Model`

`@see org.puremvc.swift.multicore.core.View View`

`@see org.puremvc.swift.multicore.core.Controller Controller`
*/
@implementation Facade

/**
Facade Multiton Factory method

- parameter key: multitonKey
- parameter factory: reference that returns `IFacade`
- returns: the Multiton instance of the `IFacade`
*/
+ (id<IFacade>)getInstance:(NSString *)key factory:(id<IFacade> (^)(NSString *key))factory {
    @synchronized (instanceMap) {
        if (instanceMap[key] == nil) {
            instanceMap[key] = factory(key);
        }
        return instanceMap[key];
    }
}

/**
Check if a Core is registered or not

- parameter key: the multiton key for the Core in question
- returns: whether a Core is registered with the given `key`.
*/
+ (BOOL)hasCore:(NSString *)key {
    @synchronized (instanceMap) {
        return instanceMap[key] != nil;
    }
}

/**
Remove a Core.

Remove the Model, View, Controller and Facade
instances for the given key.

- parameter key: multitonKey of the Core to remove
*/
+ (void)removeCore:(NSString *)key {
    @synchronized (instanceMap) {
        [instanceMap removeObjectForKey:key];
    }
}

/**
 * Creates and returns a new `Facade` instance for the given multiton key.
 *
 * This is a convenience constructor that calls `-initWithKey:` internally.
 *
 * @param key The unique multiton key identifying the `Facade` instance.
 * @return A new instance of `Facade` initialized with the given key.
 */
+ (instancetype)withKey:(NSString *)key {
    return [[Facade alloc] initWithKey:key];
}

/**
Constructor.

This `IFacade` implementation is a Multiton,
so you should not call the constructor
directly, but instead call the static Factory method,
passing the unique key for this instance and the factory closure
that returns the `IFacade` implementation.
`Facade.getInstance( multitonKey ) { Facade(key: multitonKey) }`

@throws Error Error if instance for this Multiton key has already been constructed
*/
- (instancetype)initWithKey:(NSString *)key {
    if (instanceMap[key] != nil) {
        [NSException raise:@"FacadeAlreadyExistsException" format:@"A Facade instance already exists for key '%@'.", key];
    }
    if (self = [super init]) {
        [self initializeNotifier:key];
        [instanceMap setObject:self forKey:key];
        [self initializeFacade];
    }
    return self;
}

/**
Initialize the Multiton `Facade` instance.

Called automatically by the constructor. Override in your
subclass to do any subclass specific initializations. Be
sure to call `super.initializeFacade()`, though.
*/
- (void)initializeFacade {
    [self initializeModel];
    [self initializeController];
    [self initializeView];
}

/**
Initialize the `Controller`.

Called by the `initializeFacade` method.
Override this method in your subclass of `Facade`
if one or both of the following are true:

* You wish to initialize a different `IController`.
* You have `Commands` to register with the `Controller` at startup.`.

If you don't want to initialize a different `IController`,
call `super.initializeController()` at the beginning of your
method, then register `Command`s.
*/
- (void)initializeController {
    self.controller = [Controller getInstance:self.multitonKey factory:^(NSString *key){ return [Controller withKey:key]; }];
}

/**
Initialize the `Model`.

Called by the `initializeFacade` method.
Override this method in your subclass of `Facade`
if one or both of the following are true:

* You wish to initialize a different `IModel`.
* You have `Proxy`s to register with the Model that do not retrieve a reference to the Facade at construction time.`

If you don't want to initialize a different `IModel`,
call `super.initializeModel()` at the beginning of your
method, then register `Proxy`s.

Note: This method is *rarely* overridden; in practice you are more
likely to use a `Command` to create and register `Proxy`s
with the `Model`, since `Proxy`s with mutable data will likely
need to send `INotification`s and thus will likely want to fetch a reference to
the `Facade` during their construction.
*/
- (void)initializeModel {
    self.model = [Model getInstance:self.multitonKey factory:^(NSString *key) { return [Model withKey:key]; }];
}

/**
Initialize the `View`.

Called by the `initializeFacade` method.
Override this method in your subclass of `Facade`
if one or both of the following are true:

* You wish to initialize a different `IView`.
* You have `Observers` to register with the `View`

If you don't want to initialize a different `IView`,
call `super.initializeView()` at the beginning of your
method, then register `IMediator` instances.

Note: This method is *rarely* overridden; in practice you are more
likely to use a `Command` to create and register `Mediator`s
with the `View`, since `IMediator` instances will need to send
`INotification`s and thus will likely want to fetch a reference
to the `Facade` during their construction.
*/
- (void)initializeView {
    self.view = [View getInstance:self.multitonKey factory:^(NSString *key) { return [View withKey:key]; }];
}

/**
Register an `ICommand` with the `Controller` by Notification name.

- parameter notificationName: the name of the `INotification` to associate the `ICommand` with
- parameter factory: reference that returns `ICommand`
*/
- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory {
    [self.controller registerCommand:notificationName factory:factory];
}

/**
Check if a Command is registered for a given Notification

- parameter notificationName:
- returns: whether a Command is currently registered for the given `notificationName`.
*/
- (BOOL)hasCommand:(NSString *)notificationName {
    return [self.controller hasCommand:notificationName];
}

/**
Remove a previously registered `ICommand` to `INotification` mapping from the Controller.

- parameter notificationName: the name of the `INotification` to remove the `ICommand` mapping for
*/
- (void)removeCommand:(NSString *)notificationName {
    [self.controller removeCommand:notificationName];
}

/**
Register an `IProxy` with the `Model` by name.

- parameter proxy: the `IProxy` instance to be registered with the `Model`.
*/
- (void)registerProxy:(id<IProxy>)proxy {
    [self.model registerProxy:proxy];
}

/**
Retrieve an `IProxy` from the `Model` by name.

- parameter proxyName: the name of the proxy to be retrieved.
- returns: the `IProxy` instance previously registered with the given `proxyName`.
*/
- (nullable id<IProxy>)retrieveProxy:(NSString *)proxyName {
    return [self.model retrieveProxy:proxyName];
}

/**
Check if a Proxy is registered

- parameter proxyName:
- returns: whether a Proxy is currently registered with the given `proxyName`.
*/
- (BOOL)hasProxy:(NSString *)proxyName {
    return [self.model hasProxy:proxyName];
}

/**
Remove an `IProxy` from the `Model` by name.

- parameter proxyName: the `IProxy` to remove from the `Model`.
- returns: the `IProxy` that was removed from the `Model`
*/
- (nullable id<IProxy>)removeProxy:(NSString *)proxyName {
    return [self.model removeProxy:proxyName];
}

/**
Register a `IMediator` with the `View`.

- parameter mediator: a reference to the `IMediator`
*/
- (void)registerMediator:(id<IMediator>)mediator {
    [self.view registerMediator:mediator];
}

/**
Retrieve an `IMediator` from the `View`.

- parameter mediatorName:
- returns: the `IMediator` previously registered with the given `mediatorName`.
*/
- (nullable id<IMediator>)retrieveMediator:(NSString *)mediatorName {
    return [self.view retrieveMediator:mediatorName];
}

/**
Check if a Mediator is registered or not

- parameter mediatorName:
- returns: whether a Mediator is registered with the given `mediatorName`.
*/
- (BOOL)hasMediator:(NSString *)mediatorName {
    return [self.view hasMediator:mediatorName];
}

/**
Remove an `IMediator` from the `View`.

- parameter mediatorName: name of the `IMediator` to be removed.
- returns: the `IMediator` that was removed from the `View`
*/
- (nullable id<IMediator>)removeMediator:(NSString *)mediatorName {
    return [self.view removeMediator:mediatorName];
}

/**
Notify `Observer`s.

This method is left public mostly for backward
compatibility, and to allow you to send custom
notification classes using the facade.

Usually you should just call sendNotification
and pass the parameters, never having to
construct the notification yourself.

- parameter notification: the `INotification` to have the `View` notify `Observers` of.
*/
- (void)notifyObservers:(id<INotification>)notification {
    [self.view notifyObservers:notification];
}

/**
Set the Multiton key for this facade instance.

Not called directly, but instead from the
constructor when getInstance is invoked.
It is necessary to be public in order to
implement INotifier.
*/
- (void)initializeNotifier:(NSString *)key {
    _multitonKey = [key copy];
}

/**
Create and send an `INotification`.

Keeps us from having to construct new notification
instances in our implementation code.

- parameter notificationName: the name of the notiification to send
- parameter body: the body of the notification
- parameter type: the type of the notification
*/
- (void)sendNotification:(NSString *)notificationName body:(nullable id)body type:(nullable NSString *)type {
    [self notifyObservers:[Notification withName:notificationName body:body type:type]];
}

/**
 * Send an `INotification` with name only.
 *
 * @param notificationName The name of the notification to send.
 */
-(void)sendNotification:(NSString *)notificationName {
    [self sendNotification:notificationName body:nil type:nil];
}

/**
 * Send an `INotification` with a name and body.
 *
 * @param notificationName The name of the notification.
 * @param body The body content of the notification.
 */
-(void)sendNotification:(NSString *)notificationName body:(id)body {
    [self sendNotification:notificationName body:body type:nil];
}

/**
 * Send an `INotification` with a name and type.
 *
 * @param notificationName The name of the notification.
 * @param type The type string of the notification.
 */
-(void)sendNotification:(NSString *)notificationName type:(NSString *)type {
    [self sendNotification:notificationName body:nil type:type];
}

@end

NS_ASSUME_NONNULL_END
