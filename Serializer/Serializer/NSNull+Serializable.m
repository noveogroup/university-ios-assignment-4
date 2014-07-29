//
//  NSNull+Serializable.m
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSNull+Serializable.h"
#import "Serializer.h"

@implementation NSNull (Serializable)

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendString:@"NSNull"];
    
    return result;
}


@end
