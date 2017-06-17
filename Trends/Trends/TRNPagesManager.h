//
//  TRNPagesManager.h
//  Trends
//
//  Created by Jullia Sharaeva on 16.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//
#import "TRNChildProtocol.h"
#import <Foundation/Foundation.h>

@interface TRNPagesManager : NSObject
@property (nonatomic, strong, readonly) NSMutableArray *pages;
- (void) addPage:(id<TRNChildProtocol>) page;

- (id <TRNChildProtocol>) getViewControllerBeforeViewControllerWithIndex:(NSInteger) index;
- (id <TRNChildProtocol>) getViewControllerAfterViewControllerWithIndex:(NSInteger) index;

@end
