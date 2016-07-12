//
//  NSNull+Serializer.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSNull+Serializer.h"

@implementation NSNull (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    return @"null";
}

@end
