//
//  NSSet+serializable.m
//  Serializator
//
//  Created by Иван Букшев on 3/3/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "NSSet+serializable.h"

@implementation NSSet (serializable)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (id object in self)
    {
        if ([object respondsToSelector:@selector(serializeWithError:)])
        {
            NSString *temp = [object serializeWithError:error];
            
            if (temp == nil)
            {
                return nil;
            }
            
            [result appendString:temp];
            [result appendString:@"\n"];
        }
        else if (!!error)
        {
            NSDictionary *info = @{@"WrongKey" : [object class]};
            (*error) = [NSError errorWithDomain:@"MyDomain"
                                           code:errorObjectIsNotSerializable
                                       userInfo:info];
            
            return nil;
        }
    }
    
    result = [[result substringToIndex:[result length] - 1] mutableCopy];
    
    NSRange range = NSMakeRange(-1, 0);
    int location = 0;
    
    while (range.location != NSNotFound)
    {
        NSString *string = [NSString stringWithFormat:@"%@/", [NSSet description]];
        
        location += range.location + [string length];
        range = [[result substringToIndex:location] rangeOfString:@"\n"];
    };
    
#if DEBUG
    NSLog(@"Serialize NSSet: %@", result);
#endif
    
    return result;
}

@end
