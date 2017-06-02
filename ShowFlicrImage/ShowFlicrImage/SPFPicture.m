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
@end
