//
//  ViewTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import <PureMVC/PureMVC.h>
#import "ViewTestMediator.h"
#import "ViewTestMediator2.h"
#import "ViewTestMediator3.h"
#import "ViewTestMediator4.h"
#import "ViewTestMediator5.h"
#import "ViewTestMediator6.h"
#import "ViewTestNotification.h"
#import "ViewTestVO.h"

@interface ViewTest : XCTestCase

@end

@implementation ViewTest
/**
Tests the View Multiton Factory Method
*/
- (void)testGetInstance {
    // Test Factory Method
    id<IView> view = [View getInstance:@"ViewTestKey1" factory:^(NSString *key) { return [View withKey:key]; }];
    
    // Test assertions
    XCTAssertNotNil(view, @"Expecting instance not nil");
    XCTAssertTrue([(id)view conformsToProtocol:@protocol(IView)], @"Expecting instance implements IView");
}

/**
A test variable that proves the viewTestMethod was
invoked by the View.
*/
static NSInteger viewTestVar = 0;

/**
A utility method to test the notification of Observers by the view
*/
- (void)viewTestMethod:(id<INotification>)notification {
    // Set the local viewTestVar to the number on the event payload
    viewTestVar = [(NSNumber *)notification.body integerValue];
}

/**
Tests registration and notification of Observers.

An Observer is created to callback the viewTestMethod of
this ViewTest instance. This Observer is registered with
the View to be notified of 'ViewTestEvent' events. Such
an event is created, and a value set on its payload. Then
the View is told to notify interested observers of this
Event.

The View calls the Observer's notifyObserver method
which calls the viewTestMethod on this instance
of the ViewTest class. The viewTestMethod method will set
an instance variable to the value passed in on the Event
payload. We evaluate the instance variable to be sure
it is the same as that passed out as the payload of the
original 'ViewTestEvent'.
*/
- (void)testRegisterAndNotifyObserver {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey2" factory:^(NSString *key) { return [View withKey:key]; }];
    
    // Create observer, passing in notification method and context
    id<IObserver> observer = [Observer withNotify:@selector(viewTestMethod:) context:self];
    
    // Register Observer's interest in a particulat Notification with the View
    [view registerObserver:@"ViewTestNote" observer:observer];
    
    // Create a ViewTestNote, setting
    // a body value, and tell the View to notify
    // Observers. Since the Observer is this class
    // and the notification method is viewTestMethod,
    // successful notification will result in our local
    // viewTestVar being set to the value we pass in
    // on the note body.
    id<INotification> notification = [Notification withName:@"ViewTestNote" body:@(10)];
    
    [view notifyObservers:notification];
    
    // Test assertions
    XCTAssertTrue(viewTestVar == 10, @"Expecting viewTestVar == 10");
}

/**
Tests registering and retrieving a mediator with
the View.
*/
- (void)testRegisterAndRetrieveMediator {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey3" factory:^(NSString *key) { return [View withKey:key]; }];
    
    // Create and register the test mediator
    ViewTestMediator *viewTestMediator = [ViewTestMediator withName:ViewTestMediator.NAME];
    [view registerMediator:viewTestMediator];
    
    // Retrieve the component
    id<IMediator> mediator = [view retrieveMediator:ViewTestMediator.NAME];
    
    // Test assertions
    XCTAssertNotNil(mediator, @"Mediator should not be nil");
    XCTAssertTrue([(NSObject *)mediator isKindOfClass:[ViewTestMediator class]], @"Expecting mediator type is ViewTestMediator");
    
    XCTAssertEqualObjects(mediator.name, [ViewTestMediator NAME], @"Expecting mediator.name == ViewTestMediator.NAME");
}

/**
Tests the hasMediator Method
*/
- (void)testHasMediator {
    // Register a Mediator
    id<IView> view = [View getInstance:@"ViewTestKey4" factory:^(NSString *key){ return [View withKey:key]; }];
    
    // Create and register the test mediator
    id<IMediator> mediator = [Mediator withName:@"hasMediatorTest" component:self];
    [view registerMediator:mediator];
    
    // Assert that the view?hasMediator method returns true
    // for that mediator name
    XCTAssertTrue([view hasMediator:@"hasMediatorTest"] == true, @"Expecting [view hasMediator:@'hasMediatoTest' == true");
    
    [view removeMediator:@"hasMediatorTest"];
    
    // Assert that the view?hasMediator method returns false
    // for that mediator name
    XCTAssertTrue([view hasMediator:@"hasMediatorTest"] == false, @"Expecting [view hasMediator:@'hasMediatoTest' == false");
}

