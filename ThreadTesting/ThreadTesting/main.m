//
//  main.m
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Philosopher.h"
#import "Spoon.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
                
        Spoon *firstSpoon = [[Spoon alloc] init];
        NSMutableArray *philosophers = [[NSMutableArray alloc] init];

        Spoon *leftSpoon;
        Spoon *rightSpoon;
        Spoon *prevSpoon;
        
        for (int i = 0; i < 5; i ++){
            
            
            if (i == 0) {
                leftSpoon = firstSpoon;
            } else {
                leftSpoon = prevSpoon;
            }
            
            if (i == 4) {
                rightSpoon = firstSpoon;
            } else {
                rightSpoon = [[Spoon alloc] init];
                prevSpoon = rightSpoon;
            }
            
            Philosopher* philosopher = [[Philosopher alloc] initWithRightSpoon:rightSpoon AndLeftSpoon:leftSpoon];
            NSString *philosopherName = [[NSString alloc] initWithFormat:@"philosopher %d", i];
            philosopher.name = philosopherName;
            [philosophers addObject:philosopher];
            
        };
        
         for (Philosopher *item in philosophers){
             [item start];
         }
        [NSThread sleepForTimeInterval:20];
    }
    return 0;
}
