//
//  NSNumber+Serializer.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSNumber+Serializer.h"

@implementation NSNumber (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing*)error
{
    *error = nil;
    NSString *result = [NSString stringWithFormat:@"%@", self];
    return result;
}

@end