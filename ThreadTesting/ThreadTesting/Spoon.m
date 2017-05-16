//
//  Spoon.m
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "Spoon.h"

@implementation Spoon
- (instancetype) initWithName:(NSString *)name{
    self = [super init];
    if (self) {
        _name = name;
        _lock = [[NSLock alloc] init];
    }
    
    return self;
}

- (void) up{
   [_lock lock];
}

-(void) down {
    [_lock unlock];
}
@end
