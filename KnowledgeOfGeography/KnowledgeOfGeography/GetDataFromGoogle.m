//
//  GetDataFromGoogle.m
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "GetDataFromGoogle.h"
#import <MapKit/MapKit.h>
#import "KOGPoint.h"
#import "KOGCountryPolygon.h"

@interface GetDataFromGoogle ()<NSURLSessionDataDelegate>
@end
@implementation GetDataFromGoogle
- (void) getDataWithComplition:(void(^)(NSArray* data)) block{
    
    KOGCountryPolygon*(^createPolygon)(NSArray *json);
    
    
    createPolygon = ^KOGCountryPolygon*(NSArray* json){
        NSString *countryName = json[0];
        KOGCountryPolygon *polygon = [[KOGCountryPolygon alloc] init];
        
        if (nil == json[1][@"geometry"]) {
            NSDictionary *partCord = json[1][@"geometries"];
            for (NSDictionary *itemGeo in partCord){
                NSDictionary *coordinates = itemGeo[@"coordinates"][0];
                for (NSArray* itemcord in coordinates){
                    KOGPoint *point = [[KOGPoint alloc] initWithLat:itemcord[0] AndLong:itemcord[1]];
                    [polygon setPointToPolygon:point];
                }
            }
        } else {
            nil;
//            
//            NSArray *coordinates = json[1][@"geometry"][@"coordinates"][0];
//        
//            for (NSArray* itemcord in coordinates){
//                KOGPoint *point = [[KOGPoint alloc] initWithLat:itemcord[0] AndLong:itemcord[1]];
//                [polygon setPointToPolygon:point];
//            }
       }
       polygon.name = countryName;
            
       return polygon;
    };
 
    NSString *urlstrMain = @"https://www.googleapis.com/fusiontables/v2/query?";
    NSString *urlparam = [[NSString alloc] initWithFormat:@"sql=SELECT name, kml_4326 FROM 1foc3xO9DyfSIF6ofvN0kp2bxSfSeKog5FbdWdQ&key=AIzaSyAm9yWCV7JPCTHCJut8whOjARd7pwROFDQ"];
    urlparam = [urlparam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString* webStringURL = [urlstrMain stringByAppendingString:urlparam];
    NSURL* url = [NSURL URLWithString:webStringURL];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        NSMutableArray *_resultRecords = [NSMutableArray new];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        NSDictionary *jsonResults = [json objectForKey:@"rows"];
        
        if (jsonResults){
            for (NSArray* resultItem in jsonResults){
                [_resultRecords addObject:createPolygon(resultItem)];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(_resultRecords);
            });

        }
        //
        
        
//        NSDictionary *datadict = [NSKeyedUnarchiver unarchiveObjectWithData:nsdata];
//        NSLog(@"test");
    }] resume];
    //        if (data){
    //            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    //            NSDictionary *jsonResults = [json objectForKey:@"results"];
    //            if (jsonResults){
    //                for (NSDictionary* resultItem in jsonResults){
    //                    [_resultRecords addObject:createPlace(resultItem)];
    //                }
    //            }
    //        }
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            block(_resultRecords);
    //        });
    //        
    //        
    //    }] resume];

}

@end
