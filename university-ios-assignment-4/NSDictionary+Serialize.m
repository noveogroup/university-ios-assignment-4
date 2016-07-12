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
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{\n"];
    
    for (id key in self) {
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            [string appendFormat:@"\t%@: ", key];
            
            id object = self[key];
            
            if ([object respondsToSelector:@selector(serialiseWithError:)]){
                NSString *tmpString = [object serialiseWithError:error];
                if(*error){
                    return nil;
                }
                [string appendFormat:@"%@\n", tmpString];
            } else{
                *error = [NSError errorIncorrectType:self];
                return nil;
            }
        } else {
            *error = [NSError errorInvalidKey:key];
            return nil;
        }
    }
    [string appendString:@"\n}\n"];
    return [string copy];
}

@end
