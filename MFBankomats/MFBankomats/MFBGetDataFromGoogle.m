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
@end

@implementation MFBGetDataFromGoogle

-(void) getDataforName:(NSString*)name andCord:(CLLocationCoordinate2D)cord andComplition:(void(^)(NSArray* data)) block{

    MFBAnnotation* (^createPlace)(NSDictionary *json);
    
    createPlace = ^MFBAnnotation*(NSDictionary* json){
        //MFBAnnotation *newAnnotation = [MFBAnnotation new];
        //newAnnotation.title = (nil == json[@"vicinity"])? @"???":json[@"vicinity"];
        
        NSDictionary *location = json[@"geometry"][@"location"];
        CLLocationCoordinate2D placeCord;
        placeCord.latitude = [location[@"lat"] doubleValue];
        placeCord.longitude = [location[@"lng"] doubleValue];
        //[newAnnotation setCoordinate:placeCord];
        
        int isOpen;
        if (nil == json[@"opening_hours"])
            //newAnnotation.isOpen = 0;
            isOpen = 0;
        else
            //newAnnotation.isOpen = (([json[@"opening_hours"][@"open_now"] caseInsensitiveCompare:@"false"]) == NSOrderedSame)? -1:1;
            if (json[@"opening_hours"][@"open_now"])
                //newAnnotation.isOpen = -1;
                isOpen = -1;
            else
                //newAnnotation.isOpen = 1;
                isOpen = 1;
        
        MFBAnnotation* newAnnotation = [[MFBAnnotation alloc] initWithName:json[@"vicinity"] andCoordinate:placeCord andOpen:isOpen];
        return newAnnotation;
    };
    
    NSString *urlstrMain = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?";
    NSString *urlparam = [[NSString alloc] initWithFormat:@"location=%f, %f&radius=1000&type=atm&keyword=sberbank&key=AIzaSyBH1bZKSO75vNGvYTpBalunA7WYt09U4uY", cord.latitude, cord.longitude ];
    
    urlparam = [urlparam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString* webStringURL = [urlstrMain stringByAppendingString:urlparam];
    NSURL* url = [NSURL URLWithString:webStringURL];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        NSMutableArray *_resultRecords = [NSMutableArray new];
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
