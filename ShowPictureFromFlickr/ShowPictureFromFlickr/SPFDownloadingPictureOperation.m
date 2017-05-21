//
//  SPFGetPictureOperation.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFDownloadingPictureOperation.h"
#import "SPFPicture.h"
@implementation SPFDownloadingPictureOperation

- (instancetype) initWithSPFPicture:(SPFPicture*)pic{
    self = [super init];
    if (self){
        _photoRecord = pic;
    }
    return self;
}

- (void) main{
    
    if (self.isCancelled) return;
    NSData *imageData = [NSData dataWithContentsOfURL:self.photoRecord.imgURL];
    if (self.isCancelled) return;
    if (imageData){
        self.photoRecord.image = [[UIImage alloc] initWithData:imageData];
        self.photoRecord.recordState = Downloaded;
    } else
    {
        self.photoRecord.recordState = Failed;
        //self.photoRecord.image =
    }
    
}
@end
