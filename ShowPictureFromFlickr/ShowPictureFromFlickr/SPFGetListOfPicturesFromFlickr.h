//
//  SPFGetListOfPicturesFromFlickr.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 21.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPFGetListOfPicturesFromFlickr : NSObject
- (void) getPicturesListByName:(NSString*)name WithComplitionBlock:(void(^)(NSArray* data)) block;
@end
