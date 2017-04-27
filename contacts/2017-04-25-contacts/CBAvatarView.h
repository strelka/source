//
//  CBAvatarView.h
//  2017-04-25-contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBAvatarView : UIView
@property(nonatomic, strong) NSString* name;
@property(nonatomic, strong) NSString* lastName;

-(void) fillRect:(CGRect)rect;
-(UIImage*) getImage;

@end
