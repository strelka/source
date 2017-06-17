//
//  Test_TRNPagesManager.m
//  Trends
//
//  Created by Jullia Sharaeva on 16.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRNPagesManager.h"
#import "TRNChildProtocol.h"

#import <OCMock/OCMock.h>

@interface Test_TRNPagesManager : XCTestCase


@end

@implementation Test_TRNPagesManager
{
    TRNPagesManager *_manager;
}

- (void)setUp {
    [super setUp];
    _manager = [TRNPagesManager new];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    _manager = nil;
    [super tearDown];
}

- (void) test_CanCreateTRNPagesManager {
    XCTAssertNotNil(_manager);
}

- (void) test_isPropertyPagesNotNull{
    XCTAssertNotNil(_manager.pages);
}

//- (void) test_ControllerBeforeController{
//    
//    nil;
//}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
