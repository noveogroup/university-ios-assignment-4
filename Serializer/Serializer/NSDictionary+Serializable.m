//
//  NSDictionary+Serializable.m
//  Serializer
//
//  Created by Admin on 25/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSDictionary+Serializable.h"
#import "Serializer.h"


@implementation NSDictionary (Serializable)

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:[Serializer getIndentStringForDepth:depth]];
    [result appendString:@"NSDictionary:\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL* stop) {
        [result appendString:[self serialize:value atDepth:(depth+1) error:error]];
    }];
    
    return result;
}

@end
