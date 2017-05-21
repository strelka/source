//
//  SPFPicture.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFPicture.h"

@implementation SPFPicture

- (instancetype) initWithUrl:(NSURL*)url{
    self = [super init];
    if (self){
        _recordState = New;
        _imgURL = url;
        _downloadedPart = 0.0;
    }
    return self;
}
@end
