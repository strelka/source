//
//  Spoon.m
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "Spoon.h"

@implementation Spoon

- (void) up{
   [_lock lock];
}

-(void) down {
    [_lock unlock];
}

@end
