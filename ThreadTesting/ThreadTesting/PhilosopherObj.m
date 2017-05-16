//
//  PhilosopherObj.m
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "PhilosopherObj.h"
#import "Spoon.h"

@implementation PhilosopherObj

- (instancetype) initWithRightSpoon:(Spoon*) rightSpoon AndLeftSpoon:(Spoon*) leftSpoon{
    self = [super init];
    if (self){
        _leftSpoon = leftSpoon;
        _rightSpoon = rightSpoon;
    }
    return self;
}


-(void) eat{
    //[NSThread sleepForTimeInterval:3];
    [_leftSpoon up];
    NSLog(@"%@ took a %@ spoon", self.name, _leftSpoon.name);
    
    //[NSThread sleepForTimeInterval:3];
    [_rightSpoon up];
    NSLog(@"%@ took a %@ spoon", self.name, _rightSpoon.name);
    
    //[NSThread sleepForTimeInterval:3];
    NSLog(@"Obj %@ - eating!", self.name);
    _isFull = YES;
    
    //[NSThread sleepForTimeInterval:3];
    NSLog(@"%@ put a %@ spoon", self.name, _leftSpoon.name);
    [_leftSpoon down];
    
    //[NSThread sleepForTimeInterval:3];
    NSLog(@"%@ put a %@ spoon", self.name, _rightSpoon.name);
    [_rightSpoon down];
    
    
}
@end
