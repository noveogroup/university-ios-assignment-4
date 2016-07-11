//
//  NSNumber.m
//  university-ios-assignment-4
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NSNumber+Serialize.h"

@implementation NSNumber (Serialize)

-(NSString *)serialiseWithError:(NSError *__autoreleasing *)error
{
    return [NSString stringWithFormat:@"%@", self];
}

@end
