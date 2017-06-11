//
//  FVPGetImageByURL.h
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 11.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FVPGetImageByURL : NSOperation<NSURLSessionDelegate>
- (instancetype) initWithUrl:(NSURL*)url andComplitionBlock:(void(^)(NSData *data)) successBlock;
@end
