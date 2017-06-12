//
//  UIImage+CroppingImage.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 12.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CroppingImage)
- (UIImage *)croppingImageByFrame:(CGRect)pFrame;
@end
