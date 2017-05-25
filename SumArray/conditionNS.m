//
//  conditionNS.m
//  SumArray
//
//  Created by Jullia Sharaeva on 25.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "conditionNS.h"
#import "threadNS.h"

@implementation conditionNS
- (bool) checkCondition:(NSMutableArray*) arrayThreads{
    bool result = true;
    for (threadNS *item in arrayThreads) {
        result = result & item.isFin;
    }
    return result;
}
@end
