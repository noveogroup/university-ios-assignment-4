//
//  NSSet+Serialize.m
//  Serializer
//
//  Created by Vik on 24.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import "VEErrors.h"
#import "NSSet+Serialize.h"
#import "NSArray+Serialize.h"

@implementation NSSet (Serialize)

- (NSString *)serializeWithError:(NSError **)error {
    
    NSArray *tempArray = [self allObjects];
    
    return [tempArray serializeWithError:error];

}

@end
