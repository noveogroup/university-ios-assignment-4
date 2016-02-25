//
//  NSSet+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSSet+Serialize.h"

@implementation NSSet (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    if ([self isKindOfClass:[NSSet class]]) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
            [tempArray addObject:obj];
        }];
        
        return [[tempArray copy] serializeWithError:error];
    }
    
    return nil;
}

@end
