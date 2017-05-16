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
    _rightSpoon = rightSpoon;
    _leftSpoon = leftSpoon;
    return self;
}


-(void) main{
    [_leftSpoon up];
    NSLog(@" %@ lock", _leftSpoon.name);

    [_rightSpoon up];
    NSLog(@" %@ lock", _rightSpoon.name);
    
    int j = 0;
    for (int i = 0; i < 1000000; i++){
        j++;
    }
    NSLog(@"%@ - eating!", self.name);
    
    for (int i = 0; i < 1000000; i++){
        j++;
    }
    _isFull = YES;
    
    [_leftSpoon down];
    NSLog(@"%@ unlock", _leftSpoon.name);
    [_rightSpoon down];
    NSLog(@"%@ unlock", _rightSpoon.name);


}
@end
