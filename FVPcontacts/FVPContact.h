//
//  FVPContact.h
//  FVPcontacts
//
//  Created by Jullia Sharaeva on 12.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FVPContact : NSObject
@property(nonatomic, strong) NSString* firstName;
@property(nonatomic, strong) NSString* lastName;

@property(nonatomic, strong) NSURL* imageUrl;
@property(nonatomic, strong) UIImage *avatarImg;

@end
