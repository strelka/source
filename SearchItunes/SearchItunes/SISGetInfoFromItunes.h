//
//  SISGetInfoFromItunes.h
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SISGetInfoFromItunes : NSObject
-(void) getDataFromItunes:(NSString*) searchString andComplition:(void(^)(NSArray* data)) block;
-(void) getImageFromItunes:(NSURL*) urlImg andComplition:(void(^)(NSURL* currentUrl, NSData* data)) block;

@end
