//
//  SPFGetPictureOperation.h
//  ShowPictureFromFlickr
//
//  Created by Jullia Sharaeva on 20.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

@class SPFPicture;
#import <Foundation/Foundation.h>

@interface SPFDownloadingPictureOperation : NSOperation
@property(strong, nonatomic) SPFPicture* photoRecord;
- (instancetype) initWithSPFPicture:(SPFPicture*)pic;
@end
