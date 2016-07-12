//
//  NSArray+Serialization.m
//  LabWork4
//
//  Created by Vladislav Librecht on 12.07.16.
//  Copyright © 2016 Vladislav Librecht. All rights reserved.
//

#import "NSArray+Serialization.h"

@implementation NSArray (Serialization)

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error
{
    [string appendString:@"[ "];
    
    for (id elem in self) {
        
        if ([elem conformsToProtocol:@protocol(Serializing)]) {
            
            [elem serializeToString:string error:error];
            
            if (*error) {
                return;
            }
        }
        else {
            
            NSString *description = [NSString stringWithFormat:@"Found object of class %@, which does not conform Serializing protocol", [elem class]];
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
            return;
        }
        
        [string appendString:@", "];
    }
    
    if ([[string substringFromIndex:[string length]-2] isEqualToString:@", "]) {
        [string deleteCharactersInRange:NSMakeRange([string length]-2, 2)];
    }
    
    [string appendString:@" ]"];
}

@end
