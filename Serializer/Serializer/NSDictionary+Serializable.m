//
//  NSDictionary+Serializable.m
//  Serializer
//
//  Created by Admin on 25/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSDictionary+Serializable.h"
#import "Serializer.h"
#import "SerializationError.h"


@implementation NSDictionary (Serializable)

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    //[result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"{\n"];
    
    for (id key in [self allKeys]) {
        if (!([key isKindOfClass:[NSNumber class]] || [key isKindOfClass:[NSString class]]) ) {
            if (error != NULL) {
                *error = [SerializationError getWrongKeyTypeErrorForClass:[key class]];
            }
            
            break;
        }
        
        id value = [self objectForKey:key];
        
        if (![value respondsToSelector:@selector(serializeAtDepth:withError:)]) {
            if (error != NULL) {
                *error = [SerializationError getUnsupportedObjectErrorForClass:[value class]];
            }
            
            break;
        } else {
            NSString *childSerialization = [[self objectForKey:key] serializeAtDepth:(depth+1) withError:error];
            
            if (childSerialization == nil) {
                return nil;
            }
            
            [result appendString:[Serializer getIndentStringForDepth:depth+1]];
            [result appendFormat:@"\"%@\": ", key];
            [result appendString:childSerialization];
            [result appendString:@",\n"];
        }
    }
    
    [result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"}"];
    
    if (*error != nil) {
        return nil;
    }
    
    return result;
}

@end
