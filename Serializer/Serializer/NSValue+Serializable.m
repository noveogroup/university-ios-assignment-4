//
//  NSValue+Serializable.m
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSValue+Serializable.h"
#import "Serializer.h"
#import "SerializationError.h"

@implementation NSValue (Serializable)

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    if (strcmp([self objCType], @encode(CGRect)) == 0) {
        NSMutableString *result = [[NSMutableString alloc] init];
        
        [result appendString:[Serializer getIndentStringForDepth:depth]];
        [result appendString:@"CGRect:\n"];
        
        CGRect value = [self CGRectValue];
        
        [result appendString:[Serializer getIndentStringForDepth:(depth+1)]];
        [result appendFormat:@"x: %f\n", value.origin.x];
        
        [result appendString:[Serializer getIndentStringForDepth:(depth+1)]];
        [result appendFormat:@"y: %f\n", value.origin.y];
        
        [result appendString:[Serializer getIndentStringForDepth:(depth+1)]];
        [result appendFormat:@"width: %f\n", value.size.width];
        
        [result appendString:[Serializer getIndentStringForDepth:(depth+1)]];
        [result appendFormat:@"height: %f\n", value.size.height];
        
        return result;
    } else {
        if (error != NULL) {
            *error = [SerializationError getUnsupportedObjectErrorForClass:[self class]];
        }
        
        return nil;
    }
}

@end
