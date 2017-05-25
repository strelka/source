//
//  threadNS.h
//  SumArray
//
//  Created by Jullia Sharaeva on 24.05.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface threadNS : NSThread
@property (nonatomic) long result;
@property (nonatomic) NSCondition *cond;
@property (nonatomic) BOOL isFin;
- (instancetype) initWithRange:(NSRange)prange ofArray:(NSArray*)parray;
@end
