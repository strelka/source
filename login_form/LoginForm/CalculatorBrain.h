//
//  CalculatorBrain.h
//  LoginForm
//
//  Created by Jullia Sharaeva on 08.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
{
    double operand;
}

-(void)setOperand:(double)anOperand;
-(double)performOperation:(NSString *)operation;

@end
