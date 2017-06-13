//
//  SPFPicture.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, spfImageState){
    New = 1,
    Downloaded = 2,
    Filtered = 3,
    Failed = 4,
    Paused = 5
};

@interface SPFPicture : NSObject

@property (nonatomic, strong) NSString *filterName;
@property (nonatomic, strong) NSURL *imgURL;
@property (nonatomic) spfImageState imageState;
@property (nonatomic) float loadedPart;


- (instancetype) initWithUrl:(NSURL*)url;
- (void) correctPictureState;
- (UIImage*) getImageFromCacheByUrl;
- (UIImage*) getFilteredImageFromCacheByUrl;

- (void) cachingPicture:(UIImage*)image;
- (void) cachingFiltererPicture:(UIImage*)image;



@end
