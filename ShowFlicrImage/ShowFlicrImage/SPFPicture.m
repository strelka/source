//
//  SPFPicture.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFPicture.h"
#import "NSURL+Caching.h"

@implementation SPFPicture

- (instancetype) initWithUrl:(NSURL*)url{
    self = [super init];
    if (self){
        _imgURL = url;
        _imageState = New;
        _countLikes = 0;
    }
    return self;
}

- (void) correctPictureState{
    if (_imageState == Downloaded){
        if (nil == [_imgURL getImageFromCache]){
            _imageState = New;
            NSLog(@"not filtered image in cache %@", _imgURL);
        } else{
            NSLog(@"get image from cache %@", _imgURL);
        }
    }
}

- (UIImage *)imageByCroppingImage:(UIImage *)image{
        double refWidth = CGImageGetWidth(image.CGImage);
        double refHeight = CGImageGetHeight(image.CGImage);
        
        double sqrSide = fmin(refWidth, refHeight);
        
        double x = (refWidth - sqrSide) / 2.0;
        double y = (refHeight - sqrSide) / 2.0;
        
        CGRect cropSqrt = CGRectMake(x, y, sqrSide, sqrSide);
        CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropSqrt);
        
        UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:0.0 orientation:UIImageOrientationUp];
        
        return cropped;
    }

//    UIGraphicsBeginImageContextWithOptions(CGSizeMake( cell.frame.size.width, cell.frame.size.height), NO, 0.0);
//    [tmpImg drawInRect: CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
//    UIImage *small = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImageView *cellImageView = [[UIImageView alloc] initWithImage:small];
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.clipsToBounds = YES;
//    [cell.contentView addSubview:cellImageView];}



@end
