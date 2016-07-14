//
//  ProgramTest.m
//  ProgramTest
//

#import <XCTest/XCTest.h>
#import "NSDictionary+Serializer.h"
#import "NSError+Serializer.h"

@interface ProgramTest : XCTestCase

@property (nonatomic) NSNumber *num;
@property (nonatomic) NSString *string;
@property (nonatomic) NSArray *array;
@property (nonatomic) NSSet *set;
@property (nonatomic) NSValue *wrongValue;

@end

@implementation ProgramTest

- (void)setUp {
    [super setUp];
    _num = @3;
    _string = @"Hello";
    _array = @[@4, _string];
    CGSize size = {12,24};
    _wrongValue = [NSValue valueWithSize:size];
    _set = [NSSet setWithObject:_wrongValue];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSimpleRightDict
{
    NSDictionary *dict = @{@1:@2};
    NSError *error = nil;
    XCTAssertEqualObjects([dict serializeWithError:&error], @"{\n1 : 2\n}");
}

- (void)testRightDict
{
    NSDictionary *dict = @{@1:_num,
                           @"second":_string,
                           @3:_array};
    NSError *error = nil;
    XCTAssertEqualObjects([dict[@1] serializeWithError:&error], @"3");
    XCTAssertEqualObjects([dict[@"second"] serializeWithError:&error], @"Hello");
    XCTAssertEqualObjects([dict[@3] serializeWithError:&error], @"[\n4\nHello\n]");
}

- (void)testErrorWithKey
{
    NSDictionary *dict = @{_array:_num};
    NSError *error = nil;
    [dict serializeWithError:&error];
    XCTAssertEqual(error.code, SerializerErrorCodeWrongKey);
    XCTAssertEqualObjects(error.domain, kSerializerErrorDomain);
}

- (void)testErrorWithObject
{
    NSDictionary *dict = @{@1:[[NSDate alloc] init]};
    NSError *error = nil;
    [dict serializeWithError:&error];
    XCTAssertEqual(error.code, SerializerErrorCodeWrongObject);
    XCTAssertEqualObjects(error.domain, kSerializerErrorDomain);
}

- (void)testErrorWithValue
{
    NSDictionary *dict = @{@1:_set};
    NSError *error = nil;
    [dict serializeWithError:&error];
    XCTAssertEqual(error.code, SerializerErrorCodeWrongValue);
    XCTAssertEqualObjects(error.domain, kSerializerErrorDomain);
}

@end
