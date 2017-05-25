//
//  SPFPicture.m
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "SPFPicture.h"
#import "NSCacheSingleton.h"
@implementation SPFPicture

- (instancetype) initWithUrl:(NSURL*)url{
    self = [super init];
    if (self){
        _imgURL = url;
        _imageState = New;
    }
    return self;
}

- (void) correctPictureState{
    if (_imageState == Filtered){
        if (nil == [self getFilteredImageFromCacheByUrl]){
            _imageState = Downloaded;
            NSLog(@"not image in cache %@", _imgURL);

        } else {
            NSLog(@"get filtered image from cache %@", _imgURL);
        }
    }
    if (_imageState == Downloaded){
        if (nil == [self getImageFromCacheByUrl]){
            _imageState = New;
            NSLog(@"not filtered image in cache %@", _imgURL);
        } else{
            NSLog(@"get image from cache %@", _imgURL);
        }
    }
}

- (void) cachingPicture:(UIImage*)image{
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@", _imgURL];
    [[NSCacheSingleton sharedCache].imageCache setObject:image forKey:urlString];
    NSLog(@"caching %@", _imgURL);
    }

- (void) cachingFiltererPicture:(UIImage*)image{
    NSString *filterString = [[NSString alloc] initWithFormat:@"filterer%@", _imgURL];
    [[NSCacheSingleton sharedCache].imageCache setObject:image forKey:filterString];
    NSLog(@"caching filterer %@", _imgURL);
}

- (UIImage*) getImageFromCacheByUrl{
    NSString *urlString = [[NSString alloc] initWithFormat:@"%@", _imgURL];
    return [[NSCacheSingleton sharedCache].imageCache objectForKey:urlString];
}

- (UIImage*) getFilteredImageFromCacheByUrl{
    NSString *filterString = [[NSString alloc] initWithFormat:@"filterer%@", _imgURL];
    return [[NSCacheSingleton sharedCache].imageCache objectForKey:filterString];
}
                    
@end
