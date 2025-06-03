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
#import "ControllerTestCommand.h"
#import "ControllerTestCommand2.h"
#import "ControllerTestVO.h"

@interface ControllerTest : XCTestCase

@end

@implementation ControllerTest

- (void)testGetInstance {
    id<IController> controller = [Controller getInstance:@"ControllerTestKey1" factory:^(NSString *key) { return [Controller withKey:key]; } ];
    
    XCTAssertNotNil(controller, @"Expecting instance not nil");
    XCTAssertTrue([(id)controller conformsToProtocol:@protocol(IController)], @"Expecting instance implements IController");
}

- (void)testRegisterAndExecuteCommand {
    id<IController> controller = [Controller getInstance:@"ControllerTestKey2" factory:^(NSString *key) { return [Controller withKey:key]; }];
    [controller registerCommand:@"ControllerTest" factory:^() { return [ControllerTestCommand command]; }];
    
    ControllerTestVO *vo = [[ControllerTestVO alloc] initWithInput:12];
    id<INotification> notification = [Notification withName:@"ControllerTest" body:vo];
    
    [controller executeCommand:notification];
    
    XCTAssertTrue(vo.result == 24, @"Exepcting vo.result == 24");
}

- (void)testRegisterAndRemoveCommand {
    id<IController> controller = [Controller getInstance:@"ControllerTestKey3" factory:^(NSString *key){ return [Controller withKey:key]; }];
    [controller registerCommand:@"ControllerRemoveTest" factory:^() { return [ControllerTestCommand command]; }];
    
    ControllerTestVO *vo = [[ControllerTestVO alloc] initWithInput:12];
    id<INotification> notification = [Notification withName:@"ControllerRemoveTest" body:vo];
    
    [controller executeCommand:notification];
    
    XCTAssertTrue(vo.result == 24, @"Expecting vo.result == 24");
    
    vo.result = 0;
    
    [controller removeCommand:@"ControllerRemoveTest"];
    
    [controller executeCommand:notification];
    
    XCTAssertTrue(vo.result == 0, @"Expecting vo.result == 0");
}

- (void)testHasCommand {
    id<IController> controller = [Controller getInstance:@"ControllerTestKey4" factory:^(NSString *key){ return [Controller withKey:key]; }];
    [controller registerCommand:@"hasCommandTest" factory:^() { return [ControllerTestCommand command]; }];
    
    XCTAssertTrue([controller hasCommand:@"hasCommandTest"] == YES, @"Expecing [controller hasCommand:@'hasCommandTest'] == YES");
    
    [controller removeCommand:@"hasCommandTest"];
    
    XCTAssertTrue([controller hasCommand:@"hasCommandTest"] == NO, @"Expecing [controller hasCommand:@'hasCommandTest'] == NO");
}

- (void)testReregisterAndExecuteCommand {
//    id<IController> controller = [Controller getInstance:@"ControllerTestKey5" factory:^(NSString *key) { return [Controller withKey:key]; }];
//    [controller registerCommand:@"ControllerTest2" factory:^(){return [ControllerTestCommand command]; }];
//    
//    [controller removeCommand:@"ControllerTest2"];
//    
//    [controller registerCommand:@"ControllerTest2" factory:^() { return [ControllerTestCommand command]; }];
//    
//    ControllerTestVO *vo = [[ControllerTestVO alloc] initWithInput:12];
//    id<INotification> notification = [Notification withName:@"ControllerTest2" body:vo];
    
    // todo:
}

@end
