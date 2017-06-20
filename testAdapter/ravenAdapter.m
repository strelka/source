//
//  ravenAdapter.m
//  testAdapter
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import "ravenAdapter.h"
#import "Raven.h"
@interface ravenAdapter()
@property (nonatomic, strong) Raven *raven;
@end;

@implementation ravenAdapter
- (instancetype) initWithRaven:(Raven *)raven{
    self = [super init];
    if (self){
        _raven = raven;
    }
    return self;
}

- (void) fly{
    [_raven FlySeekAndDestroy];
}

- (void) sing{
    [_raven voice];
}
@end
