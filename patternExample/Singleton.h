//
//  Singleton.h
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject
+ (instancetype) new NS_UNAVAILABLE;
+ (instancetype) sharedInstance;
@end
