//
//  KOGCountryPolygon.m
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "KOGCountryPolygon.h"
#import "KOGPoint.h"
@implementation KOGCountryPolygon
-(instancetype) init{
    self = [super init];
    if (self){
        _polygonArray  = [[NSMutableArray alloc] init];
    
    }
    return self;

}
- (void) setPointToPolygon:(KOGPoint*)point{
    [_polygonArray addObject:point];
}


@end
