//
//  GetDataFromGoogle.h
//  KnowledgeOfGeography
//
//  Created by Jullia Sharaeva on 14.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDataFromGoogle : NSObject
- (void) getDataWithComplition:(void(^)(NSArray* data)) block;
@end
