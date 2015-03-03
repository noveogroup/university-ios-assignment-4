//
//  NSNumber+serializable.m
//  Serializator
//
//  Created by Иван Букшев on 3/3/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "NSNumber+serializable.h"

@implementation NSNumber (serializable)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSString *result = [self description];
    
#if DEBUG
    NSLog(@"Serialize NSNumber: %@", result);
#endif

    return [result mutableCopy];
}

@end
