//
//  NSArray+Serialization.m
//  LabWork4
//
//  Created by Vladislav Librecht on 12.07.16.
//  Copyright © 2016 Vladislav Librecht. All rights reserved.
//

#import "NSArray+Serialization.h"

@implementation NSArray (Serialization)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    
    for (id elem in self) {
        
        if ([elem conformsToProtocol:@protocol(Serializing)]) {
            
            [array addObject:[elem serializeWithError:error]];
            
            if (*error) {
                return nil;
            }
        }
        else {
            
            NSString *description = [NSString stringWithFormat:@"Found object of class %@, which does not conform Serializing protocol", [elem class]];
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
            return nil;
        }
    }
    
    return [NSString stringWithFormat:@"[%@]", [array componentsJoinedByString:@", "]];
}

@end
