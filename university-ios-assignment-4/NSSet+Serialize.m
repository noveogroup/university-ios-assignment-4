//
//  NSSet.m
//  university-ios-assignment-4
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NSSet+Serialize.h"
#import "NSArray+Serialize.h"

@implementation NSSet (Serialize)

- (NSString *)serialiseWithError:(NSError *__autoreleasing *)error
{
    NSArray *array = [self allObjects];
    return [array serialiseWithError:error];
}

@end
