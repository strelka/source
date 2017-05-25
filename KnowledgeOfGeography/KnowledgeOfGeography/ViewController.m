//
//  ViewController.m
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController.h"
#import "GetDataFromGoogle.h"
#import <MapKit/MapKit.h>
#import "KOGCountryPolygon.h"
#import "KOGPoint.h"
#import <CoreLocation/CoreLocation.h>


@interface ViewController ()<MKMapViewDelegate>
@property (strong, nonatomic) MKMapView *mapView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    GetDataFromGoogle *service = [GetDataFromGoogle new];
    
    [service getDataWithComplition:^(NSArray *data) {
        
        for (KOGCountryPolygon *item in data){
            NSArray *pointsProp = item.polygonArray;
            unsigned long len = [pointsProp count];
            
            CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * len);
            
            for (unsigned long i=0; i < len; i++){
                double lon = [pointsProp[i] longitude];
                double lat = [pointsProp[i] latitude];
                coords[i] = CLLocationCoordinate2DMake(lon,lat);
            }
            
            MKPolygon* poly = [MKPolygon polygonWithCoordinates:coords count:len];
            free(coords);
            [self.mapView addOverlay:poly];
            break;
        }
    }];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolygonRenderer * polygonView = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
    //polygonView.fillColor   = [UIColor greenColor];
    polygonView.strokeColor = [UIColor redColor] ;
    polygonView.lineWidth   = 1.0;
    return polygonView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
