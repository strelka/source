//
//  FVPGetDataFromVK.h
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FVPGetDataFromVK : NSObject<NSURLSessionDataDelegate>
- (void)getDataAndDoSuccessBlock:(void(^)(NSArray *)) successBlock;
@end
