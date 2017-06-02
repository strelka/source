//
//  SPFComment.h
//  ShowFlicrImage
//
//  Created by Jullia Sharaeva on 02.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPFComment : NSObject
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) NSString *authorName;
@property (nonatomic, strong) NSString *content;
@end
