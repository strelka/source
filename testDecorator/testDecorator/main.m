//
//  main.m
//  testDecorator
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PlainPrinter.h"
#import "PrinterDecorator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        PlainPrinter *plainPrinter = [PlainPrinter new];
        plainPrinter.string = @"testString";
        [plainPrinter printString];
        
        PrinterDecorator *decorator = [[PrinterDecorator alloc] initWith:plainPrinter];
        [decorator printString];
        
    }
    return 0;
}
