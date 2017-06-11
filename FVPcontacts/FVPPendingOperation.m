//
//  FVPPendingOperation.m
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "FVPPendingOperation.h"

@implementation FVPPendingOperation
- (NSOperationQueue *)downloadQueue{
    self.downloadQueue = [[NSOperationQueue alloc] init];
    _downloadQueue.name = @"Download queue";
    _downloadQueue.maxConcurrentOperationCount = 10;
    return _downloadQueue;
}

@end
