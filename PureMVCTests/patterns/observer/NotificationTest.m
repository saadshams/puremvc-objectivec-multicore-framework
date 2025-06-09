//
//  NotificationTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "INotification.h"
#import "Notification.h"

@interface NotificationTest : XCTestCase

@end

@implementation NotificationTest

/**
Tests setting and getting the name using Notification class accessor methods.
*/
- (void)testNameAccessors {
    // Create a new Notification and use accessors to set the note name
    id<INotification> notification = [Notification withName:@"TestNote"];
    
    // Test assertions
    XCTAssertEqualObjects(notification.name, @"TestNote", @"Expecting notification.name == 'TestNote'");
}

/**
Tests setting and getting the body using Notification class accessor methods.
*/
- (void)testBodyAccessors {
    // Create a new Notification and use accessors to set the body
    id<INotification> notification = [Notification withName:@"TestNote"];
    notification.body = @(5);
    
    // Test assertions
    XCTAssertTrue([[notification body] intValue] == 5, @"Expecting [notification body] == 5");
}

- (void)testConstructor {
    // Create a new Notification using the Constructor to set the note name and body
    id<INotification> notification = [Notification withName:@"TestNote" body:@(5) type:@"TestNoteType"];
    
    // Test assertions
    XCTAssertEqualObjects(notification.name, @"TestNote", @"Expecting notification.name == 'TestNote'");
    XCTAssertTrue([notification.body intValue], @"Expecting [notification body] == 5");
    
    XCTAssertEqualObjects(notification.type, @"TestNoteType", @"Expecting notification.type == 'TestNoteType'");

}

/**
Tests the toString method of the notification
*/
- (void)testDescription {
    // Create a new Notification and use accessors to set the note name
    id<INotification> notification = [Notification withName:@"TestNote" body:@"1,3,5" type:@"TestType"];
    NSString *ts = @"Notification Name: TestNote\nBody: 1,3,5\nType: TestType";
    
    // Test assertions
    XCTAssertEqualObjects(notification.description, ts, @"Expecing note.description == ts");
}

@end
