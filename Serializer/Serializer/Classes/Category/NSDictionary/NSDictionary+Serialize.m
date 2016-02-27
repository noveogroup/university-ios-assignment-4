//
//  NSDictionary+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSDictionary+Serialize.h"
#import "NSError+Serialize.h"

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
                    
                    (*error) = [NSError errorInvalidObjectType:self];
                    
                    return nil;
                }
            }
        
        } else {
            
            if (error) {
                
                (*error) = [NSError errorInvalidKeyType:key];
                
                return nil;
                
            }
            
        }
        
    }

    [string appendString:@"}"];
    
    return [string copy];
    
}

@end
