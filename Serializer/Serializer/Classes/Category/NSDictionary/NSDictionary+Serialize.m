//
//  NSDictionary+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSDictionary+Serialize.h"

@implementation NSDictionary (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    NSMutableString *string = [NSMutableString stringWithString:@"{"];

    NSArray *keys = [self allKeys];
    
    for (id key in keys) {
        
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            
            id object = [self objectForKey:key];
            
            if ([object respondsToSelector:@selector(serializeWithError:)]) {
                
                [string appendString:[NSString stringWithFormat:@"\"%@\" : ", key]];
                [string appendString:[NSString stringWithFormat:@"%@", [object serializeWithError:error]]];
                
                if (![key isEqual:[keys lastObject]]) {
                    [string appendString:@", "];
                }
                
            } else {
                if (error) {
                    
                    NSDictionary *userInfo = @{@"DictionaryContainsInvalidObjectType" : [object class]};
                    
                    (*error) = [NSError errorWithDomain:VEErrorDomain
                                                   code:VEErrorDictionaryContainsInvalidObjectType
                                               userInfo:userInfo];
                    
                    return nil;
                }
            }
        
        } else {
            
            if (error) {
                
                NSDictionary *userInfo = @{@"KeyIsObjectOfIncorrectType" : [key class]};
                
                (*error) = [NSError errorWithDomain:VEErrorDomain
                                               code:VEErrorKeyIsObjectOfIncorrectType
                                           userInfo:userInfo];
                
                return nil;
            }
            
        }
        
    }

    [string appendString:@"}"];
    
    return [string copy];
    
}

@end
