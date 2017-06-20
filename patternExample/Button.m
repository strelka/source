//
//  Button.m
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import "Button.h"

#import "ButtonTypeAdd.h"
#import "ButtonTypeRemove.h"
#import "ButtonTypeDefault.h"

@implementation Button

+ (instancetype) buttonWithType:(ButtonType)type{
    Button *btn = nil;
    switch (type) {
        case ButtonTypeAdd:
            btn = [BtnAdd new];
            break;
        case ButtonTypeRemove:
            btn = [BtnRemove new];
            break;
        case ButtonTypeDefault:
            btn = [BtnDefault new];
            break;
    }
    return btn;
    
}

- (UILabel*)draw{
    NSAssert(NO, @"Method must be implement in class");
    return nil;
}

- (UIFont*)font {
    NSAssert(NO, @"Method must be implement in class");
    return CGSizeZero;
}

@end
