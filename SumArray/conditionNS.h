//
//  conditionNS.h
//  SumArray
//
//  Created by Jullia Sharaeva on 25.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface conditionNS : NSCondition
- (bool) checkCondition:(NSMutableArray*) arrayThreads;
@end
