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
#import "MFBAnnotation.h"

@interface MSFMapController ()<MKMapViewDelegate, CLLocationManagerDelegate>

@property(nonatomic, strong) CLLocationManager* locationManager;
@property(nonatomic, strong) MKMapView* mapView;
@property(nonatomic) CLLocationCoordinate2D currentCord;
@property(nonatomic, strong) NSArray* annotations;

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
    // Do any additional setup after loading the view, typically from a nib.
    [self initViews];
    MFBGetDataFromGoogle *service = [MFBGetDataFromGoogle new];
    [self initConstraints];

    [service getDataFromGoogleforName:@"sberbank" andCord:_currentCord andComplition:^(NSArray *data) {
        _annotations = data;
        [self addAllPins];
    }];
    
    
    //[self addAllPins];
}

-(void)initViews
{
    self.mapView = [[MKMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    //
    _currentCord.longitude = 37.609218;
    _currentCord.latitude = 55.7522200;
    
//    MKCoordinateRegion region = self.mapView.region;
//    region.center = CLLocationCoordinate2DMake(_currentCord.latitude, _currentCord.longitude);
//    region.span.longitudeDelta /= 1.0; // Bigger the value, closer the map view
//    region.span.latitudeDelta /= 1.0;
//    [self.mapView setRegion:region animated:NO]; // Choose if you want animate or not
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
    [_mapView addAnnotations:_annotations];
    
}

//-(void)addPinWithTitle:(NSString *)title AndCoordinate:(NSString *)strCoordinate
//{
//    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
//    
//    // clear out any white space
//    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    // convert string into actual latitude and longitude values
//    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
//    
//    double latitude = [components[0] doubleValue];
//    double longitude = [components[1] doubleValue];
//    
//    // setup the map pin with all data and add to map view
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//    
//    mapPin.title = title;
//    mapPin.coordinate = coordinate;
//    
//    [self.mapView addAnnotation:mapPin];
//}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0){
        _currentCord.longitude = location.coordinate.longitude;
        _currentCord.latitude = location.coordinate.latitude;
    };
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if ([annotation isKindOfClass:[MFBAnnotation class]])
    {
        MFBAnnotation *myLocation = (MFBAnnotation*) annotation;
        
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MyAnnotation"];
        
        if(annotationView == nil)
            annotationView = myLocation.annotationView;
        else
            annotationView.annotation = annotation;
        return annotationView;
    }
    else
        return nil;

}

@end;
