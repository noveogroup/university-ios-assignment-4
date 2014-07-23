//
//  NSSet+Serializable.m
//  noveo-homework-4
//
//  Created by Wadim on 7/23/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import "NSSet+Serializable.h"

@implementation NSSet (Serializable)

- (NSString *)serialize:(NSError *__autoreleasing*)anError {
    // String for serialized NSSet
    NSMutableString *jsonString = [NSMutableString stringWithString:@"<NSSet>\n"];
    // Enumerate with fast enumeration
    NSString *tempString = nil;
    for (id currentObject in self) {
        if ((tempString = [currentObject serialize:anError])) {
            [jsonString appendString:tempString];
        }
        else {
            jsonString = nil;
            return jsonString;
        }
    }
    // Check for serialize error
        [jsonString appendString:@"</NSSet>"];
        return jsonString;
}


@end
