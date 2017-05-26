//
//  getThrendsFromYouTube.h
//  Trends
//
//  Created by Jullia Sharaeva on 26.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadThrendsProtocol.h"
@interface getThrendsFromYouTube : NSObject<DownloadThrendsProtocol, NSURLSessionDataDelegate>
@property(nonatomic, copy) void(^successBlock)();
- (void) getDataThrendsWithComplitionBlock:(void (^)())block;

@end
