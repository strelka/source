//
//  MainTabBarController.h
//  MFBankomats
//
//  Created by Jullia Sharaeva on 10.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLLocationManager;

@interface MFBTabBarController : UITabBarController
@property(strong, nonatomic) NSArray* poiAtm;
@property(strong, nonatomic) CLLocationManager *locationManager;
@end
