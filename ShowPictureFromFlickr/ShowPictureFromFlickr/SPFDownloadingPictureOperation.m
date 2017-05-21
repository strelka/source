//
//  SPFGetPictureOperation.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDownloadingPictureOperation.h"
#import "SPFPicture.h"
@interface SPFDownloadingPictureOperation()
@property(nonatomic, copy) void(^successBlock)();
@end
@implementation SPFDownloadingPictureOperation

- (instancetype) initWithSPFPicture:(SPFPicture*)pic andComplition:(void(^)()) block{
    self = [super init];
    if (self){
        _photoRecord = pic;
        _successBlock = block;
    }
    return self;
}

- (void) main{
    [self startTaskGetImageFromURL:_photoRecord.imgURL];
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
    self.photoRecord.image = [[UIImage alloc] initWithData:imageData];
    self.photoRecord.recordState = Downloaded;
    self.successBlock();
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    NSLog(@"%lld, %lld, %lld" , bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
    self.photoRecord.downloadedPart = (double)totalBytesWritten /  (double)totalBytesExpectedToWrite;
    self.updateProgressBarBlock();
}



@end
