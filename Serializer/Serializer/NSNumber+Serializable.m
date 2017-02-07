//
//  NSNumber+Serializable.m
//  Serializer
//
//  Created by Admin on 28/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "NSNumber+Serializable.h"
#import "Serializer.h"


@implementation NSNumber (Serializable) 

- (NSString *)serializeAtDepth:(unsigned int)depth withError:(NSError *__autoreleasing *)error {
    NSMutableString *result = [[NSMutableString alloc] init];
    
    [result appendFormat:@"%@", [self description]];
    
    return result;
}

@end
