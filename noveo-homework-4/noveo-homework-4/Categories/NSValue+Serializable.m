//
//  NSValue+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSValue+Serializable.h"
#import "SEContainerSerializer.h"

@implementation NSValue (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error {
    // Get string description to local var
    NSString *testString = [self description];
    // Check string for "NSRect:" substring
    NSRange testRange = [testString rangeOfString:@"NSRect:"];
    if (testRange.location == NSNotFound) {
        // Do serialize object error
        if (error) {
            *error = [NSError errorWithDomain:@"com.se.NSValue+Serializable"
                                         code:serializeErrorCodeObjectCantBeSerialized
                                     userInfo:nil];
        }
        return nil;
    }
    return [NSString stringWithFormat:@"<NSValue>\n<NSRect>\n%@\n</NSRect>\n</NSValue>\n",
            [testString substringFromIndex:[@"NSRect: " length]]];
}


@end
