//
//  MacroCommandTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "ICommand.h"
#import "Notification.h"
#import "MacroCommandTestCommand.h"
#import "MacroCommandTestVO.h"

@interface MacroCommandTest : XCTestCase

@end

@implementation MacroCommandTest

/**
Tests operation of a `MacroCommand`.

This test creates a new `Notification`, adding a
`MacroCommandTestVO` as the body.
It then creates a `MacroCommandTestCommand` and invokes
its `execute` method, passing in the
`Notification`.

The `MacroCommandTestCommand` has defined an
`initializeMacroCommand` method, which is
called automatically by its constructor. In this method
the `MacroCommandTestCommand` adds 2 SubCommands
to itself, `MacroCommandTestSub1Command` and
`MacroCommandTestSub2Command`.

The `MacroCommandTestVO` has 2 result properties,
one is set by `MacroCommandTestSub1Command` by
multiplying the input property by 2, and the other is set
by `MacroCommandTestSub2Command` by multiplying
the input property by itself.

Success is determined by evaluating the 2 result properties
on the `MacroCommandTestVO` that was passed to
the `MacroCommandTestCommand` on the Notification
body.
*/
- (void)testMacroCommandExecute {
    // Create the VO
    MacroCommandTestVO *vo = [[MacroCommandTestVO alloc] initWithInput:5];
    
    // Create the Notification (note)
    id<INotification> note = [Notification withName:@"MacroCommandTest" body: vo];
    
    // Create the MacroCommand
    id<ICommand> command = [MacroCommandTestCommand command];
    
    // Execute the MacroCommand
    [command execute:note];
    
    // Test assertions
    XCTAssertTrue(vo.result1 == 10, @"Expecting v.result1 == 10");
    XCTAssertTrue(vo.result2 == 25, @"Expecting v.result2 == 25");
}

@end
