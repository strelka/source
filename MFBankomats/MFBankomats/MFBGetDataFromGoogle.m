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

@interface MFBGetDataFromGoogle ()<NSURLSessionDataDelegate>
@property (strong, nonatomic) NSMutableArray *taskArray;
@property(nonatomic, copy) void(^successBlock)();

@end

@implementation MFBGetDataFromGoogle{
    int _finishedTaskCount;
    NSArray<MFBAnnotation*> *_points;
}

-(void) getDataforName:(NSString*)name andCord:(CLLocationCoordinate2D)cord andComplition:(void(^)(NSMutableSet* data)) block{

    MFBAnnotation* (^createPlace)(NSDictionary *json);
    
    createPlace = ^MFBAnnotation*(NSDictionary* json){
        NSDictionary *location = json[@"geometry"][@"location"];
        CLLocationCoordinate2D placeCord;
        placeCord.latitude = [location[@"lat"] doubleValue];
        placeCord.longitude = [location[@"lng"] doubleValue];
        int isOpen;
        if (nil == json[@"opening_hours"])
           isOpen = -1;
        else
            isOpen = ([json[@"opening_hours"][@"open_now"] boolValue] == YES)? 1:0;
        
        MFBAnnotation* newAnnotation = [[MFBAnnotation alloc] initWithName:json[@"vicinity"] andCoordinate:placeCord andisOpen:isOpen];
        
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
        NSMutableSet *_resultRecords = [NSMutableSet new];
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

- (void) getDistanceFromPoint:(CLLocation*)pointA ToPoints:(NSArray<MFBAnnotation*>*)points andComplition:(void(^)()) block{
    self.successBlock = block;
    _points = points;
    _finishedTaskCount = 0;
    NSString *urlstrMain = @"https://maps.googleapis.com/maps/api/directions/json?";
    NSURLSession *dataSession = [self createDataSession];
    
    for (MFBAnnotation *item in points){
        NSString *urlparam = [[NSString alloc] initWithFormat:@"origin=%f,%f&destination=%f,%f&key=%@",pointA.coordinate.latitude,
                              pointA.coordinate.longitude,
                              item.coordinate.latitude,
                              item.coordinate.longitude,
                              apiKey];
        
        urlparam = [urlparam stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString* webStringURL = [urlstrMain stringByAppendingString:urlparam];
        NSURL* url = [NSURL URLWithString:webStringURL];
        
        [self createDataTaskWithSession:dataSession AndUrl:url];
        
    }
    
}

- (NSURLSession*) createDataSession{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    _taskArray = [[NSMutableArray alloc] init];
    sessionConfig.timeoutIntervalForRequest=0;
    sessionConfig.timeoutIntervalForResource=0;
    NSURLSession *dataSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    return dataSession;
}

- (void) createDataTaskWithSession:(NSURLSession*)session AndUrl:(NSURL*)url{
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithURL:url];
    [_taskArray addObject:sessionDataTask];
    [sessionDataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    unsigned long taskIndx = [_taskArray indexOfObject:dataTask];
    NSLog(@"task %lu: finished!", taskIndx);
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    NSString *txt = [self getDistanceFromJson:json];
    //_points[taskIndx].carDistance = txt;
    
    _finishedTaskCount += 1;
    if ([_taskArray count] == _finishedTaskCount){
        dispatch_async(dispatch_get_main_queue(), self.successBlock);
    }
    
}

- (NSString *) getDistanceFromJson:(NSDictionary*)json{
    NSArray *dic = json[@"routes"];
    NSArray *legs = dic[0][@"legs"];
    NSDictionary *distance = legs[0][@"distance"];
    NSString *txt = distance[@"text"];
    return txt;
}


@end
