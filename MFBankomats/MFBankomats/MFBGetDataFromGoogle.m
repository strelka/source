//
//  MFBGetDataFromGoogle.m
//  MFBankomats
//
//  Created by Jullia Sharaeva on 08.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "MFBGetDataFromGoogle.h"
#import <MapKit/MapKit.h>
#import "MFBAnnotation.h"

const NSString * apiKey = @"AIzaSyBH1bZKSO75vNGvYTpBalunA7WYt09U4uY";

//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=55.75370903771494,37.61981338262558&radius=50000&type=atm&keyword=sberbank&key=AIzaSyBH1bZKSO75vNGvYTpBalunA7WYt09U4uY

@interface MFBGetDataFromGoogle ()<NSURLSessionDataDelegate>
@property(nonatomic, strong) NSMutableArray* resultRecords;
@end

@implementation MFBGetDataFromGoogle
-(void) getDataFromGoogleforName:(NSString*)name andCord:(CLLocationCoordinate2D)cord andComplition:(void(^)(NSArray* data)) block{
    
    MFBAnnotation* (^createPlace)(NSDictionary *json);
    
    createPlace = ^MFBAnnotation*(NSDictionary* json){
        NSString* text = json[@"vicinity"];
        NSDictionary *location = json[@"geometry"][@"location"];
        NSNumber *lat= location[@"lat"];
        NSNumber *lng= location[@"lng"];
        
        CLLocationCoordinate2D placeCord;
        placeCord.latitude = [lat doubleValue];
        placeCord.longitude = [lng doubleValue];
        MFBAnnotation *annotation = [[MFBAnnotation alloc] initWithTitle:@"1" location:placeCord];
        return annotation;
    };
    
    NSString *urlstrMain = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
    NSString *urlparam = @"location=55.752220, 37.609218&radius=5000&type=atm&keyword=sberbank&key=AIzaSyBH1bZKSO75vNGvYTpBalunA7WYt09U4uY";
    
    urlparam = [urlparam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString* webStringURL = [urlstrMain stringByAppendingString:urlparam];
    NSURL* url = [NSURL URLWithString:webStringURL];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        _resultRecords = [NSMutableArray new];
        if (data){
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *jsonResults = [json objectForKey:@"results"];
            if (jsonResults){
                for (NSDictionary* resultItem in jsonResults){
                    [_resultRecords addObject:createPlace(resultItem)];
                }
            }
       }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(_resultRecords);
        });
        
        
    }] resume];
    
}

@end
