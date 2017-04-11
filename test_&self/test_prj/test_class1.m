//
//  test_class1.m
//  test_prj
//
//  Created by Jullia Sharaeva on 07.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import "test_class1.h"

@implementation test_class1
-(void) print{
    NSLog(@"print1: %p", &self);
}
-(void) test_method{
    NSLog(@"inner print");
    [self print];
    NSLog(@"fff %p", &self);
}

@end
