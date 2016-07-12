//
// Created by admin on 12/07/16.
// Copyright (c) 2016 tanya. All rights reserved.
//

#import "NSError+Serialize.h"
#import "Serilisable.h"


@implementation NSError (Serialize)
+ (instancetype)errorNotDictionary:(id)object {
    NSDictionary *userInfo = @{
            NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Not dictionary - %@", [object class]]
    };
    return [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorNotDictionary userInfo:userInfo];
}

+ (instancetype)errorIncorrectType:(id)object {
    NSDictionary *userInfo;
    if([object isKindOfClass:[NSValue class]]){
        userInfo = @{
                NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type in object %@. Not CGRect",
                                [NSString stringWithUTF8String:[object objCType]]]
        };
    }else {
        userInfo = @{
                NSLocalizedDescriptionKey : [NSString stringWithFormat:@"Incorrect type in object %@.", [object class]]
        };
    }
    return [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorIncorrectType userInfo:userInfo];
}

+ (instancetype)errorInvalidKey:(id)object {
    NSDictionary *userInfo = @{
            NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Invalid key in key %@", object]
    };
    return [[NSError alloc]initWithDomain:SerializerErrorDomain code:SerializerErrorInvalidKey userInfo:userInfo];
}


@end