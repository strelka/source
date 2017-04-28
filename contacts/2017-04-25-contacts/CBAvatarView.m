//
//  CBAvatarView.m
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "CBAvatarView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CBAvatarView


-(void)setRoundedAndColorView:(float)Size andColor:(UIColor*)color;
{
    self.layer.cornerRadius = Size / 2.0;
    self.backgroundColor = color;
    self.clipsToBounds = YES;
}



@end
