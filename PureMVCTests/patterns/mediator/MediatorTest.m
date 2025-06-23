//
//  MediatorTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "Mediator.h"

@interface MediatorTest : XCTestCase

@end

@implementation MediatorTest

/**
Tests getting the name using Mediator class accessor method.
*/
- (void)testNameAccessor {
    // Create a new Mediator and use accessors to set the mediator name
    id<IMediator> mediator = [Mediator mediator];
    
    // Test assertions
    XCTAssertEqualObjects(mediator.name, [Mediator NAME], @"Expecting mediator.name == [Mediator NAME]");

}

/**
Tests getting the name using Mediator class accessor method.
*/
- (void)testViewAccessor {
    // Create a view object
    id object = [[NSObject alloc] init];
    
    // Create a new Proxy and use accessors to set the proxy name
    id<IMediator> mediator = [Mediator withName:@"MyMediator" view:object];
    
    // Test assertions
    XCTAssertNotNil([mediator view], @"Expecting view not nill");
}

@end
