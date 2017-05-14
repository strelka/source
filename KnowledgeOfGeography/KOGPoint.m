//
//  KOGPoint.m
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "KOGPoint.h"
#import <MapKit/MapKit.h>
@implementation KOGPoint
- (instancetype) initWithLat:(NSNumber*) latitude AndLong:(NSNumber*) longitude{
    self = [super init];
    if (self){
        _latitude  = [latitude doubleValue];
        _longitude = [longitude doubleValue];
    }
    return self;
}

@end
