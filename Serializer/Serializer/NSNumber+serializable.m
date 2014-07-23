//
//  NSNumber+serializable.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "NSNumber+serializable.h"

@implementation NSNumber(serializable)
-(NSMutableString*)serializeWithError:(NSError* __autoreleasing *)error{
    return [[self description] mutableCopy];
}
@end
