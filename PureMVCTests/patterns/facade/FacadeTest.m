//
//  FacadeTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IFacade.h"
#import "Facade.h"
#import "IProxy.h"
#import "Proxy.h"
#import "IMediator.h"
#import "Mediator.h"
#import "FacadeTestCommand.h"
#import "FacadeTestVO.h"

@interface FacadeTest : XCTestCase

@end

@implementation FacadeTest

/**
Tests the Facade Multiton Factory Method
*/
- (void)testGetInstance {
    // Test Factory Method
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey1" factory:^(NSString *key) { return [Facade withKey:key]; }];
    // id<IFacade> facade = [Facade getInstance:@"FacadeTestKey1" factory:^id<IFacade>(NSString *key) { return [Facade withKey:key]; }];
    
    // Test assertions
    XCTAssertNotNil(facade, @"Expecting instance not nil");
    XCTAssertTrue([(id)facade conformsToProtocol:@protocol(IFacade)], @"Expecting instance implements IFacade");
}

/**
Tests Command registration and execution via the Facade.

This test gets a Multiton Facade instance
and registers the FacadeTestCommand class
to handle 'FacadeTest' Notifcations.

It then sends a notification using the Facade.
Success is determined by evaluating
a property on an object placed in the body of
the Notification, which will be modified by the Command.
*/
- (void)testRegisterCommandAndSendNotification {
    // Create the Facade, register the FacadeTestCommand to
    // handle 'FacadeTest' notifications
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey2" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerCommand:@"FacadeTestNote" factory:^() { return [FacadeTestCommand command]; }];
    
    // Send notification. The Command associated with the event
    // (FacadeTestCommand) will be invoked, and will multiply
    // the vo.input value by 2 and set the result on vo.result
    FacadeTestVO *vo = [[FacadeTestVO alloc] initWithInput:32];
    [facade sendNotification:@"FacadeTestNote" body:vo type:nil];

    // Test assertions
    XCTAssertTrue(vo.result == 64, @"Expecting vo.result == 64");
}

/**
Tests Command removal via the Facade.

This test gets a Multiton Facade instance
and registers the FacadeTestCommand class
to handle 'FacadeTest' Notifcations. Then it removes the command.

It then sends a Notification using the Facade.
Success is determined by evaluating
a property on an object placed in the body of
the Notification, which will NOT be modified by the Command.
*/
- (void)testRegisterAndRemoveCommandAndSendNotification {
    // Create the Facade, register the FacadeTestCommand to
    // handle 'FacadeTest' events
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey3" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerCommand:@"FacadeTestNote" factory:^() { return [FacadeTestCommand command]; }];
    [facade removeCommand:@"FacadeTestNote"];
    
    // Send notification. The Command associated with the event
    // (FacadeTestCommand) will NOT be invoked, and will NOT multiply
    // the vo.input value by 2
    FacadeTestVO *vo = [[FacadeTestVO alloc] initWithInput:32];
    [facade sendNotification:@"FacadeTestNote" body:vo type:nil];
    
    // Test assertions
    XCTAssertTrue(vo.result != 64, @"Expecting vo.result != 64");
}

