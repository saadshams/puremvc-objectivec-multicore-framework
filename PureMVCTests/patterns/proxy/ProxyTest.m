//
//  ProxyTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import <PureMVC/PureMVC.h>

@interface PureMVCTest : XCTestCase

@end

@implementation PureMVCTest

/**
Tests getting the name using Proxy class accessor method. Setting can only be done in constructor.
*/
- (void)testNameAccessor {
    // Create a new Proxy and use accessors to set the proxy name
    id<IProxy> proxy = [Proxy withName:@"TestProxy"];
    
    // Test assertions
    XCTAssertNotNil(proxy, @"Expectin proxy not to be nil");
    XCTAssertEqualObjects([proxy name], @"TestProxy", @"Expecting [proxy name] == 'TestProxy'");
}

/**
Tests setting and getting the data using Proxy class accessor methods.
*/
- (void)testDataAccessor {
    // Create a new Proxy and use accessors to set the data
    id<IProxy> proxy = [Proxy withName:@"colors"];
    proxy.data = @[@"red", @"green", @"blue"];
    
    NSArray *data = [proxy data];
    
    // Test assertions
    XCTAssertNotNil(proxy, @"Expecting proxy not to be nil");
    XCTAssertEqual(3, data.count, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", "Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[0] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[0] == 'blue'");
}

/**
Tests setting the name and body using the Notification class Constructor.
*/
- (void)testConstructor {
    // Create a new Proxy using the Constructor to set the name and data
    Proxy *proxy = [Proxy withName:@"colors" data:@[@"red", @"green", @"blue"]];
    NSArray *data = [proxy data];
    
    // Test assertions
    XCTAssertNotNil(proxy, @"Expecting proxy not to be nil");
    XCTAssertEqualObjects([proxy name], @"colors", @"Expecting [proxy name] == 'colors'");
    XCTAssertNotNil(data, @"Expecting data not be nil");
    XCTAssertEqual(3, data.count, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", @"Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[0] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[0] == 'blue'");
}

@end
