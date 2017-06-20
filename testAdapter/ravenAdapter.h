//
//  ravenAdapter.h
//  testAdapter
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BirdProtocol.h"
@class Raven;

@interface ravenAdapter : NSObject<BirdProtocol>
- (instancetype) initWithRaven:(Raven*) raven;
@end
