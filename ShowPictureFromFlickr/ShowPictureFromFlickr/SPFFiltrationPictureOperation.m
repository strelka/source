//
//  SPFFiltrationImageOperation.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFFiltrationPictureOperation.h"
#import "SPFPicture.h"

@implementation SPFFiltrationPictureOperation
- (instancetype) initWithSPFPicture:(SPFPicture*)pic{
    self = [super init];
    if (self){
        _photoRecord = pic;
    }
    return self;
}


- (void) main{
    if (self.isCancelled) return;
    
    if (_photoRecord.recordState != Downloaded){
        return;
    }
    
    UIImage *filteredImage = [self applyFilterForImage:self.photoRecord.image];
    if (filteredImage) {
        self.photoRecord.image = filteredImage;
        self.photoRecord.recordState = Filtered;

    }
}

- (UIImage *)applyFilterForImage:(UIImage*)image{
    CIImage *ciiImage = [[CIImage alloc] initWithImage:image];
    if (self.isCancelled) return nil;
    CIContext *context = [[CIContext alloc] initWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone"
                                  keysAndValues:kCIInputImageKey, ciiImage, @"inputIntensity", @0.8, nil];
    CIImage *outputImage = [filter outputImage];
    if (self.isCancelled) return nil;
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    return newImage;
    
}
@end
