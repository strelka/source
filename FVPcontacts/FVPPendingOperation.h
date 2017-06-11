//
//  FVPPendingOperation.h
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FVPPendingOperation : NSObject
@property (strong, nonatomic) NSMutableDictionary<NSIndexPath*,NSOperation*> *downloadsInProgress;
@property (strong, nonatomic) NSOperationQueue *downloadQueue;
@end
