//
//  ViewTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "IView.h"
#import "View.h"
#import "IObserver.h"
#import "Observer.h"
#import "INotification.h"
#import "Notification.h"
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

- (void)testGetInstance {
    id<IView> view = [View getInstance:@"ViewTestKey1" factory:^(NSString *key) { return [View withKey:key]; }];
    
    XCTAssertNotNil(view, @"Expecting instance not nil");
    XCTAssertTrue([(id)view conformsToProtocol:@protocol(IView)], @"Expecting instance implements IView");
}

static NSInteger viewTestVar = 0;

- (void)viewTestMethod:(id<INotification>)notification {
    viewTestVar = [(NSNumber *)notification.body integerValue];
}

- (void)testRegisterAndNotifyObserver {
    id<IView> view = [View getInstance:@"ViewTestKey2" factory:^(NSString *key) { return [View withKey:key]; }];
    
    id<IObserver> observer = [Observer withNotify:@selector(viewTestMethod:) context:self];
    
    [view registerObserver:@"ViewTestNote" observer:observer];
    
    id<INotification> notification = [Notification withName:@"ViewTestNote" body:@(10)];
    
    [view notifyObservers:notification];
    
    XCTAssertTrue(viewTestVar == 10, @"Expecting viewTestVar == 10");
}

- (void)testRegisterAndRetrieveMediator {
    id<IView> view = [View getInstance:@"ViewTestKey3" factory:^(NSString *key) { return [View withKey:key]; }];
    
    ViewTestMediator *viewTestMediator = [ViewTestMediator withName:ViewTestMediator.NAME];
    [view registerMediator:viewTestMediator];
    
    id<IMediator> mediator = [view retrieveMediator:ViewTestMediator.NAME];
    
    XCTAssertNotNil(mediator, @"Mediator should not be nil");
    XCTAssertTrue([(NSObject *)mediator isKindOfClass:[ViewTestMediator class]], @"Expecting mediator type is ViewTestMediator");
    
    XCTAssertEqualObjects(mediator.name, [ViewTestMediator NAME], @"Expecting mediator.name == ViewTestMediator.NAME");
}

- (void)testHasMediator {
    id<IView> view = [View getInstance:@"ViewTestKey4" factory:^(NSString *key){ return [View withKey:key]; }];
    
    id<IMediator> mediator = [Mediator withName:@"hasMediatorTest" view:self];
    [view registerMediator:mediator];
    
    XCTAssertTrue([view hasMediator:@"hasMediatorTest"] == true, @"Expecting [view hasMediator:@'hasMediatoTest' == true");
    
    [view removeMediator:@"hasMediatorTest"];
    
    XCTAssertTrue([view hasMediator:@"hasMediatorTest"] == false, @"Expecting [view hasMediator:@'hasMediatoTest' == false");
}

- (void)testRegisterAndRemoveMediator {
    id<IView> view = [View getInstance:@"ViewTestKey5" factory:^(NSString *key) { return [View withKey:key]; }];
    
    id<IMediator> mediator = [Mediator withName:@"testing" view:self];
    [view registerMediator:mediator];
    
    id<IMediator> removedMediator = [view removeMediator:@"testing"];
    
    XCTAssertEqualObjects(removedMediator.name, @"testing", @"Expecting removedMediator.name == 'testing'");
    
    XCTAssertNil([view retrieveMediator:@"testing"], @"Expecting [view retrieveMediator:@'testing'] == nil");
}

- (void)testOnRegisterAndOnRemove {
    id<IView> view = [View getInstance:@"ViewTestKey6" factory:^(NSString *key){ return [View withKey:key]; }];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    id<IMediator> mediator = [ViewTestMediator4 withView:vo];
    [view registerMediator:mediator];
    
    XCTAssertTrue(vo.onRegisterCalled == true, @"Expecting vo.onRegisterCalled == true");
    
    [view removeMediator:ViewTestMediator4.NAME];
    
    XCTAssertTrue(vo.onRemoveCalled == true, @"Expecting vo.onRemoveCalled == true");
}

- (void)testSuccessiveRegisterAndRemoveMediator {
    id<IView> view = [View getInstance:@"ViewTestKey7" factory:^(NSString *key){ return [View withKey:key]; }];
    
    [view registerMediator:[ViewTestMediator withView:self]];
    
    XCTAssertTrue([((NSObject *)[view retrieveMediator:ViewTestMediator.NAME]) isKindOfClass:[ViewTestMediator class]]);
    
    [view removeMediator:ViewTestMediator.NAME];
    
    XCTAssertNil([view retrieveMediator:ViewTestMediator.NAME], @"Expecing [view retrieveMediator:ViewTestMediator.NAME] == nil");
    
    XCTAssertNil([view removeMediator:ViewTestMediator.NAME], @"Expecing [view retrieveMediator:ViewTestMediator.NAME] doesn't crash");
    
    [view registerMediator:[ViewTestMediator withView:self]];
    
    XCTAssertTrue([((NSObject *)[view retrieveMediator:ViewTestMediator.NAME]) isKindOfClass:[ViewTestMediator class]]);
    
    [view removeMediator:ViewTestMediator.NAME];
    
    XCTAssertNil([view retrieveMediator:ViewTestMediator.NAME], @"Expecting [view retrieveMediator:ViewTestMediator.NAME] == nil");
}

