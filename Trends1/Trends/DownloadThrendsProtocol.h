//
//  DownloadThrendsProtocol.h
//  Trends
//
//  Created by Jullia Sharaeva on 26.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DownloadThrendsProtocol <NSObject>
@property(nonatomic, copy) void(^successBlock)();
- (void) getDataThrendsWithComplitionBlock:(void(^)()) block;
- (void) getInfoWithComplitionBlock:(void(^)()) block;
@end
