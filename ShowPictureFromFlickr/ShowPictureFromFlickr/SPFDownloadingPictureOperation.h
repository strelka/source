//
//  SPFGetPictureOperation.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

@class SPFPicture;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SPFDownloadingPictureOperation : NSOperation<NSURLSessionDelegate>
@property (nonatomic, strong) SPFPicture *photoRecord;
@property (nonatomic)BOOL isPaused;
@property (nonatomic, copy) void(^updateProgressBarBlock)();

- (instancetype) initWithSPFPicture:(SPFPicture*)pic andComplition:(void(^)()) block;
@end
