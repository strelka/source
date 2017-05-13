//
//  Philosopher.m
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "Philosopher.h"
#import "Spoon.h"

@implementation Philosopher

- (instancetype) initWithRightSpoon:(Spoon*) rightSpoon AndLeftSpoon:(Spoon*) leftSpoon{
    self = [super init];
    if (self){
        _leftSpoon = leftSpoon;
        _rightSpoon = rightSpoon;
    }
    return self;
}


-(void) main{
    [_leftSpoon up];
    NSLog(@"left spoon for %@ lock", self.name);
    [_rightSpoon up];
    NSLog(@"right spoon for %@ lock", self.name);
    [NSThread sleepForTimeInterval:2];
    NSLog(@"%@ - eating!", self.name);
    _isFull = YES;
    
    [_leftSpoon down];
    [_rightSpoon down];
    NSLog(@"left spoon for %@ anlock", self.name);
    NSLog(@"right spoon for %@ anlock", self.name);


}
@end
