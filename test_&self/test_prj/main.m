//
//  main.m
//  test_prj
//
//  Created by Jullia Sharaeva on 07.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "test_class1.h"
#import "test_class2.h"
#import "test_class3.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        int count = 10;
        int *uk;
        uk = &count;
        
        int newcount = *uk;
        
        
        NSString *ns = @"test_string";
        int *ns_uk;
        //ns_uk = &ns;
        
        
        test_class1 *t1 = [[test_class1 alloc] init];
        [t1 print];
        [t1 test_method];
        
        test_class2 *t2 = [test_class2 alloc];
        t2 = [t2 init];
        
        [t2 print];
        test_class3 *t3 = [[test_class3 alloc] init];
        

        
        //[t1 print];
        //[t2 print];
        
        test_class3 *t = [[test_class3 alloc] init];
        NSLog(@" print t %p", &t);
        
    
        test_class2 *t4 = [test_class2 alloc];
        NSLog(@"%p", &t4);
        Class tt4 = [t4 class];
        NSLog(@"%p", &tt4);
        Class stt4 = [t4 superclass];
        NSLog(@"%p", &stt4);
        Class sstt4 = [t4 self];
        NSLog(@"%p", &sstt4);
        
        //id = &sstt4
        
        
        id t5 = [[test_class1 alloc] init];
        //NSLog(@"fff - %p", &t5);
        
        NSObject *nob = [[NSObject alloc] init];
        NSLog(@"%p", &nob);
        
    }
    return 0;
}
