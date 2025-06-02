//
//  ProxyTests.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IProxy.h"
#import "Proxy.h"

@interface PureMVCTests : XCTestCase

@end

@implementation PureMVCTests

- (void)testNameAccessor {
    id<IProxy> proxy = [Proxy withName:@"TestProxy"];
    
    XCTAssertNotNil(proxy, @"Expectin proxy not to be nil");
    XCTAssertEqualObjects([proxy name], @"TestProxy", @"Expecting [proxy name] == 'TestProxy'");
}

- (void)testDataAccessor {
    id<IProxy> proxy = [Proxy withName:@"colors"];
    proxy.data = @[@"red", @"green", @"blue"];
    
    NSArray *data = [proxy data];
    
    XCTAssertNotNil(proxy, @"Expecting proxy not to be nil");
    XCTAssertEqual(3, data.count, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", "Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[0] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[0] == 'blue'");
}

- (void)testConstructor {
    Proxy *proxy = [Proxy withName:@"colors" data:@[@"red", @"green", @"blue"]];
    NSArray *data = [proxy data];
    
    XCTAssertNotNil(proxy, @"Expecting proxy not to be nil");
    XCTAssertEqualObjects([proxy name], @"colors", @"Expecting [proxy name] == 'colors'");
    XCTAssertNotNil(data, @"Expecting data not be nil");
    XCTAssertEqual(3, data.count, @"Expecting data.count == 3");
    XCTAssertEqualObjects(data[0], @"red", @"Expecting data[0] == 'red'");
    XCTAssertEqualObjects(data[1], @"green", @"Expecting data[0] == 'green'");
    XCTAssertEqualObjects(data[2], @"blue", @"Expecting data[0] == 'blue'");
}

@end
