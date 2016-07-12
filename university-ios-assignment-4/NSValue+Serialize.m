//
//  NSValue.m
//  university-ios-assignment-4
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NSValue+Serialize.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Serializer.h"

@implementation NSValue (Serialize)

- (NSString *)serialiseWithError:(NSError *__autoreleasing *)error
{
    NSString *string;
    if(strcmp([self objCType], [[NSValue valueWithCGRect:CGRectZero] objCType]) == 0){
        CGRect rect = [self CGRectValue];
        string = [NSString stringWithFormat:@"NSRect:{{%lf, %lf}, {%lf, %lf}}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];

    } else{
        NSDictionary *userInfo = @{
                NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type in object %@. Not CGRect", [NSString stringWithUTF8String:[self objCType]]]
        };
        *error = [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorIncorrectType userInfo:userInfo];
        return nil;
    }

    return string;
}
@end
