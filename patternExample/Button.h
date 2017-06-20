//
//  Button.h
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
@import CoreGraphics;

typedef NS_ENUM(NSInteger, ButtonType){
    ButtonTypeDefault,
    ButtonTypeAdd,
    ButtonTypeRemove
};

@interface Button : NSObject
+ (instancetype) buttonWithType:(ButtonType) type;

- (UILabel*)draw;
- (UIFont*)font;
@end
