//
//  NSArray+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSArray+Serialize.h"
#import "NSError+Serialize.h"

@implementation NSArray (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    NSMutableString *string = [NSMutableString stringWithString:@"["];
    
    for (id obj in self) {
        
        if ([obj respondsToSelector:@selector(serializeWithError:)]) {
            
            NSString *str = [obj serializeWithError:error] ? : @"nill";
            
            [string appendString:str];
            
            [string appendString:@", "];
            
        } else {
            
            if (error) {
                
                (*error) = [NSError errorInvalidObjectType:obj];
                
                return nil;
            }
        }
        
    }
    
    string = [[string substringToIndex:[string length] - 2] mutableCopy];
    
    [string appendString:@"]"];
    
    return [string copy];
}

@end
