//
//  ModelTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IModel.h"
#import "Model.h"
#import "IProxy.h"
#import "Proxy.h"
#import "ModelTestProxy.h"

@interface ModelTest : XCTestCase

@end

@implementation ModelTest

/**
Tests the Model Multiton Factory Method
*/
- (void)testGetInstance {
    // Test Factory Method
    id<IModel> model = [Model getInstance:@"ModelTestKey1" factory:^(NSString *key) { return [Model withKey:key]; }];
    // id<IModel> model = [Model getInstance:@"ModelTestKey1" factory:(id<IModel> (^)(NSString *))^(NSString *key) { return [Model withKey:key]; }];
    
    // test assertions
    XCTAssertNotNil(model, @"Expecting instance not nil");
    XCTAssertTrue([(id)model conformsToProtocol:@protocol(IModel)], @"Expecting instance implements IModel");
}

/**
Tests the proxy registration and retrieval methods.

Tests `registerProxy` and `retrieveProxy` in the same test.
These methods cannot currently be tested separately
in any meaningful way other than to show that the
methods do not throw exception when called.
*/
- (void)testRegisterAndRetrieveProxy {
    // Register a proxy and retrieve it.
    id<IModel> model = [Model getInstance:@"ModelTestKey2" factory:^(NSString *key) { return [Model withKey:key]; }];
    [model registerProxy: [Proxy withName:@"colors" data:@[@"red", @"green", @"blue"]]];
    id<IProxy> proxy = [model retrieveProxy:@"colors"];
    NSArray *data = [proxy data];
    
    // Test assertions
    XCTAssertNotNil(data, @"Expecting data not nil");
    XCTAssertTrue([data isKindOfClass:[NSArray class]], @"Expecting data type is NSArray");
    XCTAssertEqual([data count], 3, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", @"Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[1] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[2] == 'blue'");
}

/**
Tests the proxy removal method.
*/
- (void)testRegisterAndRemoveProxy {
    // Register a proxy, remove it, then try to retrieve it
    id<IModel> model = [Model getInstance:@"ModelTestKey3" factory:^(NSString *key) { return [Model withKey:key]; }];
    id<IProxy> proxy = [Proxy withName:@"sizes" data:@[@(7), @(13), @(21)]];
    [model registerProxy:proxy];
    
    // Remove the proxy
    id<IProxy> removedProxy = [model removeProxy:@"sizes"];
    
    // Assert that we removed the appropriate proxy
    XCTAssertEqualObjects(removedProxy.name, @"sizes", @"Expecting removedProxy.name == 'sizes'");

    // Ensure that the proxy is no longer retrievable from the model
    proxy = [model retrieveProxy:@"sizes"];
    
    // Test assertions
    XCTAssertNil(proxy, @"Expecting proxy is nil");
}

/**
Tests the hasProxy Method
*/
- (void)testHasProxy {
    // Register a proxy
    id<IModel> model = [Model getInstance:@"ModelTestKey4" factory:^(NSString *key){ return [Model withKey:key]; }];
    id<IProxy> proxy = [Proxy withName:@"aces" data:@[@"clubs", @"spades", @"hearts", @"diamonds"]];
    [model registerProxy:proxy];
    
    // Assert that the model.hasProxy method returns true
    // for that proxy name
    XCTAssertTrue([model hasProxy:@"aces"], @"Expecting [model hasProxy('aces')]");
    
    // Remove the proxy
    [model removeProxy:@"aces"];
    
    // Assert that the model.hasProxy method returns false
    // for that proxy name
    XCTAssertTrue([model hasProxy:@"aces"] == false, @"Expecting [model hasProxy('aces')] == false");
}

/**
Tests that the Model calls the onRegister and onRemove methods
*/
- (void)testOnRegisterAndOnRemove {
    // Get a Multiton View instance
    id<IModel> model = [Model getInstance:@"ModelTestKey5" factory:^(NSString *key){ return [Model withKey:key]; }];
    
    // Create and register the test mediator
    id<IProxy> proxy = [ModelTestProxy proxy];
    [model registerProxy:proxy];
    
    // Assert that onRegsiter was called, and the proxy responded by setting its data accordingly
    XCTAssertEqualObjects(proxy.data, [ModelTestProxy ON_REGISTER_CALLED], @"Expecting proxy.data == [ModelTestProxy ON_REGISTER_CALLED]");
    
    // Remove the component
    [model removeProxy:proxy.name];
        
    // Assert that onRemove was called, and the proxy responded by setting its data accordingly
    XCTAssertTrue([proxy.data isEqualToString:[ModelTestProxy ON_REMOVE_CALLED]], @"Expecting proxy.data == [ModelTestProxy ON_REMOVE_CALLED");

}

@end
