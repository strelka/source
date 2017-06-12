//
//  UIImage+CroppingImage.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 12.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "UIImage+CroppingImage.h"

@implementation UIImage (CroppingImage)

- (UIImage *)croppingImageByFrame:(CGRect)pFrame{
    
    double koff = pFrame.size.width/pFrame.size.height;
    
    double refWidth = CGImageGetWidth(self.CGImage);
    double refHeight = CGImageGetHeight(self.CGImage);
    
    double newWidth = 0;
    double newHeight = 0;
    
    if (refWidth > koff*refHeight) {
        newHeight = refHeight;
        newWidth = (refHeight * pFrame.size.width)/pFrame.size.height;
    } else {
        newWidth = refWidth;
        newHeight = (refWidth * pFrame.size.height)/pFrame.size.width;
    }
    
    double x = (refWidth - newWidth) / 2.0;
    double y = (refHeight - newHeight) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, newWidth, newHeight);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:UIImageOrientationUp];
    return cropped;
}


@end
