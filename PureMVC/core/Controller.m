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

NS_ASSUME_NONNULL_BEGIN

@interface Controller()

@property (nonatomic, copy, readonly) NSString *multitonKey;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id<ICommand> (^)(void)> *commandMap;
@property (nonatomic, strong) dispatch_queue_t commandMapQueue;

@end

static NSMutableDictionary<NSString *, id<IController>> *instanceMap = nil;

__attribute__((constructor()))
static void initialize(void) {
    instanceMap = [NSMutableDictionary dictionary];
}

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
        _commandMap = [NSMutableDictionary dictionary];
        _commandMapQueue = dispatch_queue_create("org.puremvc.controller.proxyMapQueue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)registerCommand:(NSString *)notificationName factory:(id<ICommand> (^)(void))factory {
    dispatch_barrier_sync(self.commandMapQueue, ^{
        if (!_commandMap[notificationName]) {
            // id<IObserver> observer = [Observer withNotify:@selector(execute:) context: self];
            // [view registerObserver:notificationName observer: observer]
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
            //[view removeObserver:notificationName context: self];
            self.commandMap[notificationName] = nil;
        }
    });
}

@end

NS_ASSUME_NONNULL_END
