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
    
    [result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"NSDictionary:\n"];
    
    for (id key in [self allKeys]) {
        if (!([key isKindOfClass:[NSNumber class]] || [key isKindOfClass:[NSString class]]) ) {
            if (error != NULL) {
                *error = [SerializationError getWrongKeyTypeErrorForClassName:[[key class] description]];
            }
            
            break;
        }
        
        id value = [self objectForKey:key];
        
        if (![value respondsToSelector:@selector(serializeAtDepth:withError:)]) {
            if (error != NULL) {
                *error = [SerializationError getUnsupportedObjectErrorForClassName:[[value class] description]];
            }
            
            break;
        } else {
            NSString *childSerialization = [[self objectForKey:key] serializeAtDepth:(depth+1) withError:error];
            
            if (childSerialization == nil) {
                return nil;
            }
            
            [result appendString:[Serializer getIndentStringForDepth:depth]];
            [result appendFormat:@"\"%@\":\n", key];
            [result appendString:childSerialization];
        }
    }
    
    if (*error != nil) {
        return nil;
    }
    
    return result;
}

@end
