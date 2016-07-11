//
//  NSArray.m
//  university-ios-assignment-4
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NSArray+Serialize.h"

@implementation NSArray (Serialize)

- (NSString *)serialiseWithError:(NSError *__autoreleasing *)error
{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"["];
    for (id object in self) {
        if ([object respondsToSelector:@selector(serialiseWithError:)]){
            NSString *tmpString = [object serialiseWithError:error];
            if(*error){
                return nil;
            }
            [string appendFormat:@"%@, ", tmpString];
        }
    }
    [string appendString:@"]"];
    return [string copy];
}

@end
