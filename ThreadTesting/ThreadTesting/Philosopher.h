//
//  Philosopher.h
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Spoon;

@interface Philosopher : NSThread
@property(nonatomic, strong) NSString* pholosopherName;
@property(nonatomic, strong) Spoon* leftSpoon;
@property(nonatomic, strong) Spoon* rightSpoon;
@property(nonatomic) BOOL isFull;
- (instancetype) initWithRightSpoon:(Spoon*) rightSpoon AndLeftSpoon:(Spoon*) leftSpoon;

@end
