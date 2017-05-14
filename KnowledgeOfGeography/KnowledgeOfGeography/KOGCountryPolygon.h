//
//  KOGCountryPolygon.h
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KOGPoint;

@interface KOGCountryPolygon : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableArray *polygonArray;

- (void) setPointToPolygon:(KOGPoint*)point;

@end
