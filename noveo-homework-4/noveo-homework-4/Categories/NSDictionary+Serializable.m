//
//  NSDictionary+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSDictionary+Serializable.h"

@implementation NSDictionary (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)anError {
    // String for serialized NSDictionary
    NSMutableString *jsonString = [NSMutableString stringWithString:@"<NSDictionary>\n"];
    // Get enumerating array with keys
    NSArray *selfKeys = [self allKeys];
    // Enumerate with fast enumeration
    NSString *tempString = nil;
    for (NSString *currentKey in selfKeys) {
        if ([[self objectForKey:currentKey] respondsToSelector:@selector(serialize:)]) {
            // Every iteration check for nil
            if ((tempString = [[self objectForKey:currentKey]serialize:anError])) {
                [jsonString appendString:[NSString stringWithFormat:@"Key: \"%@\"\n",currentKey]];
                [jsonString appendString:tempString];
            }
            // Return nil
            else {
                jsonString = nil;
                return jsonString;
            }
        }
        else {
            *anError = [NSError errorWithDomain:@"com.se.NSDictionaty+Serializable"
                                           code:serializeErrorCodeObjectCantBeSerialized
                                       userInfo:[NSDictionary dictionary]];
            return nil;
        }
        
    }
    // Check for serialize error
    [jsonString appendString:@"</NSDictionary> "];
    return jsonString;
}

@end
