//
//  Strategy.h
//  strategy
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Strategy <NSObject>
- (int) executeWithA:(int)A B:(int)B;
@end
