//
//  FractionCl.h
//  collections
//
//  Created by Jullia Sharaeva on 02.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FractionCl.h";
#import "FractionCl2.h"

@interface FractionCl : NSObject <NSCopying>
@property(nonatomic, strong) FractionCl2* f1;
    -(void) print;
    -(void) setNumerator: (int) n;
    -(void) setDenominator: (int) d;
    -(int) getNumerator;
    -(int) getDenominator;
    -(void) changeFraction:(int) i;
@end
