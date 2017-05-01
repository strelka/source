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

-(instancetype) initWithURL:(NSURL *)url{
    self = [super init];
    CIImage * im = [[CIImage alloc] initWithContentsOfURL:url];
    self.image = [[UIImage alloc] initWithCIImage:im scale:1.0 orientation:UIImageOrientationUp];
    return self;

}
@end
