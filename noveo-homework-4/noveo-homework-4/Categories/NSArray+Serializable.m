//
//  NSArray+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSArray+Serializable.h"


@implementation NSArray (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)anError {
    // String for serialized NSArray
    NSMutableString *jsonString = [NSMutableString stringWithString:@"<NSArray>\n"];
    // Enumerate with fast enumeration
    NSString *tempString = nil;
    for (id currentObject in self) {
        if ([currentObject respondsToSelector:@selector(serialize:)]) {
            // Every iteration check for nil
            if ((tempString = [currentObject serialize:anError])) {
                [jsonString appendString:tempString];
            }
            // Return nil
            else {
                jsonString = nil;
                return jsonString;
            }
        }
        // Return error if we have none-serialized object
        else {
            *anError = [NSError errorWithDomain:@"com.se.NSArray+Serializable"
                                           code:serializeErrorCodeObjectCantBeSerialized
                                       userInfo:[NSDictionary dictionary]];
            return nil;
        }
    }
    // Check for serialize error
    [jsonString appendString:@"</NSArray>"];
    return jsonString;
}


@end
