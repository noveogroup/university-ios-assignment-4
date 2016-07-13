//
// Created by admin on 12/07/16.
// Copyright (c) 2016 tanya. All rights reserved.
//

#import "NSError+Serialize.h"
#import "Serilisable.h"

static NSString *kInvalidKeyErrorFormat = @"Invalid key in key %@";
static NSString *kIncorrectTypeErrorFormat = @"Incorrect type in object %@.";
static NSString *kIncorrectTypeNotRectErrorFormat = @"Incorrect type in object %@. Not CGRect";
static NSString *kNotDictionaryErrorFormat = @"Not dictionary - %@";

@implementation NSError (Serialize)
+ (instancetype)errorNotDictionary:(id)object {
    NSDictionary *userInfo = @{
            NSLocalizedDescriptionKey: [NSString stringWithFormat:kNotDictionaryErrorFormat, [object class]]
    };
    return [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorNotDictionary userInfo:userInfo];
}

+ (instancetype)errorIncorrectType:(id)object {
    NSDictionary *userInfo;
    if([object isKindOfClass:[NSValue class]]){
        userInfo = @{
                NSLocalizedDescriptionKey: [NSString stringWithFormat:kIncorrectTypeNotRectErrorFormat,
                                [NSString stringWithUTF8String:[object objCType]]]
        };
    }else {
        userInfo = @{
                NSLocalizedDescriptionKey : [NSString stringWithFormat:kIncorrectTypeErrorFormat, [object class]]
        };
    }
    return [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorIncorrectType userInfo:userInfo];
}

+ (instancetype)errorInvalidKey:(id)object {
    NSDictionary *userInfo = @{
            NSLocalizedDescriptionKey: [NSString stringWithFormat:kInvalidKeyErrorFormat, object]
    };
    return [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorInvalidKey userInfo:userInfo];
}


@end