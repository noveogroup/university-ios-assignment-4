//
//  Serializer.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "Serializer.h"
#import "NSDictionary+Serializable.h"
#import "SerializationError.h"

@implementation Serializer

+ (NSString *) getIndentStringForDepth:(unsigned int)depth {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    if (depth == 0) {
        return @"";
    }
    
    for (unsigned int i = 0; i < depth; i++) {
        [result appendString:@"    "];
    }
    
    return result;
}

- (NSString *)serialize:(NSDictionary *)dictionary
                  error:(NSError *__autoreleasing *)error {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        if (error != NULL) {
            *error = [SerializationError getNotDictionaryErrorForClass:[dictionary class]];
        }
    
        return nil;
    }
    
    return [dictionary serializeAtDepth:0 withError:error];
}

@end
