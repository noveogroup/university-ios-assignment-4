//
//  Serializer.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "Serializer.h"
#import "NSDictionary+Serializable.h"

@implementation Serializer

+ (NSString *) getIndentStringForDepth:(unsigned int)depth {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (unsigned int i = 0; i < depth; i++) {
        [result appendString:@"|-"];
    }
    
    return result;
}

- (NSString *)serialize:(id)dictionary
                  error:(NSError **)error {
    if (![dictionary isMemberOfClass:[NSDictionary class]]) {
        // TODO: create WrongClass error
        
        return nil;
    }
    
    return [dictionary serializeAtDepth:0 withError:error];
}

@end
