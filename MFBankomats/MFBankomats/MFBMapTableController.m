//
//  MFBMapTableController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBMapTableController.h"
#import <MapKit/MapKit.h>
#import "MFBAnnotation.h"

#import "MFBRouteViewController.h"
#import "MFBGetDataFromGoogle.h"

#import "AppDelegate.h"

@interface MFBMapTableController () <MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>
@property (nonatomic) MKCoordinateRegion region;
@property (nonatomic) NSArray<MFBAnnotation*> *poiArray;
@property (nonatomic, weak) UINavigationController *nav;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation MFBMapTableController
- (instancetype) initWithNavigationController:(UINavigationController*)nav{
    self = [super init];
    if (self){
        _nav = nav;
        _locationManager = ((AppDelegate *)[UIApplication sharedApplication].delegate).locationManager;
        _locationManager.delegate = self;
        _poiArray = [NSArray new];
    }
    return self;
}

- (CLLocationCoordinate2D) getCurrentUserCoordinate{
    return _locationManager.location.coordinate;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
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
//        _selectedPoi.coordinate = view.annotation.coordinate;
//        _selectedPoi.title = view.annotation.title;
        
        rvc.current = mapView.userLocation.location.coordinate;
        [_nav pushViewController:rvc animated:YES];
    }
}

- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    _region = mapView.region;
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    NSLog(@"regionDidChangeAnimated");
    
    MKCoordinateRegion newRegion;
    
    newRegion = mapView.region;
    
    if ((fabs(_region.span.latitudeDelta - newRegion.span.latitudeDelta) > 0.01)
        ||(fabs(_region.span.longitudeDelta - newRegion.span.longitudeDelta) > 0.01)) //{
        
        NSLog(@"change!");
    
        NSLog(@"%f-%f",newRegion.center.longitude, newRegion.center.latitude);
    
        [[MFBGetDataFromGoogle new] getDataforName:@"sberbank" andCord:newRegion.center andComplition:^(NSMutableArray *data) {
            if (data){
                NSMutableArray *pins = [[NSMutableArray alloc] initWithArray:[mapView annotations]];
                [mapView removeAnnotations:pins];
                pins = nil;
                [mapView addAnnotations:data];
                _poiArray = [mapView annotations];
                
            }
        }];
    //}
    [mapView setRegion:newRegion];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *TableIdentifier = @"TableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableIdentifier forIndexPath:indexPath];
    MFBAnnotation *annotation = _poiArray[indexPath.row];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:8];
    
    NSString *tl = [[NSString alloc] initWithFormat:@"%@", annotation.title];
    cell.textLabel.text = tl;
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_poiArray count];
}


@end
