//
//  Serializer.m
//  university-ios-assignment-4
//
//  Created by Admin on 10.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Serializer.h"

NSString *const SerializerErrorDomain = @"SerializerErrorDomain";

typedef NS_ENUM(NSUInteger, SerializerErrorCode) {
    SerializerErrorNotDictionary,
    SerializerErrorIncorrectType,
    SerializerErrorInvalidKey
};

@implementation Serializer

+ (NSString *)serializerByDictionary:(id)dictionary
                               error:(NSError **)error
{
    if ([dictionary isKindOfClass:[NSDictionary class]] ){
        NSString *string = [self convertObjectToString:dictionary error:error];
        if(*error){
            return nil;
        }
        return string;
    } else{
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Not dictionary - %@", [dictionary class]]
                                   };
        *error = [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorNotDictionary userInfo:userInfo];
        return nil;
    }
    return nil;
}

+ (NSString *)convertObjectToString:(id)object
                                  error:(NSError **)error
{
    NSMutableString *string = [NSMutableString string];
    NSString *result;

    if ([object isKindOfClass:[NSString class]]) {
        result = object;
    } else if([object isKindOfClass:[NSDictionary class]]){
        result = [self convertDictionaryToString:object error:error];
    } else if ([object isKindOfClass:[NSArray class]]){
        result = [self convertArrayToString:object error:error];
    } else if ([object isKindOfClass:[NSSet class]]){
        result = [self convertSetToString:object error:error];
    } else if ([object isKindOfClass:[NSNumber class]]){
        result = [NSString stringWithFormat:@"%@",object];
    } else if ([object isKindOfClass:[NSNull class]]){
        result = @"NULL";
    } else if ([object isKindOfClass:[NSValue class]]) {
        if (strcmp([(NSValue *) object objCType], @encode(CGRect)) == 0) {
            CGRect rect;
            [(NSValue *) object getValue:&rect];
            result = [NSString stringWithFormat:@"NSRect:{{%lf, %lf}, {%lf, %lf}}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
        } else{
            NSDictionary *userInfo = @{
                    NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type in object %@. Not CGRect", [object class]]
            };
            *error = [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorIncorrectType userInfo:userInfo];
            return nil;
        }
    } else{
        NSDictionary *userInfo = @{
                NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type in object %@", [object class]]
        };
        *error = [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorIncorrectType userInfo:userInfo];
        return nil;
    }
    if(*error){
        return nil;
    }

    [string appendString:result];

    return [string copy];
}

+ (NSString *)convertDictionaryToString:(NSDictionary *)dictionary
                                  error:(NSError **)error

{
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"{\n"];

    for (id key in dictionary) {
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {

            [string appendFormat:@"\t%@: ", key];
            NSString *result = [self convertObjectToString:dictionary[key] error:error];
            if (*error) {
                return nil;
            }
            [string appendFormat:@"%@\n",result];


        } else {
            NSDictionary *userInfo = @{
                    NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Invalid key in key %@", key]
            };
            *error = [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorInvalidKey userInfo:userInfo];
            return nil;

        }

    }

    [string appendString:@"\n}\n"];
    return [string copy];
}

+ (NSString *)convertArrayToString:(NSArray *)array
        error:(NSError **)error
{
    NSMutableString *string = [NSMutableString string];
    NSString *result;
    [string appendString:@"["];
    for (int i = 0; i < [array count]; ++i) {
        if(i==[array count]-1){
            result = [self convertObjectToString:array[(NSUInteger) i] error:error];
            if(*error){
                return nil;
            }
            [string appendFormat:@"%@", result];
        } else{
            result = [self convertObjectToString:array[(NSUInteger) i] error:error];
            if(*error){
                return nil;
            }
            [string appendFormat:@"%@, ", result];
        }
    }
    [string appendString:@"]"];
    return [string copy];
}

+ (NSString *)convertSetToString:(NSSet *)set
                             error:(NSError **)error
{
    NSMutableString *string = [NSMutableString string];
    NSString *result;
    [string appendString:@"<"];
    NSArray *array = set.allObjects;
    for (int i = 0; i < [array count]; ++i) {
        if(i==[array count]-1){
            result = [self convertObjectToString:array[(NSUInteger) i] error:error];
            if(*error){
                return nil;
            }
            [string appendFormat:@"%@", result];
        } else{
            result = [self convertObjectToString:array[(NSUInteger) i] error:error];
            if(*error){
                return nil;
            }
            [string appendFormat:@"%@, ", result];
        }
    }
    [string appendString:@">"];
    return [string copy];
}
@end
