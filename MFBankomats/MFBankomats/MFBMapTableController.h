//
//  MFBMapTableController.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MFBMapTableController : NSObject
- (instancetype) initWithNavigationController:(UINavigationController*)nav;

- (CLLocationCoordinate2D) getCurrentUserCoordinate;
@end
