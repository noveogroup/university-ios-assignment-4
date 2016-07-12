//
//  NSArray+Serializer.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSArray+Serializer.h"

static NSInteger const kObjectErrorCode = 1;
static NSString *const kObjectErrorDomain = @"Wrong type of object in dictionary";

@implementation NSArray (Serializer)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableString *result = [NSMutableString stringWithString:@"\n[\n"];
    NSMutableString *objString;
    for (id obj in self) {
        if ([obj conformsToProtocol:@protocol(Serializable)]) {
            objString = [obj serializeWithError:error];
        }
        else {
            *error = [[NSError alloc] initWithDomain:kObjectErrorDomain code:kObjectErrorCode userInfo:nil];
            return nil;
        }
        if (!*error) {
            [result appendFormat:@"%@\n",objString];
        }
        else {
            return nil;
        }
    }
    [result appendString:@"]"];
    return result;
}

@end
