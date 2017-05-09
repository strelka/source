//
//  MSFMapController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MSFMapController.h"
#import "MFBGetDataFromGoogle.h"
#import <MapKit/MapKit.h>
#import "MFBMapViewDelegate.h"
#import "MFBGestureRecognizer.h"
#import "MFBAnnotation.h"

@interface MSFMapController ()<CLLocationManagerDelegate, UIGestureRecognizerDelegate, MKMapViewDelegate>

@property(nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic, strong) MKMapView* mapView;
@property(nonatomic) CLLocationCoordinate2D currentCord;
@property(nonatomic, strong) NSArray* annotations;
@property(nonatomic) MKCoordinateRegion region;
@property(nonatomic, strong) MFBGestureRecognizer* tapInterceptor;

@end

@implementation MSFMapController

-(instancetype) init{
    self = [super init];
    if (self){
        _locationManager = [CLLocationManager new];
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        };
    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.showsUserLocation = YES;
    //MFBMapViewDelegate *mapViewDelegate = [[MFBMapViewDelegate alloc] init];
    //self.mapView.delegate = mapViewDelegate;
    self.mapView.delegate = self;
    
    _currentCord.longitude = 37.609218;
    _currentCord.latitude = 55.7522200;
    
    [self.view addSubview:self.mapView];
    [self initConstraints];

    float spanX = 0.5f;
    float spanY = 0.5f;
    _region.center.latitude = _currentCord.latitude;
    _region.center.longitude = _currentCord.longitude;
    _region.span.latitudeDelta = spanX;
    _region.span.longitudeDelta = spanY;
    
    [self.mapView setRegion:_region animated:NO];
    
    MFBGetDataFromGoogle *service = [MFBGetDataFromGoogle new];
    
    [service getDataforName:@"sberbank" andCord:_region.center andComplition:^(NSArray *data) {
        [self.mapView addAnnotations:data];
    }];
    
    _tapInterceptor = [[MFBGestureRecognizer alloc] init];
    __weak typeof(self)weakSelf = self;
    _tapInterceptor.touchesEndCallback = ^(NSSet *touches, UIEvent *event) {
        __strong typeof(self)self = weakSelf;
        MKCoordinateRegion newRegion;
        newRegion.center = self.mapView.region.center;
        newRegion.span = self.mapView.region.span;
        
        if ((fabs(_region.span.latitudeDelta - newRegion.span.latitudeDelta) > 0.01)
              ||(fabs(_region.span.longitudeDelta - newRegion.span.longitudeDelta) > 0.01))
            
            NSLog(@"change!");
            NSLog(@"%f-%f",newRegion.center.longitude, newRegion.center.latitude);
            [service getDataforName:@"sberbank" andCord:newRegion.center andComplition:^(NSArray *data) {
                [self.mapView addAnnotations:data];
            }];
    };
    [self.mapView addGestureRecognizer:_tapInterceptor];
    
}
    

-(void)initConstraints
{
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    id views = @{
                 @"mapView": self.mapView
                 };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mapView]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapView]|" options:0 metrics:nil views:views]];
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MFBAnnotation class]])
    {
        MKPinAnnotationView *pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MyAnnotation"];
        if (!pinView)
        {
            MFBAnnotation *myLocation = (MFBAnnotation*) annotation;
            pinView = myLocation.annotationView;
        }
        else {
            pinView.annotation = annotation;
        }
        return pinView;
    }
    return nil;
}
@end;
