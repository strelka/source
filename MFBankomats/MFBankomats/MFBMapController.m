 //
//  MSFMapController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Masonry/Masonry.h>
#import "MFBMapController.h"
#import "MFBTableViewController.h"

#import "MFBAnnotation.h"

#import "MFBMapTableController.h"

@interface MFBMapController ()

@property(nonatomic, strong) MKMapView* mapView;
@property(nonatomic) CLLocationCoordinate2D currentCord;
@property(nonatomic) MKCoordinateRegion region;

@property(nonatomic, strong) UIButton *btnZoomIn;
@property(nonatomic, strong) UIButton *btnZoomOut;
@property(nonatomic, strong) UIButton *btnCurrentLocation;

@property(nonatomic, strong) CLLocationManager *locationManager;

@property(nonatomic, weak) id mapDelegate;

@end

@implementation MFBMapController

- (instancetype) initWithDelegate:(id)mapDelegate{
    self = [super init];
    if (self) {
        _mapDelegate = mapDelegate;
    }
    return self;
}

//-(void) viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    
//    if (self.mapView){
//        if (nil !=[_selectedPoi title]){
//            [self.mapView addAnnotation:_selectedPoi.annotationView.annotation];
//            _region = MKCoordinateRegionMakeWithDistance(_selectedPoi.coordinate, 1000, 1000);
//            [_mapView setRegion:_region animated:YES];
//        }
//    }
//}


-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc] init];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = _mapDelegate;
    
    _currentCord = [_mapDelegate getCurrentUserCoordinate];
    _region = MKCoordinateRegionMakeWithDistance(_currentCord, 1000, 1000);
    [_mapView setRegion:_region animated:YES];

    [self.view addSubview:self.mapView];
    
    self.btnZoomIn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnZoomIn setImage:[UIImage imageNamed:@"inBtn"] forState:UIControlStateNormal];
    [_mapView addSubview:_btnZoomIn];
    
    self.btnZoomOut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnZoomOut setImage:[UIImage imageNamed:@"outBtn"] forState:UIControlStateNormal];
    [_mapView addSubview:_btnZoomOut];
    
    self.btnCurrentLocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnCurrentLocation setImage:[UIImage imageNamed:@"currentLoc"] forState:UIControlStateNormal];
    [_mapView addSubview:_btnCurrentLocation];
    
    
    [self initConstraints];
    
    [_btnZoomIn addTarget:self action:@selector(zoomInButton) forControlEvents:UIControlEventTouchDown];
    [_btnZoomOut addTarget:self action:@selector(zoomOutButton) forControlEvents:UIControlEventTouchDown];
    [_btnCurrentLocation addTarget:self action:@selector(setCurrentUsersLocation) forControlEvents:UIControlEventTouchDown];
    
    [_mapView setShowsScale:YES];
    [_mapView setShowsUserLocation:YES];

}

- (void)zoomInButton{
    NSLog(@"ZoomIn");
    _region.span.latitudeDelta /=2;
    _region.span.longitudeDelta /=2;
    [_mapView setRegion:_region];
}

- (void)zoomOutButton{
    NSLog(@"ZoomOut");
    _region.span.latitudeDelta *=2;
    _region.span.longitudeDelta *=2;
    [_mapView setRegion:_region];
}

- (void) setCurrentUsersLocation{
    NSLog(@"currentLocation");
    _region.center = [_mapDelegate getCurrentUserCoordinate];
    [_mapView setRegion:_region];

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





@end;
