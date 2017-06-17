//
//  main.m
//  Trends
//
//  Created by Jullia Sharaeva on 16.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AppDelegateForTests.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        Class appDelegateClass = (NSClassFromString(@"XCTestCase") ? [AppDelegateForTests class] : [AppDelegate class]);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass(appDelegateClass));
        
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
