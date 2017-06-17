//
//  TRNPagesManager.m
//  Trends
//
//  Created by Jullia Sharaeva on 16.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import "TRNPagesManager.h"
#import "TRNChildProtocol.h"

@interface TRNPagesManager()
@property (nonatomic, strong, readwrite) NSMutableArray *pages;
@end

@implementation TRNPagesManager

- (void) addPage:(id<TRNChildProtocol>) page{
    
    if ([page conformsToProtocol:@protocol(TRNChildProtocol)]){
        page.pageIndex = [_pages count];
        [_pages addObject:page];
    } else {
        NSLog(@"");
    }
    
}

- (instancetype) init {
    self = [super init];
    if (self){
        _pages = [[NSMutableArray alloc] init];
    }
    return self;

}


- (id <TRNChildProtocol>) getViewControllerBeforeViewControllerWithIndex:(NSInteger) index{
    if (index == 0) {
        return nil;
    } else {
        return _pages[index - 1];
    }
}


- (id <TRNChildProtocol>) getViewControllerAfterViewControllerWithIndex:(NSInteger) index{
        if (index >= [_pages count] - 1) {
            return _pages[0];
        } else {
            return _pages[index + 1];
        }
}
    
@end
