//
//  NSValue+Serializer.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSValue+Serializer.h"

static NSInteger const kObjectErrorCode = 1;
static NSString *const kObjectErrorDomain = @"Wrong type of object in dictionary";

@implementation NSValue (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    NSMutableString *result = nil;
    if (strcmp(self.objCType, @encode(CGRect)) != 0) {
        *error = [[NSError alloc] initWithDomain:kObjectErrorDomain code:kObjectErrorCode userInfo:nil];
        return nil;
    }
    else {
        result = [NSMutableString stringWithFormat:@"%@", self];
    }
    return [result copy];
}

@end
