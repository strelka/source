//
//  MFBPlace.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MFBPlace : NSObject <MKAnnotation>{
    CLLocationCoordinate2D coordinate;
}

@property(nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(id)initWithLocation:(CLLocationCoordinate2D) coord;
//@property (copy) NSString *name;
//@property (copy) NSString *address;
//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
//
//
//-(id)initWithName:(NSString*) name address:(NSString*) address coordinate:(CLLocationCoordinate2D)coordinate;
//-(MKMapItem*)mapItem;
@end
