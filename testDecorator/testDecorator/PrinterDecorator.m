//
//  PrinterDecorator.m
//  testDecorator
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import "PrinterDecorator.h"
@interface PrinterDecorator()
@property (nonatomic, strong) id<StringPrinter> printer;
@end;


@implementation PrinterDecorator
- (instancetype) initWith:(id<StringPrinter>)printer{
    self = [super init];
    if (self){
        self.printer = printer;
    }
    return self;
}

- (void) printString{
    NSString *str = [[NSString alloc] initWithFormat:@"%@ %@", self.printer.string, @"!!!" ];
    self.printer.string = str;
    [self.printer printString];
}


@end
