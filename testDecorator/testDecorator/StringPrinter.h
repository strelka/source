//
//  StringPrinter.h
//  testDecorator
//
//  Created by iOS-School-1 on 20.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StringPrinter <NSObject>
- (void) printString;
- (void) setString:(NSString*)string;
- (NSString *) string;
@end
