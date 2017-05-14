//
//  KOGPoint.h
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface KOGPoint : NSObject
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;

- (instancetype) initWithLat:(NSNumber*) latitude AndLong:(NSNumber*) longitude;

@end
