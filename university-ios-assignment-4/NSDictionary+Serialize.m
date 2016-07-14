//
//  NSDictionary+Serilisable.m
//  university-ios-assignment-4
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NSDictionary+Serialize.h"
#import "NSError+Serialize.h"


@implementation NSDictionary (Serialize)

- (NSString *)serialiseWithError:(NSError **)error
{
    NSMutableArray *array = [NSMutableArray array];
    for (id key in self) {
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            id object = self[key];
            if ([object respondsToSelector:@selector(serialiseWithError:)]){
                NSString *tmpString = [object serialiseWithError:error];
                if(*error){
                    return nil;
                }
                [array addObject:[NSString stringWithFormat:@"\t%@: %@", key, tmpString]];
            } else{
                *error = [NSError serializerErrorIncorrectType:self];
                return nil;
            }
        } else {
            *error = [NSError serializerErrorInvalidKey:key];
            return nil;
        }
    }
    return [NSString stringWithFormat:@"{\n%@\n}",[array componentsJoinedByString:@",\n"]];
}

@end
