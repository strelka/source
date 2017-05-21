//
//  PendingOperations.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFPendingOperations.h"

@implementation SPFPendingOperations

- (NSOperationQueue *)downloadQueue{
    self.downloadQueue = [[NSOperationQueue alloc] init];
    _downloadQueue.name = @"Download queue";
    _downloadQueue.maxConcurrentOperationCount = 1;
    return _downloadQueue;
}

- (NSOperationQueue *)filtrationQueue{
    self.filtrationQueue = [[NSOperationQueue alloc] init];
    _filtrationQueue.name = @"Image Filtration Queue";
    _filtrationQueue.maxConcurrentOperationCount = 1;
    return _filtrationQueue;
}
@end
