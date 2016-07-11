//
//  NSNumber+Serializer.m
//  Serializer
//
//  Created by admin on 11/07/16.
//  Copyright © 2016 Saveliy. All rights reserved.
//

#import "NSNumber+Serializer.h"

@implementation NSNumber (Serializer)

-(NSMutableString *)serializeError:(NSError *__autoreleasing*)error
{
    *error = nil;
    return [NSMutableString stringWithFormat:@"%@", self];
}

@end