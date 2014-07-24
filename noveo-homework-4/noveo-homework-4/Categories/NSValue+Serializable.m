//
//  NSValue+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSValue+Serializable.h"

@implementation NSValue (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)anError {
    // Get string description to local var
    NSString *testString = [self description];
    // Check string for "NSRect:" substring
    NSRange testRange = [testString rangeOfString:@"NSRect:"];
    if (testRange.location == NSNotFound) {
        // Do serialize object error
         *anError = [NSError errorWithDomain:@"com.se.NSValue+Serializable"
                                        code:serializeErrorCodeObjectCantBeSerialized
                                    userInfo:[NSDictionary dictionary]];
        return nil;
    }
    return [NSString stringWithFormat:@"<NSValue>\n<NSRect>\n%@\n</NSRect>\n</NSValue>\n",
            [testString substringFromIndex:[@"NSRect: " length]]];
}


@end
