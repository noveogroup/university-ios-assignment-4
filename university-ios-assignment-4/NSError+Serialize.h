//
// Created by admin on 12/07/16.
// Copyright (c) 2016 tanya. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *SerializerErrorDomain;

typedef NS_ENUM(NSUInteger, SerializerErrorCode) {
    SerializerErrorNotDictionary,
    SerializerErrorIncorrectType,
    SerializerErrorInvalidKey
};

@interface NSError (Serialize)

+ (instancetype)serializerErrorNotDictionary:(id)object;
+ (instancetype)serializerErrorIncorrectType:(id)object;
+ (instancetype)serializerErrorInvalidKey:(id)object;
@end