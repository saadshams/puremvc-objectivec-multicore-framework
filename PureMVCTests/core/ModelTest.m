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

- (void)testGetInstance {
    id<IModel> model = [Model getInstance:@"ModelTestKey1" factory:^(NSString *key) { return [Model withKey:key]; }];
    // id<IModel> model = [Model getInstance:@"ModelTestKey1" factory:(id<IModel> (^)(NSString *))^(NSString *key) { return [Model withKey:key]; }];
    
    XCTAssertNotNil(model, @"Expecting instance not nil");
    XCTAssertTrue([(id)model conformsToProtocol:@protocol(IModel)], @"Expecting instance implements IModel");
}

- (void)testRegisterAndRetrieveProxy {
    id<IModel> model = [Model getInstance:@"ModelTestKey2" factory:^(NSString *key) { return [Model withKey:key]; }];
    [model registerProxy: [Proxy withName:@"colors" data:@[@"red", @"green", @"blue"]]];
    id<IProxy> proxy = [model retrieveProxy:@"colors"];
    NSArray *data = [proxy data];
    
    XCTAssertNotNil(data, @"Expecting data not nil");
    XCTAssertTrue([data isKindOfClass:[NSArray class]], @"Expecting data type is NSArray");
    XCTAssertEqual([data count], 3, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", @"Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[1] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[2] == 'blue'");
}

- (void)testRegisterAndRemoveProxy {
    id<IModel> model = [Model getInstance:@"ModelTestKey3" factory:^(NSString *key) { return [Model withKey:key]; }];
    id<IProxy> proxy = [Proxy withName:@"sizes" data:@[@(7), @(13), @(21)]];
    [model registerProxy:proxy];
    
    id<IProxy> removedProxy = [model removeProxy:@"sizes"];
    
    XCTAssertEqualObjects(removedProxy.name, @"sizes", @"Expecting removedProxy.name == 'sizes'");

    proxy = [model retrieveProxy:@"sizes"];
    XCTAssertNil(proxy, @"Expecting proxy is nil");
}

- (void)testHasProxy {
    id<IModel> model = [Model getInstance:@"ModelTestKey4" factory:^(NSString *key){ return [Model withKey:key]; }];
    id<IProxy> proxy = [Proxy withName:@"aces" data:@[@"clubs", @"spades", @"hearts", @"diamonds"]];
    [model registerProxy:proxy];
    
    XCTAssertTrue([model hasProxy:@"aces"], @"Expecting [model hasProxy('aces')]");
    
    [model removeProxy:@"aces"];
    
    XCTAssertTrue([model hasProxy:@"aces"] == false, @"Expecting [model hasProxy('aces')] == false");
}

- (void)testOnRegisterAndOnRemove {
    id<IModel> model = [Model getInstance:@"ModelTestKey5" factory:^(NSString *key){ return [Model withKey:key]; }];
    
    id<IProxy> proxy = [ModelTestProxy proxy];
    [model registerProxy:proxy];
    
    XCTAssertEqualObjects(proxy.data, [ModelTestProxy ON_REGISTER_CALLED], @"Expecting proxy.data == [ModelTestProxy ON_REGISTER_CALLED]");
    
    [model removeProxy:proxy.name];
        
    XCTAssertTrue([proxy.data isEqualToString:[ModelTestProxy ON_REMOVE_CALLED]], @"Expecting proxy.data == [ModelTestProxy ON_REMOVE_CALLED");

}

@end
