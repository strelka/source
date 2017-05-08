//
//  ViewController.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 07.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "ViewController.h"
@import GooglePlaces;

@interface ViewController ()// <CLLocationManagerDelegate>

@end

@implementation ViewController{
    CLLocationManager *locationManager;
    GMSPlacesClient *_placesClient;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _placesClient = [GMSPlacesClient sharedClient];
//    locationManager = [CLLocationManager new];
//    //[manager requestAlwaysAuthorization];
//    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [locationManager requestWhenInUseAuthorization];
//    }
//    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList * _Nullable likelihoodList, NSError * _Nullable error) {
//        if (error != nil){
//            NSLog(@"error %@", [error localizedDescription]);
//        
//        } else
//        {
//            if (likelihoodList != nil){
//                GMSPlace *place = [[[likelihoodList likelihoods] firstObject]place];
//                if (place != nil){
//                    NSLog(@"%@", place.name);
//                    NSLog(@"%@", [[place.formattedAddress componentsSeparatedByString:@", "]
//                                  componentsJoinedByString:@"\n"]);
//                    
//                }
//            
//            }
//        }
 //   }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
