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
@property (nonatomic, copy) void(^successBlock)();
@property (nonatomic, strong) NSData *resumeData;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@end
@implementation SPFDownloadingPictureOperation

- (instancetype) initWithSPFPicture:(SPFPicture*)pic andComplition:(void(^)()) block{
    self = [super init];
    if (self){
        _photoRecord = pic;
        _successBlock = block;
        _isPaused = NO;
    }
    return self;
}

- (void) main{
    if (self.isCancelled) return;
    if (!(_photoRecord.imageState == Paused)){
        [self startTaskGetImageFromURL:_photoRecord.imgURL];
    } else {
        [self startTaskGetImageFromResumeData];
    }
}

- (void) pause{
    NSLog(@"%@", self);
    
    if (_photoRecord.loadedPart != 0){
        _photoRecord.imageState = Paused;
        _isPaused = YES;
        [self cancel];
        [_task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            _resumeData = [[NSData alloc] initWithData:resumeData];
        }];
    }
}

- (instancetype) resume{
    SPFDownloadingPictureOperation *newOper = [[SPFDownloadingPictureOperation alloc] initWithSPFPicture:self.photoRecord
                                                                                           andComplition:self.successBlock];
    newOper.updateProgressBarBlock = self.updateProgressBarBlock;
    newOper.resumeData = _resumeData;
    return newOper;
}

//- (void)
- (void) startTaskGetImageFromURL:(NSURL*)url{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    _task = [downloadSession downloadTaskWithURL:url];
    [_task resume];
}

- (void) startTaskGetImageFromResumeData{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *downloadSession = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:nil];
    _task = [downloadSession downloadTaskWithResumeData:_resumeData];
    [_task resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    if (self.isCancelled) return;
    NSData *imageData = [NSData dataWithContentsOfURL:location];
    UIImage *tmpImg = [[UIImage alloc] initWithData:imageData];
    
    [_photoRecord cachingPicture:tmpImg];
    self.photoRecord.imageState = Downloaded;
    self.successBlock();
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    self.photoRecord.loadedPart = (double)totalBytesWritten /  (double)totalBytesExpectedToWrite;
    self.updateProgressBarBlock();
    if (self.isCancelled) return;

}



@end
