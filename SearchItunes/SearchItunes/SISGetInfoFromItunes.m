//
//  SISGetInfoFromItunes.m
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SISComposition.h"
#import "SISGetInfoFromItunes.h"

@interface SISGetInfoFromItunes()
    @property(nonatomic, strong) NSMutableArray* resultRecords;

@end


@implementation SISGetInfoFromItunes

-(void) getDataFromItunes:(NSString*) searchString andComplition:(void(^)(NSArray* data)) block{
    
    SISComposition*(^createComposition)(NSDictionary *json);
    createComposition = ^SISComposition*(NSDictionary* json){
        SISComposition* record = [SISComposition new];
        record.artistName = json[@"artistName"];
        record.trackName = json[@"trackName"];
        record.trackPrice = json[@"trackPrice"];
        record.collectionCensoredName = json[@"collectionCensoredName"];
        record.artworkUrl = [NSURL URLWithString:json[@"artworkUrl100"]];
        return record;
    };
    
    NSString *urlstr = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/ru/search?term=%@&media=music&entity=musicTrack&attribute=songTerm&limit=200" , searchString];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        _resultRecords = [NSMutableArray new];
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSDictionary *jsonRecords = [json objectForKey:@"results"];
        
            if (jsonRecords){
                for (NSDictionary* recordItem in jsonRecords){
                    [_resultRecords addObject:createComposition(recordItem)];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            block(_resultRecords);
        });
        
     }] resume];
}

-(void) getImageFromItunes:(NSURL*) urlImg andComplition:(void(^)(NSURL* currentUrl, NSData* data)) block{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *downloadsession = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[downloadsession downloadTaskWithURL:urlImg completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [NSData dataWithContentsOfURL:location];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(urlImg, data);
        });
    }] resume];
}
@end

