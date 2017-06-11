//
//  FVPGetImageByURL.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPGetImageByURL.h"
@interface FVPGetImageByURL()
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) void(^successBlock)(NSData *data);
@end
@implementation FVPGetImageByURL
- (instancetype) initWithUrl:(NSURL*)url andComplitionBlock:(void(^)(NSData *data)) successBlock{
    self = [super init];
    if (self){
        _successBlock = successBlock;
        _url = url;
    }
    return self;
}

- (void) main{
    [self startTaskGetImageFromURL:_url];
}

- (void) startTaskGetImageFromURL:(NSURL*)url{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *task = [downloadSession downloadTaskWithURL:url];
    [task resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    if (self.isCancelled) return;
    NSData *imageData = [NSData dataWithContentsOfURL:location];
    self.successBlock(imageData);
}

@end
