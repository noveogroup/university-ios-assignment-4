//
//  NSArray.m
//  university-ios-assignment-4
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NSArray+Serialize.h"
#import "NSError+Serialize.h"

@implementation NSArray (Serialize)

- (NSString *)serialiseWithError:(NSError *__autoreleasing *)error
{
    NSMutableArray *array = [NSMutableArray array];
    for (id object in self) {
        if ([object respondsToSelector:@selector(serialiseWithError:)]){
            NSString *tmpString = [object serialiseWithError:error];
            if(*error){
                return nil;
            }
            [array addObject:tmpString];
        } else {
            *error = [NSError serializerErrorIncorrectType:self];
            return nil;
        }
    }
    return [NSString stringWithFormat:@"[%@]",[array componentsJoinedByString:@", "]];
}

@end
