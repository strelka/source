//
//  main.m
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Philosopher.h"
#import "PhilosopherObj.h"
#import "Spoon.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
                
        Spoon *firstSpoon = [[Spoon alloc] initWithName:@"sp-0"];
        NSMutableArray *philosophers = [[NSMutableArray alloc] init];
        NSMutableArray *philosophersObj = [[NSMutableArray alloc] init];


        Spoon *leftSpoon;
        Spoon *rightSpoon;
        Spoon *prevSpoon;

        int philosophersCount = 3;
        
       for (int i = 0; i < philosophersCount; i ++){
            
            
            if (i == 0) {
                leftSpoon = firstSpoon;
            } else {
                leftSpoon = prevSpoon;
            }
           
            if (i == philosophersCount-1) {
                rightSpoon = firstSpoon;
            } else {
                NSString *spoonName = [[NSString alloc] initWithFormat:@"sp-%d", i+1];
                rightSpoon = [[Spoon alloc] initWithName:spoonName];
                prevSpoon = rightSpoon;
            }
           
            Philosopher* philosopher = [[Philosopher alloc] initWithRightSpoon:rightSpoon AndLeftSpoon:leftSpoon];
           
            PhilosopherObj* philosopherObj = [[PhilosopherObj alloc] initWithRightSpoon:rightSpoon AndLeftSpoon:leftSpoon];
           
           NSString *philosopherName = [[NSString alloc] initWithFormat:@"philosopher %d", i];
           
            philosopher.name = philosopherName;
            philosopherObj.name = philosopherName;
            [philosophers addObject:philosopher];
            [philosophersObj addObject:philosopherObj];
        };
        
//         for (Philosopher *item in philosophers){
//             
//             [item start];
//         }
        
//        // Delay execution of my block for 10 seconds.
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            NSLog(@"parameter1: %d parameter2: %f", parameter1, parameter2);
//        });
        
//        for (i = 0; i < count; i++) {
//            
//            printf("%u\n",i);
//            
//        }
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        
        dispatch_apply(philosophersCount, queue, ^(size_t i) {
            NSLog(@"dispatch_apply");
            if ((i % 2) == 0)
            [philosophersObj[i] eat];
        });
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10 * NSEC_PER_SEC), queue, ^{
            NSLog(@"dispatch_after");
            for (int i = 0; i < philosophersCount; i++)
            {
                if ((i % 2) != 0)
                    [philosophersObj[i] eat];
                
            }
        });

//
        NSLog(@"------------------------------------------------");
        
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//        
//        for (PhilosopherObj *item in philosophersObj){
//            NSOperation *eating = [[NSInvocationOperation alloc]
//                                      initWithTarget:item
//                                      selector:@selector(eat:)
//                                      object:nil];
//            [queue addOperation:eating];
//        }
//
//        [NSThread sleepForTimeInterval:20];
        
        //NSMutableArray* Queue = [[NSMutableArray alloc] init];
        
//            dispatch_queue_t queue = dispatch_queue_create("q", DISPATCH_QUEUE_CONCURRENT);
//            
//            dispatch_async(queue, ^{
//                for (int i= 0; i < [philosophersObj count]; i++){
//                    
//                    [philosophersObj[i] eat];
//                }
//            });
        //
//        [NSThread sleepForTimeInterval:10];
//
//        for (int i = 0; i < 3; i ++){
//            dispatch_async((__bridge dispatch_queue_t _Nonnull)(Queue[i]), ^{
//                [philosophersObj[i] eat];
//            });
//        
//        }
//        
        [NSThread sleepForTimeInterval:10000];

        //dispatch_queue_t queue = dispatch_queue_create("com.myapp.myqueue", DISPATCH_QUEUE_CONCURRENT);
        
    }
    return 0;
}
