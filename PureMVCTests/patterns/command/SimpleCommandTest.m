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

- (void)testSimpleCommandExecute {
    SimpleCommandTestVO *vo = [[SimpleCommandTestVO alloc] initWithInput:5];
    
    id<INotification> note = [Notification withName:@"SimpleCommandTest" body:vo];
    
    id<ICommand> command = [SimpleCommandTestCommand command];
    
    [command execute:note];
    
    XCTAssertTrue(vo.result == 10, @"Expecting vo.result == 10");
}
@end
