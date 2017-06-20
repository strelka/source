//
//  PlainPrinter.h
//  testDecorator
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlainPrinter.h"
#import "StringPrinter.h"

@interface PlainPrinter : NSObject <StringPrinter>

@property (nonatomic, strong) NSString *string;

@end
