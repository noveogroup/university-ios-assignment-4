//
//  NSValue+serializable.m
//  Serializer
//
//  Created by Admin on 25/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "NSValue+serializable.h"

@implementation NSValue(serializable)
-(NSMutableString*)serializeWithError:(NSError* __autoreleasing *)error{
    NSMutableString *res = [[NSMutableString alloc]init];
    res = [[self description] mutableCopy];
    if(([res rangeOfString:@"NSRect"].location) == NSNotFound)
        return nil;
    return res;
}
@end
