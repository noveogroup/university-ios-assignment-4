//
//  NSArray+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSArray+Serialize.h"

@implementation NSArray (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    NSMutableString *string = [NSMutableString stringWithString:@"["];
    
    if ([self isKindOfClass:[NSArray class]]) {
        
        for (id obj in self) {
            
            if ([obj respondsToSelector:@selector(serializeWithError:)]) {
                
                NSString *str = [obj serializeWithError:error] ? [obj serializeWithError:error] : @"nill";
                [string appendString:str];
                
                if (![obj isEqual:[self lastObject]]) {
                    [string appendString:@", "];
                }
                
            } else {
                
                if (error) {
                    
                    NSDictionary *userInfo = @{@"DictionaryContainsInvalidObjectType" : [obj class]};
                    
                    (*error) = [NSError errorWithDomain:VEErrorDomain
                                                   code:VEErrorDictionaryContainsInvalidObjectType
                                               userInfo:userInfo];
                    
                    return nil;
                }
            }
            
        }
        

        
    } else if ([self isKindOfClass:[NSDictionary class]]    ||
               [self isKindOfClass:[NSSet class]]           ||
               [self isKindOfClass:[NSNumber class]]        ||
               [self isKindOfClass:[NSNull class]]          ||
               [self isKindOfClass:[NSValue class]]) {
        
        return [self serializeWithError:error];
    
    } else {
        if (error) {
            return nil;
        }
        
    }
    
    [string appendString:@"]"];
    
    return [string copy];
}

@end
