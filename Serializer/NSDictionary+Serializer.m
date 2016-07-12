//
//  NSDictionary+Serializer.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSDictionary+Serializer.h"

static NSInteger const kObjectErrorCode = 1;
static NSInteger const kKeyErrorCode = 2;
static NSString *const kObjectErrorDomain = @"Wrong type of object in dictionary";
static NSString *const kKeyErrorDomain = @"Wrong type of key";

@implementation NSDictionary (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableString *result = [NSMutableString stringWithString:@"\n{\n"];
    for (id key in self) {
        NSMutableString *keyString;
        NSMutableString *objectString;
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            keyString = [key serializeWithError:error];
        }
        else {
            *error = [NSError errorWithDomain:kKeyErrorDomain code:kKeyErrorCode userInfo:nil];
            return nil;
        }
        if ([self[key] conformsToProtocol:@protocol(Serializable)]) {
            objectString = [self[key] serializeWithError:error];
        }
        else {
            *error = [NSError errorWithDomain:kObjectErrorDomain code:kObjectErrorCode userInfo:nil];
            return nil;
        }
        if (*error) {
            return nil;
        }
        else {
            [result appendFormat:@"%@ : %@\n", keyString, objectString];
        }
    }
    [result appendString:@"}"];
    return [result copy];
}

@end
