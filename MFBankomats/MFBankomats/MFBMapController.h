//
//  MSFMapController.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
@class poiAtmList;
@class MFBAnnotation;

@interface MFBMapController : UIViewController

@property(nonatomic, weak) NSArray* poiList;
@property(nonatomic, strong) MFBAnnotation* selectedPoi;

- (instancetype) initWithDelegate:(id)mapDelegate;

@end
