//
//  NSSet+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSSet+Serializable.h"

@implementation NSSet (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error {
    // String for serialized NSSet
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<NSSet>\n"];
    // Enumerate with fast enumeration
    NSString *tempString = nil;
    for (id object in self) {
        if ([object respondsToSelector:@selector(serialize:)]) {
            // Every iteration check for nil
            if ((tempString = [object serialize:error])) {
                [xmlString appendString:tempString];
            }
            // Return nil
            else {
                xmlString = nil;
                return xmlString;
            }
        }
        // Return error if we have none-serialized object
        else {
            if (error) {
                *error = [NSError errorWithDomain:@"com.se.NSSet+Serializable"
                                             code:serializeErrorCodeObjectCantBeSerialized
                                         userInfo:nil];
            }
            return nil;
        }
    }
    // Check for serialize error
        [xmlString appendString:@"</NSSet>"];
        return xmlString;
}


@end
