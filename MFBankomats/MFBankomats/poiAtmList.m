//
//  poiAtmList.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "poiAtmList.h"
#import "MFBAnnotation.h"
@implementation poiAtmList
-(instancetype) init{
    self = [super init];
    _poi = [NSMutableArray new];
    return self;
}

-(void)addPoiObject:(MFBAnnotation *)object{
    [_poi addObject:object];
}

-(NSUInteger)countOfPoi{
    return [_poi count];
}

-(NSArray*)getPoiSet{
    return self.poi;
}

@end
