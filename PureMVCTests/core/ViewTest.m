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

@interface ViewTest : XCTestCase

@property (nonatomic, copy) NSString *lastNotification;
@property (nonatomic, assign) BOOL onRegisterCalled;
@property (nonatomic, assign) BOOL onRemoveCalled;
@property (nonatomic, assign) int counter;

@end

static NSString * const NOTE1 = @"Notification1";
static NSString * const NOTE2 = @"Notification2";
static NSString * const NOTE3 = @"Notification3";
static NSString * const NOTE4 = @"Notification4";
static NSString * const NOTE5 = @"Notification5";
static NSString * const NOTE6 = @"Notification6";

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
    
    XCTAssertTrue([mediator.name isEqualToString:ViewTestMediator.NAME], @"Expecting mediator.name == ViewTestMediator.NAME");
}


@end
