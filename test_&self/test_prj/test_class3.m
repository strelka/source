//
//  test_class3.m
//  test_prj
//
//  Created by Jullia Sharaeva on 07.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import "test_class3.h"

@implementation test_class3
-(void) test_method{
    NSLog(@"test_method %p", &self);
}

-(void)print{
    NSLog(@"print cl3 - %p", &self);
//    
//    id tmp = [self class];
//    test_class3 *t = &self;
//    
    //id t = [test_class3 class];
    //id t = &self;
    
  //  NSLog(@"print cl3 - t - %p", &t);
    
    
}


@end
