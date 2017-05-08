//
//  MSFMapController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MSFMapController.h"
#import "MFBPlace.h"
#import <MapKit/MapKit.h>

@interface MSFMapController ()<MKMapViewDelegate>
@property(nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic, strong) MKMapView* mapView;

@end

@implementation MSFMapController
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


-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initViews];
    [self initConstraints];
    
    [self addAllPins];
}

-(void)initViews
{
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    MKCoordinateRegion region = self.mapView.region;
    region.center = CLLocationCoordinate2DMake(12.9752297537231, 80.2313079833984);
    region.span.longitudeDelta /= 1.0; // Bigger the value, closer the map view
    region.span.latitudeDelta /= 1.0;
    [self.mapView setRegion:region animated:NO]; // Choose if you want animate or not
    [self.view addSubview:self.mapView];
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

-(void)addAllPins
{
    self.mapView.delegate=self;
    
    NSArray *name=[[NSArray alloc]initWithObjects:
                   @"1",
                   @"2",
                   @"3",
                   @"4",
                   @"5",
                   nil
                   ];
    
    NSMutableArray *arrCoordinateStr = [[NSMutableArray alloc] initWithCapacity:name.count];
    
    
    [arrCoordinateStr addObject:@"55.8210737, 37.604511"];
    [arrCoordinateStr addObject:@"55.5771014, 38.2480002"];
    [arrCoordinateStr addObject:@"55.746208, 38.022811"];
    [arrCoordinateStr addObject:@"55.907199, 37.459048"];
    [arrCoordinateStr addObject:@"55.7596913, 37.6289863"];

    
    for(int i = 0; i < name.count; i++)
    {
        [self addPinWithTitle:name[i] AndCoordinate:arrCoordinateStr[i]];
    }
}

-(void)addPinWithTitle:(NSString *)title AndCoordinate:(NSString *)strCoordinate
{
    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
    
    // clear out any white space
    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // convert string into actual latitude and longitude values
    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
    
    double latitude = [components[0] doubleValue];
    double longitude = [components[1] doubleValue];
    
    // setup the map pin with all data and add to map view
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    
    mapPin.title = title;
    mapPin.coordinate = coordinate;
    
    [self.mapView addAnnotation:mapPin];
}

@end;
