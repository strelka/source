//
//  FractionCl.h
//  collections
//
//  Created by Jullia Sharaeva on 02.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FractionCl : NSObject <NSCopying>
    -(void) print;
    -(void) setNumerator: (int) n;
    -(void) setDenominator: (int) d;
    -(int) getNumerator;
    -(int) getDenominator;
    -(void) changeFraction:(int) i;
@end
