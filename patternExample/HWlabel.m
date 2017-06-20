//
//  HWlabel.m
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import "HWlabel.h"
#import "LargeViewType.h"
#import "DefViewType.h"
#import "RoundViewType.h"

@implementation HWlabel

- (instancetype) initWithType:(ViewType) type{
        HWlabel *lbl = nil;
        switch (type) {
            case LargeViewType1:
                lbl = [LargeViewType new];
                break;
            case DefViewType1:
                lbl = [DefViewType new];
                break;
            case RoundViewType1:
                lbl = [RoundViewType new];
                break;
        }
        return lbl;
    }


    
- (void)animationHWLabel{
    [UIView animateWithDuration:[self getDuration]
                          delay:[self getDelay]
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         [UIView setAnimationDelegate:self];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Move to left done");
                     }];
}

- (CGPoint) getCenterPoint{
    NSAssert(NO, @"Method must be implement in class");
    return CGPointZero;
}
- (NSInteger) getDelay{
    NSAssert(NO, @"Method must be implement in class");
    return 0;
}
- (NSInteger) getDuration{
    NSAssert(NO, @"Method must be implement in class");
    return 0;
}

@end
