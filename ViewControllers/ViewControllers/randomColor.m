//
//  randomColor.m
//  ViewControllers
//
//  Created by Jullia Sharaeva on 13.04.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "randomColor.h"

@implementation randomColor

-(instancetype) init{
    self = [super init];
    if (self){
       self.red = arc4random_uniform(255)/255.0f;
       self.green = arc4random_uniform(255)/255.0f;
       self.blue = arc4random_uniform(255)/255.0f;
    }
    
    return self;
}

-(NSString*) print{
    NSString* result = [NSString stringWithFormat:@"(%.2f, %.2f, %.2f)", self.red, self.green, self.blue];
    return result;
}

@end
