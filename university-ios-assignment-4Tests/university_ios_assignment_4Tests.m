//
//  university_ios_assignment_4Tests.m
//  university-ios-assignment-4Tests
//
//  Created by admin on 12/07/16.
//  Copyright © 2016 tanya. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Serializer.h"

@interface university_ios_assignment_4Tests : XCTestCase

@end

@implementation university_ios_assignment_4Tests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown

{
    [super tearDown];
}

- (void)testCorrectDictionary

{
    NSArray *array = @[@5, @4, @3];
    NSArray *stringArray = @[@"a", @"b", @"c"];
    NSSet *set = [[NSSet alloc] initWithArray:array];
    CGRect rect = CGRectMake(0,0,100,100);
    NSDictionary *dictionary = @{
                                 @"test": @"dfg",
                                 @1: @{
                                         @2: @"Ddfg",
                                         @3: @[array,@2,@3],
                                         @"dfgk": @"kjdfg"
                                         },
                                 @2: @"sdjfn",
                                 @"set": set,
                                 @4: [NSNull null],
                                 @"rect": [NSValue valueWithCGRect:rect],
                                 @5: stringArray
                                 };
    NSError *error;
    NSString *string = [Serializer serializerByDictionary:dictionary error:&error];
    NSString *result = @"{\n\tset: [3, 4, 5]\n\ttest: dfg\n\t1: {\n\t3: [[5, 4, 3], 2, 3]\n\tdfgk: kjdfg\n\t2: Ddfg\n\n}\n\n\t5: [a, b, c]\n\t2: sdjfn\n\trect: NSRect:{{0.000000, 0.000000}, {100.000000, 100.000000}}\n\t4: NULL\n\n}\n";
    XCTAssertEqualObjects(string, result);
}

- (void)testInvalidKey
{
    NSDictionary *dictionary = @{
                                 @[@5, @4, @3]: @"dfg"
                                 };
    NSError *error;
    NSString *string = [Serializer serializerByDictionary:dictionary error:&error];
    if (error) {
        NSString *stringError = [NSString stringWithFormat:@"%@", error];
        XCTAssertTrue([stringError containsString:@"Invalid key in key"]);
        
    } else{
        XCTFail(@"Not catch invalid key");
    }
    
    if(string){
        XCTFail(@"Must be nil string");
    }
}

- (void)testIncorrectType
{
    CGPoint point = CGPointMake(0,0);
    NSDictionary *dictionary = @{
                                 @"point": [NSValue valueWithCGPoint:point]
                                 };
    NSError *error;
    NSString *string = [Serializer serializerByDictionary:dictionary error:&error];
    if (error) {
        NSString *stringError = [NSString stringWithFormat:@"%@", error];
        XCTAssertTrue([stringError containsString:@"Incorrect type in object"]);
        
    } else{
        XCTFail(@"Not catch incorrect type in object");
    }
    
    if(string){
        XCTFail(@"Must be nil string");
    }
}

- (void)testNotDictionary
{
    NSArray *array = @[@5, @4, @3];
    
    NSError *error;
    NSString *string = [Serializer serializerByDictionary:array error:&error];
    if (error) {
        NSString *stringError = [NSString stringWithFormat:@"%@", error];
        XCTAssertTrue([stringError containsString:@"Not dictionary"]);
        
    } else{
        XCTFail(@"Not catch that send not dictionary");
    }
    
    if(string){
        XCTFail(@"Must be nil string");
    }
}

@end
