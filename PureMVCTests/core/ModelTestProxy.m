//
//  ModelTestProxy.m
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#import "ModelTestProxy.h"

NS_ASSUME_NONNULL_BEGIN

@implementation ModelTestProxy

+ (NSString *)NAME { return @"ModelTestProxy"; }
+ (NSString *)ON_REGISTER_CALLED { return @"onRegister called"; }
+ (NSString *)ON_REMOVE_CALLED { return @"onRemove called"; }

- (instancetype)init {
    self = [super initWithName:[ModelTestProxy NAME] data:@""];
    return self;
}

- (void)onRegister {
    self.data = [ModelTestProxy ON_REGISTER_CALLED];
}

- (void)onRemove {
    self.data = [ModelTestProxy ON_REMOVE_CALLED];
}

@end

NS_ASSUME_NONNULL_END
