//
//  SerializationTests.m
//  SerializationTests
//
//  Created by Vladislav Librecht on 12.07.16.
//  Copyright © 2016 Vladislav Librecht. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Serialization.h"

@interface SerializationTests : XCTestCase

@end

@implementation SerializationTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEmptyDictionary
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@{} error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqualObjects(result, @"{  }");
}

- (void)testEmptyArrayInDictionary
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@{@"a": @1, @"b": [NSSet set], @"c": @[]} error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqualObjects(result, @"{ a: 1, b: Set{  }, c: [  ] }");
}

- (void)testComplexGoodDictionary
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@{@"hello": @2, @"world": @8, @1: @[@1, @2, @{@"a": @1, @"b": @2}, [NSSet setWithObjects:@1, @{@"c": @2, @"d": @3}, @7, nil], [NSNull null]], @10: [NSValue valueWithCGRect:CGRectMake(0, 2, 4, 6)]} error:&error];
    
    XCTAssertNil(error);
    XCTAssertEqualObjects(result, @"{ 10: CGRect(0, 2, 4, 6), hello: 2, 1: [ 1, 2, { a: 1, b: 2 }, Set{ 7, 1, { c: 2, d: 3 } }, (null) ], world: 8 }");
}

- (void)testInvalidRootObject
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@"string" error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(result);
}

- (void)testInvalidValue
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@{@1: @2, @2: @"string", @3: @4} error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(result);
}

- (void)testInvalidKey
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@{@1: @2, [NSSet set]: @3, @3: @4} error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(result);
}

- (void)testInvalidObjectInArrayInDictionary
{
    NSError *error = nil;
    NSString *result = [Serialization stringFromDictionary:@{@1: @[[[NSURL alloc] initWithString:@"www.apple.com"]]} error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(result);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
