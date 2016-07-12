//
//  NSString+Serializer.m
//  Serializer
//
//  Created by admin on 12/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSString+Serializer.h"

@implementation NSString (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    return self;
}

@end
