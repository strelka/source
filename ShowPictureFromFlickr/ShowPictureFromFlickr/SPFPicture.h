//
//  SPFPicture.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, spfRecordState){
    New = 1,
    Downloaded = 2,
    Filtered = 3,
    Failed = 4
    };

@interface SPFPicture : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSURL *imgURL;
@property (nonatomic) spfRecordState recordState;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) float downloadedPart;

- (instancetype) initWithUrl:(NSURL*)url;

@end
