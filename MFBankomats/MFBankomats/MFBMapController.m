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
#import <Masonry/Masonry.h>
#import "MFBMapViewDelegate.h"
#import "MFBTableViewController.h"
#import "MFBAnnotation.h"
#import "MFBRouteViewController.h"
#import "poiAtmList.h"

@interface MFBMapController ()<MKMapViewDelegate>

@property(nonatomic, strong) id service;

@property(nonatomic, strong) MKMapView* mapView;
@property(nonatomic) CLLocationCoordinate2D currentCord;
@property(nonatomic) MKCoordinateRegion region;

@property(nonatomic, strong) UIButton *btnZoomIn;
@property(nonatomic, strong) UIButton *btnZoomOut;
@property(nonatomic, strong) UIButton *btnCurrentLocation;

@end

@implementation MFBMapController

-(instancetype) initWithLocationManager:(CLLocationManager*)locationManager{
    self = [super init];
    if (self){
        _locationManager = locationManager;
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
        }
    }
}
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    
    _currentCord = self.locationManager.location.coordinate;
    _region = MKCoordinateRegionMakeWithDistance(_currentCord, 2000, 2000);
    
    [_mapView setRegion:_region animated:YES];

    [self.view addSubview:self.mapView];
    
    self.btnZoomIn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [_mapView addSubview:_btnZoomIn];
    
    self.btnZoomOut = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [_mapView addSubview:_btnZoomOut];
    
    self.btnCurrentLocation = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [_mapView addSubview:_btnCurrentLocation];
    
    
    [self initConstraints];
    _service = [MFBGetDataFromGoogle new];
    
    [_service getDataforName:@"sberbank" andCord:_region.center andComplition:^(NSMutableSet *data) {
        for (MFBAnnotation *item in data){
            [self.poiList addPoiObject:item];
            [self.mapView addAnnotation:item];
        }
        
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:1] setBadgeValue:[NSString stringWithFormat:@"%@",  @([_poiList countOfPoi])]];
        
        NSLog(@"%lu", (unsigned long)[_poiList countOfPoi]);

    }];
    
    [_btnZoomIn addTarget:self action:@selector(zoomInButton) forControlEvents:UIControlEventTouchDown];
    [_btnZoomOut addTarget:self action:@selector(zoomOutButton) forControlEvents:UIControlEventTouchDown];
    [_btnCurrentLocation addTarget:self action:@selector(setCurrentUsersLocation) forControlEvents:UIControlEventTouchDown];
    
    [_mapView setShowsScale:YES];
    [_mapView setShowsUserLocation:YES];

}

- (void)zoomInButton{
    NSLog(@"ZoomIn");
    MKCoordinateRegion newregion;
    newregion.center = _region.center;
    newregion.span.latitudeDelta = _region.span.latitudeDelta/2;
    newregion.span.longitudeDelta = _region.span.longitudeDelta/2;
    [_mapView setRegion:newregion];
}

- (void)zoomOutButton{
    NSLog(@"ZoomOut");
    MKCoordinateRegion newregion;
    newregion.center = _region.center;
    newregion.span.latitudeDelta = _region.span.latitudeDelta*2;
    newregion.span.longitudeDelta = _region.span.longitudeDelta*2;
    [_mapView setRegion:newregion];
}

- (void) setCurrentUsersLocation{
    NSLog(@"currentLocation");
    MKCoordinateRegion newregion;
    newregion.span.latitudeDelta = _region.span.latitudeDelta;
    newregion.span.longitudeDelta = _region.span.longitudeDelta;
    newregion.center = self.locationManager.location.coordinate;
    [_mapView setRegion:newregion];

}

-(void)initConstraints
{
    self.mapView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.btnZoomOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-40);
        make.left.equalTo(self.view.mas_left).with.offset(10);
    }];
    
    [self.btnZoomIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-80);
        make.left.equalTo(self.view.mas_left).with.offset(10);
    }];
    
    [self.btnCurrentLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottomLayoutGuideTop).with.offset(-140);
        make.left.equalTo(self.view.mas_left).with.offset(10);
    }];
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
