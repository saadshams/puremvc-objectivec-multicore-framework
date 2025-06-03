//
//  MediatorTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IMediator.h"
#import "Mediator.h"

@interface MediatorTest : XCTestCase

@end

@implementation MediatorTest

- (void)testNameAccessor {
    id<IMediator> mediator = [Mediator mediator];
    
    XCTAssertEqualObjects(mediator.name, [Mediator NAME], @"Expecting mediator.name == [Mediator NAME]");

}

- (void)testViewAccessor {
    id object = [[NSObject alloc] init];
    
    id<IMediator> mediator = [Mediator withName:@"MyMediator" view:object];
    
    XCTAssertNotNil([mediator view], @"Expecting view not nill");
}

@end