- (void)testRemoveMediatorAndSubsequentNotify {
    id<IView> view = [View getInstance:@"ViewTestKey8" factory:^(NSString *key){ return [View withKey:key]; }];
    
    [view registerMediator:[ViewTestMediator2 withView:self]];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    
    [view notifyObservers:[Notification withName:NOTE1 body:vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE1, @"Expecting vo.lastNotification == NOTE1");
    
    [view notifyObservers:[Notification withName:NOTE2 body:vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE2, @"Expecting vo.lastNotification == NOTE2");
    
    [view removeMediator:ViewTestMediator2.NAME];
    
    XCTAssertNil([view retrieveMediator:ViewTestMediator2.NAME], @"Expecting [view retrieveMediator:ViewTestMediator2.NAME] == nil");
    
    vo.lastNotification = nil;
    
    [view notifyObservers:[Notification withName:NOTE1 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE1, @"Expecting vo.lastNotification != NOTE1");
    
    [view notifyObservers:[Notification withName:NOTE2 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE2, @"Expecting vo.lastNotification != NOTE2");
}

- (void)testRemoveOneOfTwoMediatorsAndSubsequentNotify {
    id<IView> view = [View getInstance:@"ViewTestKey9" factory:^(NSString *key){ return [View withKey:key]; }];
    
    [view registerMediator:[ViewTestMediator2 withView:self]];
    
    [view registerMediator:[ViewTestMediator3 withView:self]];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    
    [view notifyObservers:[Notification withName:NOTE1 body: vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE1, @"Expecting vo.lastNotification == NOTE1");
    
    [view notifyObservers:[Notification withName:NOTE2 body: vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE2, @"Expecting vo.lastNotification == NOTE2");
    
    
    [view notifyObservers:[Notification withName:NOTE3 body: vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE3, @"Expecting vo.lastNotification == NOTE3");
    
    [view removeMediator:ViewTestMediator2.NAME];
    
    XCTAssertNil([view retrieveMediator:ViewTestMediator2.NAME], @"[view retrieveMediator:ViewTestMediator2.NAME] == nil");
    
    vo.lastNotification = nil;
    
    [view notifyObservers:[Notification withName:NOTE1 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE1, @"Expecing vo.lastNotification != nil");
    
    [view notifyObservers:[Notification withName:NOTE2 body:vo]];
    XCTAssertNotEqualObjects(vo.lastNotification, NOTE2, @"Expecing vo.lastNotification != nil");
    
    [view notifyObservers:[Notification withName:NOTE3 body:vo]];
    XCTAssertEqualObjects(vo.lastNotification, NOTE3, @"Expecing vo.lastNotification == NOTE3");
}

- (void)testMediatorReregistration {
    id<IView> view = [View getInstance:@"ViewTestKey10" factory:^(NSString *key){ return [View withKey:key]; }];
    
    [view registerMediator:[ViewTestMediator5 withView:self]];
    
    [view registerMediator:[ViewTestMediator5 withView:self]];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    vo.counter = 0;
    
    [view notifyObservers:[Notification withName:NOTE5 body:vo]];
    XCTAssertTrue(vo.counter == 1, @"Expecting counter == 1");
    
    [view removeMediator:ViewTestMediator5.NAME];
    
    XCTAssertNil([view retrieveMediator:ViewTestMediator5.NAME], @"Expecting [view retrieveMediator:ViewTestMediator5.NAME] == nil");
    
    vo.counter = 0;
    [view notifyObservers:[Notification withName:NOTE5 body: vo]];
    XCTAssertTrue(vo.counter == 0, @"Expecting counter == 0");
}

- (void)testModifyObserverListDuringNotification {
    id<IView> view = [View getInstance:@"ViewTestKey11" factory:^(NSString *key) { return [View withKey:key]; }];
    
    ViewTestVO *vo = [[ViewTestVO alloc] init];
    vo.counter = 0;
    
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/1" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/2" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/3" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/4" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/5" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/6" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/7" view:vo]];
    [view registerMediator:[ViewTestMediator6 withName:@"ViewTestMediator6/8" view:vo]];
    
    [view notifyObservers:[Notification withName:NOTE6]];
    // XCTAssertTrue(vo.counter == 8, @"Expecting vo.counter == 8");
    
    vo.counter = 0;
    [view notifyObservers:[Notification withName:NOTE6]];
    XCTAssertTrue(vo.counter == 0, @"Expecting vo.counter == 0");
}

@end
