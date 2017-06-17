//
//  TestTrnPagesManagerGetViewControllers.m
//  Trends
//
//  Created by Jullia Sharaeva on 17.06.17.
//  Copyright © 2017 Julia Sharaeva. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TRNPagesManager.h"
#import "TRNChildProtocol.h"

#import <OCMock/OCMock.h>

@interface TestTrnPagesManagerGetViewControllers : XCTestCase

@end

@implementation TestTrnPagesManagerGetViewControllers{
    TRNPagesManager *_manager;
}

- (void)setUp {
    [super setUp];
    _manager = [TRNPagesManager new];
    
    id protocolMock1 = OCMProtocolMock(@protocol(TRNChildProtocol));
    id protocolMock2 = OCMProtocolMock(@protocol(TRNChildProtocol));
    id protocolMock3 = OCMProtocolMock(@protocol(TRNChildProtocol));
    
    
    [_manager registerPage:protocolMock1];
    [_manager registerPage:protocolMock2];
    [_manager registerPage:protocolMock3];

    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    _manager = nil;    
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) test_getViewControllerBeforeViewControllerWithZeroIndex{
    //given
    id protocolMock = OCMProtocolMock(@protocol(TRNChildProtocol));
    NSInteger zeroIndx = 0;
    //when
    protocolMock = [_manager getViewControllerBeforeViewControllerWithIndex:zeroIndx];
    //then
    XCTAssertNil(protocolMock);
}

- (void) test_getViewControllerBeforeViewControllerWithMaxIndex{
    //given
    id protocolMock = OCMProtocolMock(@protocol(TRNChildProtocol));
    NSArray *pages = [_manager pages];
    //when
    protocolMock = [_manager getViewControllerBeforeViewControllerWithIndex:2];
    //then
    XCTAssertNotNil(protocolMock);
    XCTAssertEqual(pages[1], protocolMock);
}

- (void) test_getViewControllerAfterViewControllerWithZeroIndex{
    //given
    id protocolMock = OCMProtocolMock(@protocol(TRNChildProtocol));
    NSArray *pages = [_manager pages];
    //when
    protocolMock = [_manager getViewControllerAfterViewControllerWithIndex:0];
    //then
    XCTAssertNotNil(protocolMock);
    XCTAssertEqual(pages[1], protocolMock);
}

- (void) test_getViewControllerAfterViewControllerWithMaxIndex{
    //given
    id protocolMock = OCMProtocolMock(@protocol(TRNChildProtocol));
    NSArray *pages = [_manager pages];
    //when
    protocolMock = [_manager getViewControllerAfterViewControllerWithIndex:2];
    //then
    XCTAssertNotNil(protocolMock);
    XCTAssertEqual(pages[0], protocolMock);
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
