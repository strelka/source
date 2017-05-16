//
//  Spoon.h
//  ThreadTesting
//
//  Created by Jullia Sharaeva on 13.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Spoon : NSObject
@property (atomic, strong) NSLock *lock;
@property (nonatomic, strong) NSString *name;
- (instancetype) initWithName: (NSString *) name;
- (void) up;
- (void) down;
@end
