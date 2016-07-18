//
//  Task4Tests.m
//  Task4Tests
//
//  Created by Sergey Plotnikov on 17.07.16.
//
//

#import <XCTest/XCTest.h>
#import "NSValue+Serializable.h"
#import "Serializer.h"

@interface Task4Tests : XCTestCase

@property(nonatomic) NSValue *value;
@property(nonatomic) NSMutableArray *mutableArray;
@property(nonatomic) NSSet *set;
@property(nonatomic) NSArray *array;
@property(nonatomic) NSArray *keys;
@property(nonatomic) NSDictionary *dictionary;

@end

@implementation Task4Tests

- (void)setUp {
    [super setUp];
    _value = [NSValue valueWithCGRect:CGRectMake(1, 1, 5, 5)];
    _mutableArray = [@[@(1), @(2), @(YES)] mutableCopy];
    _set = [NSSet setWithArray:@[@"ABC", @"DEF", @(1)]];
    _array = @[_mutableArray, _value, _set, [NSNull null], @(1)];
    _keys = @[@"Key MutableArray", @"Key Value", @"Key Set", @"Key Null", @"Key 1"];
    _dictionary = [NSDictionary dictionaryWithObjects:_array forKeys:_keys];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testCorrectObject {
    NSError *error = nil;
    XCTAssertEqualObjects([Serializer serializeContainer:_dictionary error:&error], @"\nKey: \"Key Null\"\n<null>\nKey: \"Key Value\"\n{{1, 1}, {5, 5}}\nKey: \"Key Set\"\n{ABC, DEF, 1}\nKey: \"Key 1\"\n1\nKey: \"Key MutableArray\"\n{1, 2, 1}");
}

- (void)testWithWrongObject
{
    NSError *error = nil;
    XCTAssertEqualObjects([Serializer serializeContainer:_array error:&error], nil);
    if (error) {
        NSLog(@"\nDomain: %@\nSerializationErrorCode: %ld\nUserInfo: %@\n", error.domain, (long)error.code, error.userInfo);
    }
}

- (void)testWithWrongKey
{
    _keys = @[@"Key MutableArray", _value, @"Key Set", @"Key Null", @"Key 1"];
    _dictionary = [NSDictionary dictionaryWithObjects:_array forKeys:_keys];
    NSError *error = nil;
    XCTAssertEqualObjects([Serializer serializeContainer:_dictionary error:&error], nil);
    if (error) {
        NSLog(@"\nDomain: %@\nSerializationErrorCode: %ld\nUserInfo: %@\n", error.domain, (long)error.code, error.userInfo);
    }
}

- (void)testWithWrongValue
{
    _value = [NSValue valueWithSize:NSSizeFromString(@"")];
    _array = @[_mutableArray, _value, _set, [NSNull null], @(1)];
    _keys = @[@"Key MutableArray", @"Key Value", @"Key Set", @"Key Null", @"Key 1"];
    _dictionary = [NSDictionary dictionaryWithObjects:_array forKeys:_keys];
    NSError *error = nil;
    XCTAssertEqualObjects([Serializer serializeContainer:_dictionary error:&error], nil);
    if (error) {
        NSLog(@"\nDomain: %@\nSerializationErrorCode: %ld\nUserInfo: %@\n", error.domain, (long)error.code, error.userInfo);
    }
}

@end
