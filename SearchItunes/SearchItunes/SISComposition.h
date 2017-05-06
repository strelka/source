//
//  SISComposition.h
//  SearchItunes
//
//  Created by Jullia Sharaeva on 05.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface SISComposition : NSObject
@property(nonatomic, strong) NSString* artistName;
@property(nonatomic, strong) NSString* trackName;
@property(nonatomic, strong) NSString* collectionCensoredName;
@property(nonatomic, strong) NSString* trackPrice;
@property(nonatomic, strong) NSURL* artworkUrl;
@property(nonatomic, strong) UIImage* actualImage;
@end
