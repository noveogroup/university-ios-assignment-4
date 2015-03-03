//
//  NSValue+serializable.m
//  Serializator
//
//  Created by Иван Букшев on 3/3/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "NSValue+serializable.h"

@implementation NSValue (serializable)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    result = [[self description] mutableCopy];
    if (([result rangeOfString:@"NSRect"].location) == NSNotFound)
    {
        return nil;
    }

#if DEBUG
    NSLog(@"Serialize NSValue: %@", result);
#endif
    
    return result;
}

@end
