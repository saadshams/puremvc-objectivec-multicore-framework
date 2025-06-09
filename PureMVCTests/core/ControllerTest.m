//
//  ControllerTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IController.h"
#import "Controller.h"
#import "ICommand.h"
#import "SimpleCommand.h"
#import "INotification.h"
#import "Notification.h"
#import "IView.h"
#import "View.h"
#import "ControllerTestCommand.h"
#import "ControllerTestCommand2.h"
#import "ControllerTestVO.h"

@interface ControllerTest : XCTestCase

@end

@implementation ControllerTest

/**
Tests the Controller Multiton Factory Method
*/
- (void)testGetInstance {
    id<IController> controller = [Controller getInstance:@"ControllerTestKey1" factory:^(NSString *key) { return [Controller withKey:key]; } ];
    
    // test assertions
    XCTAssertNotNil(controller, @"Expecting instance not nil");
    // Test Factory Method
    XCTAssertTrue([(id)controller conformsToProtocol:@protocol(IController)], @"Expecting instance implements IController");
}

/**
Tests Command registration and execution.

This test gets a Multiton Controller instance
and registers the ControllerTestCommand class
to handle 'ControllerTest' Notifications.

It then constructs such a Notification and tells the
Controller to execute the associated Command.
Success is determined by evaluating a property
on an object passed to the Command, which will
be modified when the Command executes.
*/
- (void)testRegisterAndExecuteCommand {
    // Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
    id<IController> controller = [Controller getInstance:@"ControllerTestKey2" factory:^(NSString *key) { return [Controller withKey:key]; }];
    [controller registerCommand:@"ControllerTest" factory:^() { return [ControllerTestCommand command]; }];
    
    // Create a 'ControllerTest' note
    ControllerTestVO *vo = [[ControllerTestVO alloc] initWithInput:12];
    id<INotification> notification = [Notification withName:@"ControllerTest" body:vo];
    
    // Tell the controller to execute the Command associated with the note
    // the ControllerTestCommand invoked will multiply the vo.input value
    // by 2 and set the result on vo.result
    [controller executeCommand:notification];
    
    // Test assertions
    XCTAssertTrue(vo.result == 24, @"Exepcting vo.result == 24");
}

/**
Tests Command registration and removal.

Tests that once a Command is registered and verified
working, it can be removed from the Controller.
*/
- (void)testRegisterAndRemoveCommand {
    // Create the controller, register the ControllerTestCommand to handle 'ControllerTest' notes
    id<IController> controller = [Controller getInstance:@"ControllerTestKey3" factory:^(NSString *key){ return [Controller withKey:key]; }];
    [controller registerCommand:@"ControllerRemoveTest" factory:^() { return [ControllerTestCommand command]; }];
    
    // Create a 'ControllerTest' note
    ControllerTestVO *vo = [[ControllerTestVO alloc] initWithInput:12];
    id<INotification> notification = [Notification withName:@"ControllerRemoveTest" body:vo];
    
    // Tell the controller to execute the Command associated with the note
    // the ControllerTestCommand invoked will multiply the vo.input value
    // by 2 and set the result on vo.result
    [controller executeCommand:notification];
    
    // test assertions
    XCTAssertTrue(vo.result == 24, @"Expecting vo.result == 24");
    
    // Reset result
    vo.result = 0;
    
    // Remove the Command from the Controller
    [controller removeCommand:@"ControllerRemoveTest"];
    
    // Tell the controller to execute the Command associated with the
    // note. This time, it should not be registered, and our vo result
    // will not change
    [controller executeCommand:notification];
    
    // Test assertions
    XCTAssertTrue(vo.result == 0, @"Expecting vo.result == 0");
}

/**
Test hasCommand method.
*/
- (void)testHasCommand {
    // Register the ControllerTestCommand to handle 'hasCommandTest' notes
    id<IController> controller = [Controller getInstance:@"ControllerTestKey4" factory:^(NSString *key){ return [Controller withKey:key]; }];
    [controller registerCommand:@"hasCommandTest" factory:^() { return [ControllerTestCommand command]; }];
    
    // Test that hasCommand returns true for hasCommandTest notifications
    XCTAssertTrue([controller hasCommand:@"hasCommandTest"] == YES, @"Expecing [controller hasCommand:@'hasCommandTest'] == YES");
    
    // Remove the Command from the Controller
    [controller removeCommand:@"hasCommandTest"];
    
    // Test that hasCommand returns false for hasCommandTest notifications
    XCTAssertTrue([controller hasCommand:@"hasCommandTest"] == NO, @"Expecing [controller hasCommand:@'hasCommandTest'] == NO");
}

/**
Tests Removing and Reregistering a Command

Tests that when a Command is re-registered that it isn't fired twice.
This involves, minimally, registration with the controller but
notification via the View, rather than direct execution of
the Controller's executeCommand method as is done above in
testRegisterAndRemove. The bug under test was fixed in AS3 Standard
Version 2.0.2. If you run the unit tests with 2.0.1 this
test will fail.
*/
- (void)testReregisterAndExecuteCommand {
    // Fetch the controller, register the ControllerTestCommand2 to handle 'ControllerTest2' notes
    id<IController> controller = [Controller getInstance:@"ControllerTestKey5" factory:^(NSString *key) { return [Controller withKey:key]; }];
    
    [controller registerCommand:@"ControllerTest2" factory:^(){ return [ControllerTestCommand command]; }];
    
    // Remove the Command from the Controller
    [controller removeCommand:@"ControllerTest2"];
    
    // Re-register the Command with the Controller
    [controller registerCommand:@"ControllerTest2" factory:^(){ return [ControllerTestCommand command]; }];
    
    // Create a 'ControllerTest2' note
    ControllerTestVO *vo = [[ControllerTestVO alloc] initWithInput:12];
    id<INotification> notification = [Notification withName:@"ControllerTest2" body:vo];

    // Retrieve a reference to the View from the same core.
    id<IView> view = [View getInstance:@"ControllerTestKey5" factory:^(NSString *key) { return [View withKey:key]; }];
    
    // Send the Notification
    [view notifyObservers:notification];
    
    // Test assertions
    // If the command is executed once the value will be 24
    XCTAssertTrue(vo.result == 24, @"Expecting vo.result == 24");
}

@end
