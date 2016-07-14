//
//  NSError+Serializer.m
//  Serializer
//

#import "NSError+Serializer.h"



NSString *const kSerializerErrorDomain = @"Serializer domain";

@implementation NSError (Serializer)

+ (NSError *)errorWithKey:(id)key
{
    NSDictionary *userInfo = @{@"description":@"Unexpected type of key in dictionary",
                               @"keyType":[key class]};
    return [[NSError alloc] initWithDomain:kSerializerErrorDomain
                                      code:SerializerErrorCodeWrongKey
                                  userInfo:userInfo];
}

+ (NSError *)errorWithObject:(id)object
{
    NSDictionary *userInfo = @{@"description":@"Unexpected type of object during sirialization",
                               @"objectType":[object class]};
    return [[NSError alloc] initWithDomain:kSerializerErrorDomain
                                      code:SerializerErrorCodeWrongObject
                                  userInfo:userInfo];
}

+ (NSError *)errorWithValue:(NSValue *)val
{
    NSDictionary *userInfo = @{@"description":@"Only CGRect is allowed in NSValue",
                               @"objCType":[NSString stringWithFormat:@"%s",val.objCType]};
    return [[NSError alloc] initWithDomain:kSerializerErrorDomain
                                      code:SerializerErrorCodeWrongValue
                                  userInfo:userInfo];
}

@end
