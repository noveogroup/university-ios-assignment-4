//
//  NSArray+Serializable.m
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSArray+Serializable.h"
#import "Serializer.h"
#import "SerializationError.h"

@implementation NSArray (Serializable)

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    //[result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"[\n"];
    
    for (id value in self) {
        if (![value respondsToSelector:@selector(serializeAtDepth:withError:)]) {
            if (error != NULL) {
                *error = [SerializationError getUnsupportedObjectErrorForClass:[value class]];
            }
            
            break;
        } else {
            NSString *childSerialization = [value serializeAtDepth:(depth+1) withError:error];
            
            if (childSerialization == nil) {
                return nil;
            }
            
            [result appendString:[Serializer getIndentStringForDepth:depth+1]];
            [result appendFormat:@"%i : ", [self indexOfObject:value]];
            [result appendString:childSerialization];
            [result appendString:@",\n"];
        }
    }
    
    [result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"]"];
    
    if (*error != nil) {
        return nil;
    }
    
    return result;
}

@end
