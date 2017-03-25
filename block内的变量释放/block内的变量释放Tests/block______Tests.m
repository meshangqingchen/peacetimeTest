//
//  block______Tests.m
//  block内的变量释放Tests
//
//  Created by 3D on 17/2/15.
//  Copyright © 2017年 3D. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface block______Tests : XCTestCase

@end

@implementation block______Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
