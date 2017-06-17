//
//  getThrendsFromYouTube.m
//  Trends
//
//  Created by Jullia Sharaeva on 26.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import "getThrendsFromYouTube.h"
const NSString * apiKey = @"AIzaSyBH1bZKSO75vNGvYTpBalunA7WYt09U4uY";

@implementation getThrendsFromYouTube
- (void) getDataThrendsWithComplitionBlock:(void (^)())block{
   
    NSString *urlstr = [[NSString alloc] initWithFormat:@"https://www.googleapis.com/youtube/v3/videos?part=contentDetails&chart=mostPopular&regionCode=RU&maxResults=5&key=%@", apiKey];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        if (data) {
            NSLog(@"trends");
//            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
//            NSDictionary *jsonRecords = json[@"photos"][@"photo"];
//            
//            if (jsonRecords){
//                for (NSDictionary* recordItem in jsonRecords){
//                    [resultRecords addObject:createPicture(recordItem)];
//                }
//                
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    block(resultRecords);
//                });
//            }
        }
    }] resume];
    
    
}

- (void) getInfoWithComplitionBlock:(void (^)())block{
    nil;
}
@end
