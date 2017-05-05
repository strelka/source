//
//  SISGetInfoFromItunes.m
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SISComposition.h"
#import "SISGetInfoFromItunes.h"

@implementation SISGetInfoFromItunes

-(void) getDataFromItunes:(NSString*) searchString andComplition:(void(^)(NSArray* data, NSError* error)) block{
    
    SISComposition*(^createComposition)(NSDictionary *json);
    createComposition = ^SISComposition*(NSDictionary* json){
        SISComposition* record = [SISComposition new];
        record.artistName = json[@"artistName"];
        record.trackName = json[@"trackName"];
        record.collectionName = json[@"collectionName"];
        return record;
    };
    
    NSMutableArray *resultRecords = [NSMutableArray new];
    
    NSString *urlstr = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@" , searchString];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];

    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *jsonRecords = [json objectForKey:@"results"];
        for (NSDictionary* recordItem in jsonRecords){
            [resultRecords addObject:createComposition(recordItem)];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(resultRecords, error);
        });
     }] resume];
}

@end
