//
//  NSDictionary+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSDictionary+Serializable.h"
#import "SEContainerSerializer.h"

@implementation NSDictionary (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)error {
    // String for serialized NSDictionary
    NSMutableString *xmlString = [NSMutableString stringWithString:@"<NSDictionary>\n"];
    // Enumerate with fast enumeration
    NSString *tempString = nil;
    for (id currentKey in self) {
        if (!([currentKey isKindOfClass:[NSString class]] || [currentKey isKindOfClass:[NSNumber class]])) {
            if (error) {
                *error = [NSError errorWithDomain:@"com.se.NSDictionaty+Serializable"
                                             code:SerializeErrorCodeIncompotibleTypeForKey
                                         userInfo:nil];
            }
            return nil;
        }
        if ([[self objectForKey:currentKey] respondsToSelector:@selector(serialize:)]) {
            // Every iteration check for nil
            if ((tempString = [[self objectForKey:currentKey]serialize:error])) {
                [xmlString appendString:[NSString stringWithFormat:@"Key: \"%@\"\n",currentKey]];
                [xmlString appendString:tempString];
            }
            // Return nil
            else {
                xmlString = nil;
                return xmlString;
            }
        }
        else {
            if (error) {
                *error = [NSError errorWithDomain:@"com.se.NSDictionaty+Serializable"
                                             code:serializeErrorCodeObjectCantBeSerialized
                                         userInfo:nil];
            }
            return nil;
        }
        
    }
    // Check for serialize error
    [xmlString appendString:@"</NSDictionary>\n"];
    return xmlString;
}

@end
