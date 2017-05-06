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
    @property(nonatomic, strong) NSMutableArray* taskArray;
    @property(nonatomic, strong) NSMutableArray* resultRecords;
   // @property(nonatomic, copy) void(^successBlock)(NSArray* data) ;

@end


@implementation SISGetInfoFromItunes
{
    int _finishedTaskCount;

}

-(void) getDataFromItunes:(NSString*) searchString andComplition:(void(^)(NSArray* data)) block{
    
    _finishedTaskCount = 0;
    
    SISComposition*(^createComposition)(NSDictionary *json);
    createComposition = ^SISComposition*(NSDictionary* json){
        SISComposition* record = [SISComposition new];
        record.artistName = json[@"artistName"];
        record.trackName = json[@"trackName"];
        record.collectionName = json[@"collectionName"];
        record.artworkUrl = [NSURL URLWithString:json[@"artworkUrl100"]];
        return record;
    };
    
    NSString *urlstr = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/search?term=%@" , searchString];
    NSURL *url = [NSURL URLWithString:urlstr];
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError* jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSDictionary *jsonRecords = [json objectForKey:@"results"];
        
        if (jsonRecords){
            _resultRecords = [NSMutableArray new];
            for (NSDictionary* recordItem in jsonRecords){
                [_resultRecords addObject:createComposition(recordItem)];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                        block(_resultRecords);
                    });
        }
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


//-(NSURLSession*) createDownloadSession{
//    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
//    return downloadSession;
//}

//-(void) createDownloadTaskWithSession:(NSURLSession*)session AndUrl:(NSURL*)url{
//    NSURLSessionDownloadTask *sessionDownloadTask = [session downloadTaskWithURL:url];
//    [sessionDownloadTask resume];
//}

//- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
//    {
//    unsigned long taskIndx = [_taskArray indexOfObject:downloadTask];
//    NSLog(@"task %lu: finished!", taskIndx);
//    SISComposition *item = [_resultRecords objectAtIndex:taskIndx];
//    item.artworkUrl = [NSData dataWithContentsOfURL:location];
//    
//    _finishedTaskCount += 1;
//    if ([_taskArray count] == _finishedTaskCount) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//                        self.successBlock(_resultRecords);
//        });
//    
//    }

//}

@end