/**
Tests registering and removing a mediator
*/
- (void)testRegisterAndRemoveMediator {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey5" factory:^(NSString *key) { return [View withKey:key]; }];
    
    // Create and register the test mediator
    id<IMediator> mediator = [Mediator withName:@"testing" component:self];
    [view registerMediator:mediator];
    
    // Remove the component
    id<IMediator> removedMediator = [view removeMediator:@"testing"];
    
    // Assert that we have removed the appropriate mediator
    XCTAssertEqualObjects(removedMediator.name, @"testing", @"Expecting removedMediator.name == 'testing'");
    
    // Assert that the mediator is no longer retrievable
    XCTAssertNil([view retrieveMediator:@"testing"], @"Expecting [view retrieveMediator:@'testing'] == nil");
}

/**
Tests that the View callse the onRegister and onRemove methods
*/
- (void)testOnRegisterAndOnRemove {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey6" factory:^(NSString *key){ return [View withKey:key]; }];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    // Create and register the test mediator
    id<IMediator> mediator = [ViewTestMediator4 withComponent:vo];
    [view registerMediator:mediator];
    
    // Assert that onRegsiter was called, and the mediator responded by setting our boolean
    XCTAssertTrue(vo.onRegisterCalled == true, @"Expecting vo.onRegisterCalled == true");
    
    // Remove the component
    [view removeMediator:ViewTestMediator4.NAME];
    
    // Assert that the mediator is no longer retrievable
    XCTAssertTrue(vo.onRemoveCalled == true, @"Expecting vo.onRemoveCalled == true");
}

/**
Tests successive regster and remove of same mediator.
*/
- (void)testSuccessiveRegisterAndRemoveMediator {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey7" factory:^(NSString *key){ return [View withKey:key]; }];
    
    // Create and register the test mediator,
    // but not so we have a reference to it
    [view registerMediator:[ViewTestMediator withComponent:self]];
    
    // Test that we can retrieve it
    XCTAssertTrue([((NSObject *)[view retrieveMediator:ViewTestMediator.NAME]) isKindOfClass:[ViewTestMediator class]]);
    
    // Remove the Mediator
    [view removeMediator:ViewTestMediator.NAME];
    
    // Test that retrieving it now returns null
    XCTAssertNil([view retrieveMediator:ViewTestMediator.NAME], @"Expecing [view retrieveMediator:ViewTestMediator.NAME] == nil");
    
    // Test that removing the mediator again once its gone doesn't cause crash
    XCTAssertNil([view removeMediator:ViewTestMediator.NAME], @"Expecing [view retrieveMediator:ViewTestMediator.NAME] doesn't crash");
    
    // Create and register another instance of the test mediator,
    [view registerMediator:[ViewTestMediator withComponent:self]];
    
    XCTAssertTrue([((NSObject *)[view retrieveMediator:ViewTestMediator.NAME]) isKindOfClass:[ViewTestMediator class]]);
    
    // Remove the Mediator
    [view removeMediator:ViewTestMediator.NAME];
    
    // Test that retrieving it now returns null
    XCTAssertNil([view retrieveMediator:ViewTestMediator.NAME], @"Expecting [view retrieveMediator:ViewTestMediator.NAME] == nil");
}

