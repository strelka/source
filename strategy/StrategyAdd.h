//
//  StrategyAdd.h
//  strategy
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Strategy.h"
@interface StrategyAdd : NSObject<Strategy>
- (int) executeWithA:(int)A B:(int)B;
@end
