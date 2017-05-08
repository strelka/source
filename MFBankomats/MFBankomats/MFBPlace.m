//
//  MFBPlace.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBPlace.h"
#import <MapKit/MapKit.h>

@implementation MFBPlace
@synthesize coordinate;
-(id)initWithLocation:(CLLocationCoordinate2D)coord{
    self = [super init];
    if (self){
        coordinate = coord;
    }
    return self;

}
@end;
//-(NSDictionary*) getPlaces{
//    // Find out the path of place
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"palce" ofType:@"plist"];
//    // Load the file content and read the data into arrays
//    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
//    return dict;
//}
//
//-(id)initWithName:(NSString *)name address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate{
//    if ((self = [super init])) {
//        if ([name isKindOfClass:[NSString class]]) {
//            self.name = name;
//        } else {
//            self.name = @"Unknown charge";
//        }
//        _address = address;
//        _coordinate = coordinate;
//    }
//    return self;
//}
//
//- (NSString *)title {
//    return _name;
//}
//
//-(MKMapItem*) mapItem{
//    
//    MKPlacemark *placemark = [[MKPlacemark alloc]
//                              initWithCoordinate:self.coordinate
//                              addressDictionary:self.address];
//    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
//    mapItem.name = self.title;
//    return mapItem;
//}
//@end
