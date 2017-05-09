//
//  MFBMapViewDelegate.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 09.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MFBMapViewDelegate : NSObject<MKMapViewDelegate>
@property(strong, nonatomic) id service;
//@property(strong, nonatomic) MKMapView *mapView;
//@property(nonatomic) MKCoordinateRegion mapRegion;
//
//-(instancetype) initWithMapView:(MKMapView*)mapView;
//-(void)loadDataforName:(NSString*)name andCord:(CLLocationCoordinate2D)cord;

@end
