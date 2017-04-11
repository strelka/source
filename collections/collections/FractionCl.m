//
//  FractionCl.m
//  collections
//
//  Created by Jullia Sharaeva on 02.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import "FractionCl.h"

@implementation FractionCl
{
    int numerator;
    int dominator;
}

-(void) print
{
    NSLog(@"%i/%i", numerator, dominator);
    
    NSLog(@"%p", &self);
}

-(void) setDenominator:(int) d {
    dominator = d;
}

-(void) setNumerator:(int)n {
    numerator = n;
}

-(void) changeFraction:(int)i {
    dominator *= i;
    numerator *= i;
}

-(int) getNumerator{
    return numerator;
}

-(int) getDenominator{
    return dominator;
}

-(id) copyWithZone: (NSZone *) zone;
{
    FractionCl *newfract = [[FractionCl allocWithZone: zone] init];
    [newfract setNumerator:numerator];
    [newfract setDenominator:dominator];
    return newfract;
}

@end
