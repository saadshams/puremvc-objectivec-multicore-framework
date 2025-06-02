//
//  MacroCommandTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "ICommand.h"
#import "INotification.h"
#import "Notification.h"
#import "MacroCommandTestCommand.h"
#import "MacroCommandTestVO.h"

@interface MacroCommandTest : XCTestCase

@end

@implementation MacroCommandTest

- (void)testMacroCommandExecute {
    MacroCommandTestVO *vo = [[MacroCommandTestVO alloc] initWithInput:5];
    
    id<INotification> note = [Notification withName:@"MacroCommandTest" body: vo];
    
    id<ICommand> command = [MacroCommandTestCommand command];
    
    [command execute:note];
    
    XCTAssertTrue(vo.result1 == 10, @"Expecting v.result1 == 10");
    XCTAssertTrue(vo.result2 == 25, @"Expecting v.result2 == 25");
}

@end
