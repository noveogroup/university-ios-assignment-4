//
//  NSSet+Serializable.m
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSSet+Serializable.h"
#import "Serializer.h"
#import "SerializationError.h"

@implementation NSSet (Serializable)

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"NSSet:\n"];
    
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
            
            [result appendString:childSerialization];
        }
    }
    
    if (*error != nil) {
        return nil;
    }
    
    return result;
}


@end
