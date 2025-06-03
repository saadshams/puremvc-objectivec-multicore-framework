//
//  ObserverTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IObserver.h"
#import "Observer.h"
#import "INotification.h"
#import "Notification.h"

@interface ObserverTest : XCTestCase

@end

static NSInteger observerTestVar = 0;

@implementation ObserverTest

- (void)observerTestMethod:(id<INotification>)notification {
    observerTestVar = [(NSNumber *)notification.body integerValue];
}

- (void)testObserverAccessors {
    id<IObserver> observer = [Observer withNotify:nil context:nil];
    observer.context = self;
    observer.notify = @selector(observerTestMethod:);
    
    id<INotification> notification = [Notification withName:@"ObserverTestNote" body:@(10)];
    [observer notifyObserver:notification];
    
    XCTAssertTrue(observerTestVar == 10, @"Expecting observerTestVar == 10");
}

- (void)testObserverConstructor {
    id<IObserver> observer = [Observer withNotify:@selector(observerTestMethod:) context:self];
    
    id<INotification> notification = [Notification withName:@"ObserverTestNote" body:@(5)];
    [observer notifyObserver:notification];
    
    XCTAssertTrue(observerTestVar == 5, "Expecting observerTestVar == 5");
}

- (void)testCompareNotifyContext {
    id<IObserver> observer = [Observer withNotify:@selector(observerTestMethod:) context:self];
    
    NSObject *negTestObject = [[NSObject alloc] init];
    
    XCTAssertFalse([observer compareNotifyContext:negTestObject], @"[observer compareNotifyContext:negTestObject] == false");
    XCTAssertTrue([observer compareNotifyContext:self], @"[observer compareNotifyContext:self]");
}

@end
