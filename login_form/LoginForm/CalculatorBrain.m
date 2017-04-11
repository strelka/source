//
//  CalculatorBrain.m
//  LoginForm
//
//  Created by Jullia Sharaeva on 08.04.17.
//  Copyright © 2017 Jullia Sharaeva. All rights reserved.
//

#import "CalculatorBrain.h"

@implementation CalculatorBrain
-(void) setOperand:(double)anOperand{
    operand = anOperand;
}

-(double)performOperation:(NSString *)operation{
    if ([operation isEqual:@"sqrt"]){
        operand = sqrt(operand);
    }
    //} else {
    //    [self performWaitingOpera]
    //}
//    [operation sendMessage:argument];
 //   return aDouble;
    return operand;
}
@end
