//
//  HWlabel.h
//  patternExample
//
//  Created by iOS-School-1 on 17.06.17.
//  Copyright © 2017 JSh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewType){
    DefViewType1,
    LargeViewType1,
    RoundViewType1
};

@interface HWlabel : UIView
- (instancetype) initWithType:(ViewType) type;
- (void)animationHWLabel;

- (CGPoint) getCenterPoint;
- (NSInteger) getDelay;
- (NSInteger) getDuration;

@end
