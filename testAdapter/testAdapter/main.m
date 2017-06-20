//
//  main.m
//  testAdapter
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Raven.h"
#import "ravenAdapter.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Raven *raven = [Raven new];
        ravenAdapter *adapter = [[ravenAdapter alloc] initWithRaven:raven];
        
        [adapter sing];
        [adapter fly];
        
    }
    return 0;
}
