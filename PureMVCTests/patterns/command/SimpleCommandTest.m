//
//  SimpleCommandTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "ICommand.h"
#import "SimpleCommand.h"
#import "Notification.h"
#import "SimpleCommandTestCommand.h"
#import "SimpleCommandTestVO.h"

@interface SimpleCommandTest : XCTestCase

@end

@implementation SimpleCommandTest

/**
Tests the `execute` method of a `SimpleCommand`.

This test creates a new `Notification`, adding a
`SimpleCommandTestVO` as the body.
It then creates a `SimpleCommandTestCommand` and invokes
its `execute` method, passing in the note.

Success is determined by evaluating a property on the
object that was passed on the Notification body, which will
be modified by the SimpleCommand.
*/
- (void)testSimpleCommandExecute {
    // Create the VO
    SimpleCommandTestVO *vo = [[SimpleCommandTestVO alloc] initWithInput:5];
    
    // Create the Notification (note)
    id<INotification> note = [Notification withName:@"SimpleCommandTest" body:vo];
    
    // Create the SimpleCommand
    id<ICommand> command = [SimpleCommandTestCommand command];
    
    // Execute the SimpleCommand
    [command execute:note];
    
    // Test assertions
    XCTAssertTrue(vo.result == 10, @"Expecting vo.result == 10");
}
@end
