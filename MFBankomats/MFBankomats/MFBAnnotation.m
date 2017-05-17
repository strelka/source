//
//  MFBAnnotation.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBAnnotation.h"
#import <MapKit/MapKit.h>
#import "MFBRouteViewController.h"

@implementation MFBAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate{
    _coordinate = newCoordinate;
}

- (void) getDistanceToThePoint:(CLLocation*)pointA inBackgroundQueue:(dispatch_queue_t) queue{
    CLLocation *selfLocation = [[CLLocation alloc] initWithLatitude:self.coordinate.latitude longitude:self.coordinate.longitude];
    [self getDistanceBetweenPointA:selfLocation AndPointB:pointA andTransportType:MKDirectionsTransportTypeAutomobile];
    [self getDistanceBetweenPointA:selfLocation AndPointB:pointA andTransportType:MKDirectionsTransportTypeWalking];
 }

- (void) getDistanceBetweenPointA:(CLLocation*)pointA AndPointB:(CLLocation*)pointB andTransportType:(MKDirectionsTransportType) type{
        MKPlacemark *source = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(pointA.coordinate.latitude,pointA.coordinate.longitude) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
        
        MKMapItem *srcMapItem = [[MKMapItem alloc]initWithPlacemark:source];
        [srcMapItem setName:@""];
        
        MKPlacemark *destination = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(pointB.coordinate.latitude, pointB.coordinate.longitude) addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"", nil] ];
        
        MKMapItem *distMapItem = [[MKMapItem alloc]initWithPlacemark:destination];
        [distMapItem setName:@""];
        
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
        [request setSource:srcMapItem];
        [request setDestination:distMapItem];
        [request setTransportType:type];
        
        MKDirections *direction = [[MKDirections alloc]initWithRequest:request];
    
        [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
            NSLog(@"response = %@",response);
            NSArray *arrRoutes = [response routes];
            [arrRoutes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                MKRoute *rout = obj;
                if (type == MKDirectionsTransportTypeAutomobile){
                    _carDistance = rout.distance;
                } else {
                    _walkingDistance = rout.distance;
                }
                NSLog(@"Total Distance (in Meters) :%f",rout.distance);
            }];
        }];
    }


-(instancetype) initWithName:(NSString*)name andCoordinate:(CLLocationCoordinate2D)cord andisOpen:(int)isOpen{
    self = [super init];
    if (self){
        _coordinate = cord;
        _title = name;
        if (isOpen == -1) _color = [UIColor lightGrayColor];
        if (isOpen == 1) _color = [UIColor greenColor];
        if (isOpen == 0) _color = [UIColor redColor];
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[MFBAnnotation class]]) {
        if ((self.coordinate.latitude == [(MFBAnnotation *)object coordinate].latitude)&&
            (self.coordinate.longitude == [(MFBAnnotation*) object coordinate].longitude)&&
            ([self.title isEqualToString:[(MFBAnnotation*) object title]])
            )
        return YES;
    }
    return NO;
}

- (NSUInteger)hash {
    NSString *hashstring = [[NSString alloc] initWithFormat:@"%f%f%@", self.coordinate.latitude,
                                                                       self.coordinate.longitude,
                                                                       self.title];
    return [hashstring hash];
}
    
-(MKPinAnnotationView *)annotationView
{
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:self reuseIdentifier:@"MyAnnotation"];
    
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    annotationView.pinTintColor = _color;
    
    UIButton *drawRouteBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeInfoLight];
    
    drawRouteBtn.tag = 1;
    infoBtn.tag = 2;
    
    annotationView.rightCalloutAccessoryView = drawRouteBtn;
    annotationView.leftCalloutAccessoryView = infoBtn;
    
    return annotationView;
}

@end
