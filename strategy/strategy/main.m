//
//  main.m
//  strategy
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Context.h"
#import "StrategyAdd.h"
#import "StrategySubstract.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
       
        Context *context = [Context new];
        context.strategy = [[StrategyAdd alloc] init];
        int res = [context.strategy executeWithA:5 B:2];
        NSLog(@"%d", res);
        
        context.strategy = [[StrategySubstract alloc] init];
        int res2 = [context.strategy executeWithA:5 B:2];
        NSLog(@"%d", res2);
        
        
    }
    return 0;
}
