//
//  MFBRouteViewController.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 11.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MFBAnnotation;

@interface MFBRouteViewController : UIViewController
@property(nonatomic) CLLocationCoordinate2D current;
@property(strong, nonatomic) MKAnnotationView *destination;
@end
