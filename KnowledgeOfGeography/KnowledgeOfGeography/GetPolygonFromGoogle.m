////
////  GetPolygonFromGoogle.m
////  KnowledgeOfGeography
////
////  Created by Jullia Sharaeva on 14.05.17.
////  Copyright © 2017 Julia Sharaeva. All rights reserved.
////
//
//
//https://www.googleapis.com/fusiontables/v1/query?sql=SELECT name, kml_4326 FROM 1foc3xO9DyfSIF6ofvN0kp2bxSfSeKog5FbdWdQ&callback=drawMap&key=AIzaSyAm9yWCV7JPCTHCJut8whOjARd7pwROFDQ
//
//#import "GetPolygonFromGoogle.h"
//
//@interface GetPolygonFromGoogle ()<NSURLSessionDataDelegate>
//@end
//@implementation GetPolygonFromGoogle
//
//-(void) getDataWithComplition:(void(^)(NSArray* data)) block{
//    
//    NSArray* (^createPolygon)(NSDictionary *json);
//    
//    createPolygon = ^NSArray*(NSDictionary* json){
//        //MFBAnnotation *newAnnotation = [MFBAnnotation new];
//        //newAnnotation.title = (nil == json[@"vicinity"])? @"???":json[@"vicinity"];
//        
//        NSDictionary *location = json[@"geometry"][@"location"];
//        CLLocationCoordinate2D placeCord;
//        placeCord.latitude = [location[@"lat"] doubleValue];
//        placeCord.longitude = [location[@"lng"] doubleValue];
//        //[newAnnotation setCoordinate:placeCord];
//        int isOpen;
//        if (nil == json[@"opening_hours"])
//            isOpen = 0;
//        else
//            isOpen = (json[@"opening_hours"][@"open_now"])? 1: -1;
//        
//        MFBAnnotation* newAnnotation = [[MFBAnnotation alloc] initWithName:json[@"vicinity"] andCoordinate:placeCord andisOpen:isOpen];
//        
//        return newAnnotation;
//    };
//    
//https://www.googleapis.com/fusiontables/v1/query?sql=SELECT name, kml_4326 FROM 1foc3xO9DyfSIF6ofvN0kp2bxSfSeKog5FbdWdQ&callback=drawMap&key=AIzaSyAm9yWCV7JPCTHCJut8whOjARd7pwROFDQ
//
//    NSString *urlstrMain = @"https://www.googleapis.com/fusiontables/v1/query?";
//    NSString *urlparam = [[NSString alloc] initWithFormat:@"lsql=SELECT name, kml_4326 FROM 1foc3xO9DyfSIF6ofvN0kp2bxSfSeKog5FbdWdQ&callback=drawMap&key=AIzaSyAm9yWCV7JPCTHCJut8whOjARd7pwROFDQ", cord.latitude, cord.longitude ];
//    
//    urlparam = [urlparam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    
//    NSString* webStringURL = [urlstrMain stringByAppendingString:urlparam];
//    NSURL* url = [NSURL URLWithString:webStringURL];
//    
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
//    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSError* jsonError;
//        NSMutableSet *_resultRecords = [NSMutableSet new];
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
//    
//}
//@end
