//
//  SerializerTests.m
//  SerializerTests
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../Serializer/Serializer.h"
#import "../Serializer/SerializationError.h"

@interface SerializerTests : XCTestCase

@end

@implementation SerializerTests

Serializer *serializer;

- (void)setUp
{
    [super setUp];
    serializer = [[Serializer alloc] init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNoErrors
{
    // this should not produce any errors
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:[[NSMutableDictionary alloc] init] forKey:@"Dictionary Key"];
    [dictionary setValue:[[NSMutableArray alloc]
                          initWithArray:@[
                                          [NSValue valueWithCGRect:CGRectMake(23, 30, 100, 50)],
                                          [[NSNumber alloc] initWithInt:176],
                                          [[NSSet alloc]
                                           initWithArray:@[
                                                           [[NSNumber alloc] initWithInt:-654176],
                                                           [[NSNumber alloc] initWithInt:176546],
                                                           [[NSNumber alloc] initWithInt:1534776]
                                                           ]]
                          ]]
                  forKey:@"Array Key"];
    [dictionary setValue:[[NSSet alloc] init] forKey:@"Set Key"];
    [dictionary setValue:[[NSNumber alloc] initWithInt:(-44211)] forKey:[[NSNumber alloc] initWithInt:-44211]];
    [dictionary setValue:[[NSNull alloc] init] forKey:@"Null Key"];
    [dictionary setValue:[NSValue valueWithCGRect:CGRectMake(2, 30, 1553, 127)] forKey:@"CGRect Key"];
    
    [[dictionary objectForKey:@"Dictionary Key"] setValue:[[NSNumber alloc] initWithInt:1553] forKey:@"Number Key"];
    [[dictionary objectForKey:@"Dictionary Key"] setValue:[[NSNull alloc] init] forKey:@"myNull"];
    
    [[dictionary objectForKey:@"Array Key"] addObject:[[NSNull alloc] init]];
    [[dictionary objectForKey:@"Array Key"] addObject:[[NSMutableArray alloc] init]];
    
    NSLog(@"Serializer test:\n");
    
    NSError *error = nil;
    NSString *result = [serializer serialize:dictionary error:&error];
    
    if (result == nil) {
        XCTFail(@"Error happened with perfectly normal input data: %@", [error description]);
        NSLog(@"%@", [error description]);
    } else {
        NSLog(@"%@", result);
    }

}

- (void)testUnsupportedObject
{
    // this should fail with 'unsupported object' error
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:[NSValue valueWithRange:NSRangeFromString(@"1 23")] forKey:@"CGRange"];
    
    NSError *error = nil;
    NSString *result = [serializer serialize:dictionary error:&error];
    
    if (result == nil) {
        NSLog(@"%@", [error description]);
        if (error.code != unsupportedObject) {
            XCTFail(@"Wrong error passed: %i", error.code);
        }
    } else {
        XCTFail(@"Unsupported object error should have happened!");
        NSLog(@"%@", result);
    }
    
    dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:@"Use The Force!" forKey:@"NSString"];
    
    error = nil;
    result = [serializer serialize:dictionary error:&error];
    
    if (result == nil) {
        NSLog(@"%@", [error description]);
        if (error.code != unsupportedObject) {
           XCTFail(@"Wrong error passed: %i", error.code);
        }
    } else {
        XCTFail(@"'unsupported object' error should have happened!");
        NSLog(@"%@", result);
    }
}

- (void)testNotDictionary
{
    // this should fail with 'Not Dictionary' error
    NSMutableArray *dictionary = [[NSMutableArray alloc] init];
    
    [dictionary addObject:[NSValue valueWithRange:NSRangeFromString(@"1 23")]];
    
    NSError *error = nil;
    NSString *result = [serializer serialize:dictionary error:&error];
    
    if (result == nil) {
        NSLog(@"%@", [error description]);
        if (error.code != notDictionary) {
            XCTFail(@"Wrong error passed: %i", error.code);
        }
    } else {
        XCTFail(@"'not dictionary' error should have happened!");
        NSLog(@"%@", result);
    }
}

- (void)testWrongKey
{
    // this should fail with 'wrong key' error
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setValue:[[NSMutableDictionary alloc] init] forKey:[[NSArray alloc] init]];
   
    NSError *error = nil;
    NSString *result = [serializer serialize:dictionary error:&error];
    
    if (result == nil) {
        NSLog(@"%@", [error description]);
        if (error.code != wrongKeyType) {
            XCTFail(@"Wrong error passed: %i", error.code);
        }
    } else {
        XCTFail(@"'wrong key' error should have happened!");
        NSLog(@"%@", result);
    }    
}

@end
