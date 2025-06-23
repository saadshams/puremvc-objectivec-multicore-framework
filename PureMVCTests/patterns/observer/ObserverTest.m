//
//  ObserverTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "Observer.h"
#import "Notification.h"

@interface ObserverTest : XCTestCase

@end

static NSInteger observerTestVar = 0;

@implementation ObserverTest

/**
A test variable that proves the notify method was
executed with 'this' as its exectution context
*/
- (void)observerTestMethod:(id<INotification>)notification {
    observerTestVar = [(NSNumber *)notification.body integerValue];
}

/**
Tests observer class when initialized by accessor methods.
*/
- (void)testObserverAccessors {
    // Create observer
    id<IObserver> observer = [Observer withNotify:nil context:nil];
    observer.context = self;
    observer.notify = @selector(observerTestMethod:);
    
    // Create a test event, setting a payload value and notify
    // the observer with it. since the observer is this class
    // and the notification method is observerTestMethod,
    // successful notification will result in our local
    // observerTestVar being set to the value we pass in
    // on the note body.
    id<INotification> notification = [Notification withName:@"ObserverTestNote" body:@(10)];
    [observer notifyObserver:notification];
    
    // Test assertions
    XCTAssertTrue(observerTestVar == 10, @"Expecting observerTestVar == 10");
}

/**
Tests observer class when initialized by constructor.
*/
- (void)testObserverConstructor {
    // Create observer passing in notification method and context
    id<IObserver> observer = [Observer withNotify:@selector(observerTestMethod:) context:self];
    
    // Create a test note, setting a body value and notify
    // the observer with it. since the observer is this class
    // and the notification method is observerTestMethod,
    // successful notification will result in our local
    // observerTestVar being set to the value we pass in
    // on the note body.
    id<INotification> notification = [Notification withName:@"ObserverTestNote" body:@(5)];
    [observer notifyObserver:notification];
    
    // Test assertions
    XCTAssertTrue(observerTestVar == 5, "Expecting observerTestVar == 5");
}

/**
Tests the compareNotifyContext method of the Observer class
*/
- (void)testCompareNotifyContext {
    // Create observer passing in notification method and context
    id<IObserver> observer = [Observer withNotify:@selector(observerTestMethod:) context:self];
    
    NSObject *negTestObject = [[NSObject alloc] init];
    
    // Test assertions
    XCTAssertFalse([observer compareNotifyContext:negTestObject], @"[observer compareNotifyContext:negTestObject] == false");
    XCTAssertTrue([observer compareNotifyContext:self], @"[observer compareNotifyContext:self]");
}

@end
