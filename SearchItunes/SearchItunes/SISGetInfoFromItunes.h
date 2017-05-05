//
//  SISGetInfoFromItunes.h
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SISGetInfoFromItunes : NSObject
-(void) getDataFromItunes:(NSString*) searchString andComplition:(void(^)(NSArray* data, NSError* error)) block;
@end
