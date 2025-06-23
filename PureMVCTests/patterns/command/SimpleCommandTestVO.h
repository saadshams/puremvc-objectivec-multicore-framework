//
//  SimpleCommandTestVO.h
//  PureMVC Objective-C Multicore
//
//  Copyright(c) 2025 Saad Shams <saad.shams@puremvc.org>
//  Your reuse is governed by the BSD 3-Clause License
//

#ifndef SimpleCommandTestVO_h
#define SimpleCommandTestVO_h

NS_ASSUME_NONNULL_BEGIN

/**
A utility class used by SimpleCommandTest.

`@see SimpleCommandTest`

`@see SimpleCommandTestCommand`
*/
@interface SimpleCommandTestVO : NSObject

@property (nonatomic) int input;
@property (nonatomic) int result;

- (instancetype) initWithInput:(int)input;

@end

NS_ASSUME_NONNULL_END

#endif /* SimpleCommandTestVO_h */
