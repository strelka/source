//
//  poiAtmList.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MFBAnnotation;

@interface poiAtmList : NSObject
@property (nonatomic, strong) NSMutableArray *poi;
-(NSUInteger)countOfPoi;
-(void)addPoiObject:(MFBAnnotation *)object;
-(NSSet*)getPoiSet;


@end
