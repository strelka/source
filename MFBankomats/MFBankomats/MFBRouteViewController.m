//
//  MFBRouteViewController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 11.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import <MapKit/MapKit.h>
#import "MFBRouteViewController.h"

@interface MFBRouteViewController ()<MKMapViewDelegate>
@property(strong, nonatomic) MKMapView *routeMap;
@end

@implementation MFBRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _routeMap = [[MKMapView alloc] init];
    _routeMap.showsUserLocation = YES;
    _routeMap.delegate = self;
    [self.view addSubview:_routeMap];
    [self initConstraints];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(_current, 20000, 20000);
    [_routeMap setRegion:region animated:YES];
    [self getDirections];
    // Do any additional setup after loading the view.
}

-(void)initConstraints
{
    _routeMap.translatesAutoresizingMaskIntoConstraints = NO;
    
    id views = @{
                 @"mapView": _routeMap
                 };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mapView]|" options:0 metrics:nil views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mapView]|" options:0 metrics:nil views:views]];
}

-(void) getDirections
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = _destination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            if (error){
            
            }else{
                [self showRoute:response];
            }
    }];
}

-(void) showRoute:(MKDirectionsResponse*)response
{
    for (MKRoute *route in response.routes){
        [_routeMap addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}
@end
