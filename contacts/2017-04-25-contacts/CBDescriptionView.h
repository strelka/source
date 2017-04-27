//
//  CBDescriptionView.h
//  2017-04-25-contacts
//
//  Created by Jullia Sharaeva on 26.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CBAvatarView;

@interface CBDescriptionView : UIView

//?????
@property(nonatomic) UILabel* name;
@property(nonatomic) UILabel* lastName;
@property(nonatomic) UILabel* phone;
@property(nonatomic) UILabel* email;
@property(nonatomic) UIImageView* avatar;

//-(void) setName:(NSString*)text;
//-(void) setLastName:(NSString*)text;
//-(void) setPhone:(NSString*)text;
//-(void) setEmail:(NSString*)text;


@end