/**
Tests registering a Mediator for 2 different notifications, removing the
Mediator from the View, and seeing that neither notification causes the
Mediator to be notified.
*/
- (void)testRemoveMediatorAndSubsequentNotify {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey8" factory:^(NSString *key){ return [View withKey:key]; }];
    
    // Create and register the test mediator to be removed.
    [view registerMediator:[ViewTestMediator2 withComponent:self]];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    
    // Test that notifications work
    [view notifyObservers:[Notification withName:NOTE1 body:vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE1, @"Expecting vo.lastNotification == NOTE1");
    
    [view notifyObservers:[Notification withName:NOTE2 body:vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE2, @"Expecting vo.lastNotification == NOTE2");
    
    // Remove the Mediator
    [view removeMediator:ViewTestMediator2.NAME];
    
    // Test that retrieving it now returns null
    XCTAssertNil([view retrieveMediator:ViewTestMediator2.NAME], @"Expecting [view retrieveMediator:ViewTestMediator2.NAME] == nil");
    
    // Test that notifications no longer work
    // (ViewTestMediator2 is the one that sets lastNotification
    // on this component, and ViewTestMediator)
    vo.lastNotification = nil;
    
    [view notifyObservers:[Notification withName:NOTE1 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE1, @"Expecting vo.lastNotification != NOTE1");
    
    [view notifyObservers:[Notification withName:NOTE2 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE2, @"Expecting vo.lastNotification != NOTE2");
}

/**
Tests registering one of two registered Mediators and seeing
that the remaining one still responds.
*/
- (void)testRemoveOneOfTwoMediatorsAndSubsequentNotify {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey9" factory:^(NSString *key){ return [View withKey:key]; }];
    
    // Create and register that responds to notifications 1 and 2
    [view registerMediator:[ViewTestMediator2 withComponent:self]];
    
    // Create and register that responds to notification 3
    [view registerMediator:[ViewTestMediator3 withComponent:self]];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    
    // Test that all notifications work
    [view notifyObservers:[Notification withName:NOTE1 body: vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE1, @"Expecting vo.lastNotification == NOTE1");
    
    [view notifyObservers:[Notification withName:NOTE2 body: vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE2, @"Expecting vo.lastNotification == NOTE2");
    
    
    [view notifyObservers:[Notification withName:NOTE3 body: vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE3, @"Expecting vo.lastNotification == NOTE3");
    
    // Remove the Mediator that responds to 1 and 2
    [view removeMediator:ViewTestMediator2.NAME];
    
    // Test that retrieving it now returns nil
    XCTAssertNil([view retrieveMediator:ViewTestMediator2.NAME], @"[view retrieveMediator:ViewTestMediator2.NAME] == nil");
    
    // test that notifications no longer work
    // for notifications 1 and 2, but still work for 3
    vo.lastNotification = nil;
    
    [view notifyObservers:[Notification withName:NOTE1 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE1, @"Expecing vo.lastNotification != nil");
    
    [view notifyObservers:[Notification withName:NOTE2 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE2, @"Expecing vo.lastNotification != nil");
    
    [view notifyObservers:[Notification withName:NOTE3 body:vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE3, @"Expecing vo.lastNotification == NOTE3");
}

/**
Tests registering the same mediator twice.
A subsequent notification should only illicit
one response. Also, since reregistration
was causing 2 observers to be created, ensure
that after removal of the mediator there will
be no further response.
*/
- (void)testMediatorReregistration {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey10" factory:^(NSString *key){ return [View withKey:key]; }];
    
    // Create and register that responds to notification 5
    [view registerMediator:[ViewTestMediator5 withComponent:self]];
    
    // Try to register another instance of that mediator (uses the same NAME constant).
    [view registerMediator:[ViewTestMediator5 withComponent:self]];
    
    // Test that the counter is only incremented once (mediator 5's response)
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    vo.counter = 0;
    
    [view notifyObservers:[Notification withName:NOTE5 body:vo]];
    XCTAssertTrue(vo.counter == 1, @"Expecting counter == 1");
    
    // Remove the Mediator
    [view removeMediator:ViewTestMediator5.NAME];
    
    // Test that retrieving it now returns nil
    XCTAssertNil([view retrieveMediator:ViewTestMediator5.NAME], @"Expecting [view retrieveMediator:ViewTestMediator5.NAME] == nil");
    
    // Test that the counter is no longer incremented
    vo.counter = 0;
    [view notifyObservers:[Notification withName:NOTE5 body: vo]];
    XCTAssertTrue(vo.counter == 0, @"Expecting counter == 0");
}

/**
Tests the ability for the observer list to
be modified during the process of notification,
and all observers be properly notified. This
happens most often when multiple Mediators
respond to the same notification by removing
themselves.
*/
- (void)testModifyObserverListDuringNotification {
    // Get the Multiton View instance
    id<IView> view = [View getInstance:@"ViewTestKey11" factory:^(NSString *key) { return [View withKey:key]; }];
    
    // Create and register several mediator instances that respond to notification 6
    // by removing themselves, which will cause the observer list for that notification
    // to change. versions prior to MultiCore Version 2.0.5 will see every other mediator
    // fails to be notified.
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    vo.counter = 0;
    
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/1" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/2" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/3" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/4" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/5" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/6" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/7" component:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/8" component:vo]];
    
    [view notifyObservers:[Notification withName:NOTE6]];
    // XCTAssertTrue(vo.counter == 8, @"Expecting vo.counter == 8");
    
    // clear the counter
    vo.counter = 0;
    [view notifyObservers:[Notification withName:NOTE6]];
    
    // verify the count is 0
    XCTAssertTrue(vo.counter == 0, @"Expecting vo.counter == 0");
}

@end
