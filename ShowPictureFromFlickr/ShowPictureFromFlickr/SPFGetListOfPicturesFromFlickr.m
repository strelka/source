//
//  SPFGetListOfPicturesFromFlickr.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 21.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFGetListOfPicturesFromFlickr.h"
#import "SPFPicture.h"
@implementation SPFGetListOfPicturesFromFlickr


- (void) getPicturesListByParam:(NSDictionary*)param WithComplitionBlock:(void(^)(NSArray *data)) block{
    
    SPFPicture*(^createPicture)(NSDictionary *json);
    createPicture = ^SPFPicture*(NSDictionary* json){
        
        NSString *rec = [[NSString alloc] initWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_h.jpg", json[@"farm"],
                         json[@"server"],
                         json[@"id"],
                         json[@"secret"]];
        NSString *url = [rec stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        SPFPicture *record = [[SPFPicture alloc] initWithUrl:[[NSURL alloc]initWithString:url]];
        return record;
    };
    
    NSMutableArray *resultRecords = [NSMutableArray new];
    NSString *urlstr = [[NSString alloc] initWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&text=%@&page=%@&per_page=1&api_key=c55f5a419863413f77af53764f86bd66&format=json&nojsoncallback=1" , param[@"textForSearch"],
                                                                                                                                         param[@"page"]];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        if (data) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            NSDictionary *jsonRecords = json[@"photos"][@"photo"];
            
            if (jsonRecords){
                for (NSDictionary* recordItem in jsonRecords){
                    [resultRecords addObject:createPicture(recordItem)];
                }
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(resultRecords);
                });
            }
        }
    }] resume];
    
}

@end
