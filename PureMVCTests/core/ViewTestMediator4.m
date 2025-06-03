//
//  ViewTestMediator4.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ViewTestMediator4.h"
#import "ViewTestVO.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ViewTestMediator4

+ (NSString *)NAME { return @"ViewTestMediato4"; }

- (void)onRegister {
    ((ViewTestVO *)self.view).onRegisterCalled = YES;
}

- (void)onRemove {
    ((ViewTestVO *)self.view).onRemoveCalled = YES;
}

@end

NS_ASSUME_NONNULL_END
