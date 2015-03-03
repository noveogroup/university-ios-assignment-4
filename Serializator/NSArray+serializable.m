//
//  NSArray+serializable.m
//  Serializator
//
//  Created by Иван Букшев on 3/2/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "NSArray+serializable.h"

@implementation NSArray (serializable)

- (NSMutableString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    for (id object in self)
    {
        if ([object respondsToSelector:@selector(serializeWithError:)])
        {
            NSMutableString *temp = [[NSMutableString alloc] init];
            temp = [object serializeWithError:error];
            
            if (temp == nil)
            {
                return nil;
            }
            
            NSRange range = NSMakeRange(-1, 0);
            int location = 0;
            
            while(range.location != NSNotFound)
            {
                NSString *string = [NSString stringWithFormat:@"NSArray[%d]/", [self indexOfObject:object]];
                [temp insertString:string atIndex:(location + range.location + 1)];
                
                location += range.location + [string length];
                range = [[temp substringFromIndex:location] rangeOfString:@"\n"];
            };
            
            [result appendString:temp];
            [result appendString:@"\n"];
        }
        else if (!!error)
        {
            NSDictionary *info = @{@"WrongObject" : [object class]};
            (*error) = [NSError errorWithDomain:@"MyDomain"
                                           code:errorObjectIsNotSerializable
                                       userInfo:info];
            
            return nil;
        }
    }
    
    result = [[result substringToIndex:[result length] - 1] mutableCopy];
    
#if DEBUG
    NSLog(@"Serialize NSArray: %@", result);
#endif
    
    return result;
}

@end
