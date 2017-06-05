//
//  SPFPicture.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SPFUser;

typedef NS_ENUM(NSInteger, spfImageState){
    New = 1,
    Downloaded = 2,
    Filtered = 3,
    Failed = 4
};

@interface SPFPicture : NSObject

@property (nonatomic, strong) NSURL *imgURL;
@property (nonatomic, strong) NSString *idImg;
@property (nonatomic, strong) SPFUser *owner;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *locality;
@property (nonatomic) int countLikes;
@property (nonatomic) long countViews;
@property (nonatomic) int countComments;


@property (nonatomic) spfImageState imageState;

- (instancetype) initWithUrl:(NSURL*)url;
- (void) correctPictureState;
@end
