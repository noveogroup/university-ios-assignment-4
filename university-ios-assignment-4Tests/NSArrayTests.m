//
//  NSArrayTests.m
//  university-ios-assignment-4
//
//  Created by admin on 13/07/16.
//  Copyright © 2016 tanya. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Serilisable.h"
#import "NSArray+Serialize.h"

@interface NSArrayTests : XCTestCase

@end

@implementation NSArrayTests

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

- (void)testArrayOfNumbers
{
    NSArray<Serilisable> *array = @[@5, @4, @3];
    NSError *error;
    NSString *result = [array serialiseWithError:&error];
    XCTAssertEqualObjects(result, @"[5, 4, 3]");
    if(error){
        XCTFail(@"%@",error);
    }
    
}

- (void)testArrayOfStrings
{
    NSArray<Serilisable> *array = @[@"a", @"b", @"c"];
    NSError *error;
    NSString *result = [array serialiseWithError:&error];
    XCTAssertEqualObjects(result, @"[a, b, c]");
    if(error){
        XCTFail(@"%@",error);
    }
    
}
@end
