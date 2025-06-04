//
//  NotifierTest.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import <XCTest/XCTest.h>
#import "INotifier.h"
#import "Notifier.h"
#import "IFacade.h"
#import "Facade.h"
#import "INotification.h"
#import "Notification.h"
#import "NotifierTestCommand.h"
#import "NotifierTestVO.h"

@interface NotifierTest : XCTestCase

@end

@implementation NotifierTest

- (void)testNotifier {
    id<INotifier> notifier = [[Notifier alloc] init];
    [notifier initializeNotifier:@"NotifierTestKey1"];
    
    XCTAssertNotNil(notifier, @"Expecting instance not nil");
    XCTAssertTrue([(id)notifier conformsToProtocol:@protocol(INotifier)], @"Expecting instance implements INotifier");
}

- (void)testRegisterCommandAndSendNotification {
    id<INotifier> notifier = [[Notifier alloc] init];
    [notifier initializeNotifier:@"NotifierTestKey2"];
    
    [[notifier facade] registerCommand:@"NotifierTestNote" factory:^id<ICommand> { return [NotifierTestCommand command]; }];
    
    NotifierTestVO *vo = [[NotifierTestVO alloc] initWithInput:32];
    [[notifier facade] sendNotification:@"NotifierTestNote" body:vo];
    
    XCTAssertTrue(vo.result == 64, @"Expecting vo.result == 24");
}

@end
