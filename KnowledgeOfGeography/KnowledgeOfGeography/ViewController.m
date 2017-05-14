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
    
//    CLLocationCoordinate2D coords[22]; //malloc(sizeof(CLLocationCoordinate2D) * len);
//    
//    coords[0] = CLLocationCoordinate2DMake(24.245, 51.58);
//    coords[1] = CLLocationCoordinate2DMake(24.294, 51.757);
//    coords[2] =  CLLocationCoordinate2DMake(24.02, 51.794);
//    coords[3] =  CLLocationCoordinate2DMake(24.177, 52.577);
//    coords[4] =  CLLocationCoordinate2DMake(24.151, 53.404);
//    coords[5] =  CLLocationCoordinate2DMake(24.122, 54.008);
//    coords[6] =  CLLocationCoordinate2DMake(24.798, 54.693);
//    coords[7] =  CLLocationCoordinate2DMake(25.439, 55.439);
//    coords[8] =  CLLocationCoordinate2DMake(26.055, 56.071);
//    coords[9] =  CLLocationCoordinate2DMake(25.715, 56.261);
//    coords[10] =  CLLocationCoordinate2DMake(24.925, 56.397);
//    coords[11] =  CLLocationCoordinate2DMake(24.921, 55.886);
//    coords[12] =  CLLocationCoordinate2DMake(24.27, 55.804);
//    coords[13] =  CLLocationCoordinate2DMake(24.131, 55.981);
//    coords[14] =  CLLocationCoordinate2DMake(23.934, 55.529);
//    coords[15] = CLLocationCoordinate2DMake(23.525, 55.526);
//    coords[16] =  CLLocationCoordinate2DMake(23.111, 55.234);
//    coords[17] =  CLLocationCoordinate2DMake(22.708, 55.208);
//    coords[18] =  CLLocationCoordinate2DMake(22.497, 55.007);
//    coords[19] =  CLLocationCoordinate2DMake(23.001, 52.001);
//    coords[20] =  CLLocationCoordinate2DMake(24.014,51.618);
//    coords[21] =  CLLocationCoordinate2DMake(24.245, 51.58);

//    MKPolygon* poly = [MKPolygon polygonWithCoordinates:coords count:22];
//                free(coords);
//                [self.mapView addOverlay:poly];
//    
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
