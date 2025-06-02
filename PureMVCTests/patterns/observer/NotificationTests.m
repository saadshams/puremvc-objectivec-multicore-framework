//
//  NotificationTests.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "INotification.h"
#import "Notification.h"

@interface NotificationTests : XCTestCase

@end

@implementation NotificationTests

- (void)testNameAccessors {
    id<INotification> notification = [Notification withName:@"TestNote"];
    
    XCTAssertTrue([[notification name] isEqualToString:@"TestNote"], @"Expecting [notification name] == 'TestNote'");
}

- (void)testBodyAccessors {
    id<INotification> notification = [Notification withName:@"TestNote"];
    notification.body = @(5);
    
    XCTAssertTrue([[notification body] intValue] == 5, @"Expecting [notification body] == 5");
}

- (void)testConstructor {
    id<INotification> notification = [Notification withName:@"TestNote" body:@(5) type:@"TestNoteType"];
    
    XCTAssertTrue([[notification name] isEqualToString:@"TestNote"], @"Expecting [notification name] == 'TestNote'");
    XCTAssertTrue([[notification body] intValue], @"Expecting [notification body] == 5");
    XCTAssertTrue([[notification type] isEqualToString:@"TestNoteType"], @"Expecting [notification type] == 'TestNoteType'");
}

- (void)testDescription {
    id<INotification> notification = [Notification withName:@"TestNote" body:@"1,3,5" type:@"TestType"];
    NSString *ts = @"Notification Name: TestNote\nBody: 1,3,5\nType: TestType";
    
    XCTAssertTrue([[notification description] isEqualToString:ts], @"Expecting [note description] == '%@'", ts);
}

@end
