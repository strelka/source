//
//  MSFMapController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBMapController.h"
#import "MFBGetDataFromGoogle.h"
#import <MapKit/MapKit.h>
#import "MFBMapViewDelegate.h"
#import "MFBGestureRecognizer.h"
#import "MFBTableViewController.h"
#import "MFBAnnotation.h"
#import "MFBRouteViewController.h"
#import "poiAtmList.h"

@interface MFBMapController ()<CLLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic, strong) id service;

@property(nonatomic, strong) MKMapView* mapView;
@property(nonatomic) CLLocationCoordinate2D currentCord;
@property(nonatomic) MKCoordinateRegion region;
@end

@implementation MFBMapController

-(instancetype) init{
    self = [super init];
    if (self){
        _locationManager = [CLLocationManager new];
        //_locationManager.
        if ([_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locationManager requestWhenInUseAuthorization];
        };
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if (self.mapView){
        if (nil !=[_selectedPoi title]){
            [self.mapView addAnnotation:_selectedPoi.annotationView.annotation];
            _region = MKCoordinateRegionMakeWithDistance(_selectedPoi.coordinate, 1000, 1000);
            [_mapView setRegion:_region animated:YES];
      //   _selectedPoi = nil;
        }
    }
}
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.showsUserLocation = YES;
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
   // _locationManager.startUpdatingLocation()
    
    //????????????
    //MFBMapViewDelegate *mapViewDelegate = [[MFBMapViewDelegate alloc] init];
    //self.mapView.delegate = mapViewDelegate;
    
    self.mapView.delegate = self;
    
    NSLog(@"%f", self.locationManager.location.coordinate.latitude);
    
    _currentCord = self.locationManager.location.coordinate;
    _region = MKCoordinateRegionMakeWithDistance(_currentCord, 2000, 2000);
    
    [_mapView setRegion:_region animated:YES];

    [self.view addSubview:self.mapView];
    [self initConstraints];
    _service = [MFBGetDataFromGoogle new];
    
    [_service getDataforName:@"sberbank" andCord:_region.center andComplition:^(NSMutableSet *data) {
        for (MFBAnnotation *item in data){
            [self.poiList addPoiObject:item];
            //[self.poiList.poi addObject:item];
            [self.mapView addAnnotation:item];
        }
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%@",  @([_poiList countOfPoi])]];
        
        NSLog(@"%lu", (unsigned long)[_poiList countOfPoi]);

    }];
    
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

-(void)mapView:(MKMapView *)mapView annotationView:(nonnull MKAnnotationView *)view calloutAccessoryControlTapped:(nonnull UIControl *)control
{
    if ([control tag] == 1){
        MFBRouteViewController *rvc = [MFBRouteViewController new];
        rvc.destination = view;
        _selectedPoi.coordinate = view.annotation.coordinate;
        _selectedPoi.title = view.annotation.title;
        
        rvc.current = mapView.userLocation.location.coordinate;
        [self.navigationController pushViewController:rvc animated:YES];
    }
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    NSLog(@"regionDidChangeAnimated");
    
    MKCoordinateRegion newRegion;
    newRegion.center = self.mapView.region.center;
    newRegion.span = self.mapView.region.span;
    
    if ((fabs(_region.span.latitudeDelta - newRegion.span.latitudeDelta) > 0.01)
        ||(fabs(_region.span.longitudeDelta - newRegion.span.longitudeDelta) > 0.01))
        
        NSLog(@"change!");
        _region = newRegion;
    
        NSLog(@"%f-%f",newRegion.center.longitude, newRegion.center.latitude);
    
        [_service getDataforName:@"sberbank" andCord:newRegion.center andComplition:^(NSMutableSet *data) {
            if (data){
                [data minusSet:self.poiList.poi];
                
                for (MFBAnnotation *item in data){
                    [self.poiList.poi addObject:item];
                    [self.mapView addAnnotation:item];
                }
                [[[[[self tabBarController] tabBar] items]
                  objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%@",  @([_poiList countOfPoi])]];
            }
            
        }];
}


@end;