/**
Tests the regsitering and retrieving Model proxies via the Facade.

Tests `registerProxy` and `retrieveProxy` in the same test.
These methods cannot currently be tested separately
in any meaningful way other than to show that the
methods do not throw exception when called.
*/
- (void)testRegisterAndRetrieveProxy {
    // Register a proxy and retrieve it.
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey4" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerProxy:[Proxy withName:@"colors" data:@[@"red", @"green", @"blue"]]];
    id<IProxy> proxy = [facade retrieveProxy:@"colors"];
    
    XCTAssertTrue([(id)proxy conformsToProtocol:@protocol(IProxy)], @"Expecting instance implements IProxy");
    
    // Retrieve data from proxy
    NSArray<NSString *> *data = proxy.data;
    
    // Test assertions
    XCTAssertNotNil(proxy, @"Expecting proxy not to be nil");
    XCTAssertEqual(3, data.count, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", "Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[0] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[0] == 'blue'");
}

/**
Tests the removing Proxies via the Facade.
*/
- (void)testRegisterAndRemoveProxy {
    // Register a proxy, remove it, then try to retrieve it
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey5" factory:^(NSString *key) { return [Facade withKey:key]; }];
    id<IProxy> proxy = [Proxy withName:@"sizes" data:@[@(7), @(13), @(21)]];
    [facade registerProxy:proxy];
    
    // Remove the proxy
    id<IProxy> removedProxy = [facade removeProxy:@"sizes"];
    
    // Assert that we removed the appropriate proxy
    XCTAssertEqualObjects(removedProxy.name, @"sizes", @"Expecting removedProxy.name == 'sizes'");
    
    // Make sure we can no longer retrieve the proxy from the model
    proxy = [facade retrieveProxy:@"sizes"];
    
    // Test assertions
    XCTAssertNil(proxy, @"Expecting proxy is nil");
}

/**
Tests registering, retrieving and removing Mediators via the Facade.
*/
- (void)testRegisterRetrieveAndRemoveMediator {
    // Register a mediator, remove it, then try to retrieve it
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey6" factory:^(NSString *key) { return [Facade withKey:key]; }];
    
    [facade registerMediator:[Mediator withName:Mediator.NAME view:[[NSObject alloc] init]]];
    
    // Retrieve the mediator
    XCTAssertNotNil([facade retrieveMediator:Mediator.NAME], @"Expecting mediator is not nil");
    
    // Remove the mediator
    id<IMediator> removedMediator = [facade removeMediator:Mediator.NAME];
    
    // Assert that we have removed the appropriate mediator
    XCTAssertEqualObjects(removedMediator.name, Mediator.NAME, @"Expecting removedMediator.name == Mediator.NAME");
    
    // Assert that the mediator is no longer retrievable
    XCTAssertNil([facade retrieveMediator:Mediator.NAME], @"Expecting [facade retrieveMediator:Mediator.NAME] == nil");
}

/**
Tests the hasProxy Method
*/
- (void)testHasProxy {
    // Register a Proxy
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey7" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerProxy:[Proxy withName:@"hasProxyTest" data:@[@(1), @(2), @(3)]]];
    
    // Assert that the model.hasProxy method returns true
    // for that proxy name
    XCTAssertTrue([facade hasProxy:@"hasProxyTest"], @"Expecing [facade hasProxy:@'hasProxyTest'] == true");
}

/**
Tests the hasMediator Method
*/
- (void)testHasMediator {
    // Register a Mediator
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey8" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerMediator:[Mediator withName:@"facadeHasMediatorTest" view:[[NSObject alloc] init]]];
    
    // Assert that the facade?.hasMediator method returns true
    // for that mediator name
    XCTAssertTrue([facade hasMediator:@"facadeHasMediatorTest"], @"Expecting [facade hasMediator:@'facadeHasMediatorTest'] == true");
    
    [facade removeMediator:@"facadeHasMediatorTest"];
    
    // Assert that the facade?.hasMediator method returns false
    // for that mediator name
    XCTAssertFalse([facade hasMediator:@"facadeHasMediatorTest"], @"Expecting [facade hasMediator:@'facadeHasMediatorTest'] == false");
}

/**
Test hasCommand method.
*/
- (void)testHasCommand {
    // Register the ControllerTestCommand to handle 'hasCommandTest' notes
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey9" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerCommand:@"facadeHasCommandTest" factory:^() { return [FacadeTestCommand command]; } ];
    
    // Test that hasCommand returns true for hasCommandTest notifications
    XCTAssertTrue([facade hasCommand:@"facadeHasCommandTest"], @"Expecting [facade hasCommand:@'facadeHasCommandTest'] == true");
    
    // Remove the Command from the Controller
    [facade removeCommand:@"facadeHasCommandTest"];
    
    // Test that hasCommand returns false for hasCommandTest notifications
    XCTAssertFalse([facade hasCommand:@"facadeHasCommandTest"], @"Expecting [facade hasCommand:@'facadeHasCommandTest'] == false");
}

/**
Tests the hasCore and removeCore methods
*/
- (void)testHasCoreAndRemoveCore {
    // Assert that the Facade.hasCore method returns false first
    XCTAssertFalse([Facade hasCore:@"FacadeTestKey10"], @"Expecing [Facade hasCore:@'FacadeTestKey10'] == false");
    
    // Register a Core
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey10" factory:^(NSString *key) { return [Facade withKey:key]; }];
    
    // Assert that the Facade.hasCore method returns true now that a Core is registered
    XCTAssertNotNil(facade, @"Expecting instance not nil");
    XCTAssertTrue([Facade hasCore:@"FacadeTestKey10"], @"Expecing [Facade hasCore:@'FacadeTestKey10'] == true");
    
    // remove the Core
    [Facade removeCore:@"FacadeTestKey10"];
    
    // Assert that the Facade.hasCore method returns false now that the core has been removed.
    XCTAssertFalse([Facade hasCore:@"FacadeTestKey10"], @"Expecing [Facade hasCore:@'FacadeTestKey10'] == false");
}

@end
