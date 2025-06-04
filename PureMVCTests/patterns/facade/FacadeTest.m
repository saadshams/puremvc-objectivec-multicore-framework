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

- (void)testGetInstance {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey1" factory:^(NSString *key) { return [Facade withKey:key]; }];
    
    XCTAssertNotNil(facade, @"Expecting instance not nil");
    XCTAssertTrue([(id)facade conformsToProtocol:@protocol(IFacade)], @"Expecting instance implements IFacade");
}

- (void)testRegisterCommandAndSendNotification {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey2" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerCommand:@"FacadeTestNote" factory:^() { return [FacadeTestCommand command]; }];
    
    FacadeTestVO *vo = [[FacadeTestVO alloc] initWithInput:32];
    [facade sendNotification:@"FacadeTestNote" body:vo type:nil];

    XCTAssertTrue(vo.result == 64, @"Expecting vo.result == 64");
}

- (void)testRegisterAndRemoveCommandAndSendNotification {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey3" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerCommand:@"FacadeTestNote" factory:^() { return [FacadeTestCommand command]; }];
    [facade removeCommand:@"FacadeTestNote"];
    
    FacadeTestVO *vo = [[FacadeTestVO alloc] initWithInput:32];
    [facade sendNotification:@"FacadeTestNote" body:vo type:nil];
    
    XCTAssertTrue(vo.result != 64, @"Expecting vo.result != 64");
}

- (void)testRegisterAndRetrieveProxy {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey4" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerProxy:[Proxy withName:@"colors" data:@[@"red", @"green", @"blue"]]];
    id<IProxy> proxy = [facade retrieveProxy:@"colors"];
    
    XCTAssertTrue([(id)proxy conformsToProtocol:@protocol(IProxy)], @"Expecting instance implements IProxy");
    
    NSArray<NSString *> *data = proxy.data;
    XCTAssertNotNil(proxy, @"Expecting proxy not to be nil");
    XCTAssertEqual(3, data.count, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", "Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[0] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[0] == 'blue'");
}

- (void)testRegisterAndRemoveProxy {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey5" factory:^(NSString *key) { return [Facade withKey:key]; }];
    id<IProxy> proxy = [Proxy withName:@"sizes" data:@[@(7), @(13), @(21)]];
    [facade registerProxy:proxy];
    
    id<IProxy> removedProxy = [facade removeProxy:@"sizes"];
    
    XCTAssertEqualObjects(removedProxy.name, @"sizes", @"Expecting removedProxy.name == 'sizes'");
    
    proxy = [facade retrieveProxy:@"sizes"];
    
    XCTAssertNil(proxy, @"Expecting proxy is nil");
}

- (void)testRegisterRetrieveAndRemoveMediator {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey6" factory:^(NSString *key) { return [Facade withKey:key]; }];
    
    [facade registerMediator:[Mediator withName:Mediator.NAME view:[[NSObject alloc] init]]];
    
    XCTAssertNotNil([facade retrieveMediator:Mediator.NAME], @"Expecting mediator is not nil");
    
    id<IMediator> removedMediator = [facade removeMediator:Mediator.NAME];
    
    XCTAssertEqualObjects(removedMediator.name, Mediator.NAME, @"Expecting removedMediator.name == Mediator.NAME");
    
    XCTAssertNil([facade retrieveMediator:Mediator.NAME], @"Expecting [facade retrieveMediator:Mediator.NAME] == nil");
}

- (void)testHasProxy {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey7" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerProxy:[Proxy withName:@"hasProxyTest" data:@[@(1), @(2), @(3)]]];
    
    XCTAssertTrue([facade hasProxy:@"hasProxyTest"], @"Expecing [facade hasProxy:@'hasProxyTest'] == true");
}

- (void)testHasMediator {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey8" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerMediator:[Mediator withName:@"facadeHasMediatorTest" view:[[NSObject alloc] init]]];
    
    XCTAssertTrue([facade hasMediator:@"facadeHasMediatorTest"], @"Expecting [facade hasMediator:@'facadeHasMediatorTest'] == true");
    
    [facade removeMediator:@"facadeHasMediatorTest"];
    
    XCTAssertFalse([facade hasMediator:@"facadeHasMediatorTest"], @"Expecting [facade hasMediator:@'facadeHasMediatorTest'] == false");
}

- (void)testHasCommand {
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey9" factory:^(NSString *key) { return [Facade withKey:key]; }];
    [facade registerCommand:@"facadeHasCommandTest" factory:^() { return [FacadeTestCommand command]; } ];
    
    XCTAssertTrue([facade hasCommand:@"facadeHasCommandTest"], @"Expecting [facade hasCommand:@'facadeHasCommandTest'] == true");
    
    [facade removeCommand:@"facadeHasCommandTest"];
    
    XCTAssertFalse([facade hasCommand:@"facadeHasCommandTest"], @"Expecting [facade hasCommand:@'facadeHasCommandTest'] == false");
}

- (void)testHasCoreAndRemoveCore {
    XCTAssertFalse([Facade hasCore:@"FacadeTestKey10"], @"Expecing [Facade hasCore:@'FacadeTestKey10'] == false");
    id<IFacade> facade = [Facade getInstance:@"FacadeTestKey10" factory:^(NSString *key) { return [Facade withKey:key]; }];
    
    XCTAssertNotNil(facade, @"Expecting instance not nil");
    
    XCTAssertTrue([Facade hasCore:@"FacadeTestKey10"], @"Expecing [Facade hasCore:@'FacadeTestKey10'] == true");
    
    [Facade removeCore:@"FacadeTestKey10"];
    
    XCTAssertFalse([Facade hasCore:@"FacadeTestKey10"], @"Expecing [Facade hasCore:@'FacadeTestKey10'] == false");
}

@end
