//
//  threadNS.m
//  SumArray
//
//  Created by Jullia Sharaeva on 24.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "threadNS.h"

@interface threadNS()
@property (nonatomic) NSRange range;
@property (readonly) NSArray *array;
@end

@implementation threadNS
- (instancetype) initWithRange:(NSRange)prange ofArray:(NSArray*)parray{
    self = [super init];
    if (self){
        _array = parray;
        _range = prange;
        _isFin = NO;
    }
    return self;
}

- (void) main {
    _result = 0;
    for (NSUInteger i=_range.location; i<(_range.location+_range.length);++i) {
        _result = _result + [_array[i] integerValue];
    }
    [_cond lock];
    _isFin = YES;
    [_cond signal];
    [_cond unlock];
}

@end
