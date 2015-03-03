//
//  NSDictionary+serializable.m
//  Serializator
//
//  Created by Иван Букшев on 3/2/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "NSDictionary+serializable.h"

@implementation NSDictionary (serializable)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error
{
    // String with our resulting appendings
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (id key in self)
    {
        if (![key isKindOfClass:[NSNumber class]] && ![key isKindOfClass:[NSString class]])
        {
            if (!!error)
            {
                NSDictionary *info = @{@"WrongKey" : [key class]};
                (*error) = [NSError errorWithDomain:@"MyDomain"
                                               code:errorWrongKey
                                           userInfo:info];
            }
            
            return nil;
        }
        
        id object = nil;
        NSMutableString *temp = [[NSMutableString alloc] init];
        
        if ([(object = [self objectForKey:key]) respondsToSelector:@selector(serializeWithError:)])
        {
            if ((temp = [object serializeWithError:error]) == nil)
            {
                return nil;
            }
            
            NSRange range = NSMakeRange(-1, 0);
            int location = 0;
            
            while (range.location != NSNotFound)
            {                
                NSString *string = [NSString stringWithFormat:@"NSDictionary[%@]/", key];
                [temp insertString:string atIndex:(location + range.location + 1)];
                
                location += range.location + [string length];
                range = [[temp substringFromIndex:location] rangeOfString:@"\n"];
            };
            
            [result appendString:temp];
            [result appendString:@"\n"];
        }
        else if (!!error)
        {
            NSDictionary *info = @{@"WrongInfo" : [object class]};
            (*error) = [NSError errorWithDomain:@"MyDomain"
                                           code:errorObjectIsNotSerializable
                                       userInfo:info];
            
            return nil;
        }
    }
    
    result = [[result substringToIndex:[result length] - 1] mutableCopy];
    
#if DEBUG
    NSLog(@"Serialize NSDictionary: %@", result);
#endif
    
    return result;
}

@end
