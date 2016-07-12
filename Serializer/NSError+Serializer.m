//
//  NSError+Serializer.m
//  Serializer
//

#import "NSError+Serializer.h"

static NSInteger const kObjectErrorCode = 1;
static NSInteger const kKeyErrorCode = 2;
static NSInteger const kValueErrorCode = 3;
static NSString *const kObjectErrorDomain = @"Wrong object";
static NSString *const kKeyErrorDomain = @"Wrong key";
static NSString *const kValueErrorDomain = @"Wrong value";

@implementation NSError (Serializer)

+ (NSError *)errorWithKey:(id)key
{
    NSDictionary *userInfo = @{@"description":@"Unexpected type of key in dictionary",
                               @"keyType":[key class]};
    return [[NSError alloc] initWithDomain:kKeyErrorDomain code:kKeyErrorCode userInfo:userInfo];
}

+ (NSError *)errorWithObject:(id)object
{
    NSDictionary *userInfo = @{@"description":@"Unexpected type of object during sirialization",
                               @"objectType":[object class]};
    return [[NSError alloc] initWithDomain:kObjectErrorDomain code:kObjectErrorCode userInfo:userInfo];
}

+ (NSError *)errorWithValue:(NSValue *)val
{
    NSDictionary *userInfo = @{@"description":@"Only CGRect is allowed in NSValue",
                               @"objCType":[NSString stringWithFormat:@"%s",val.objCType]};
    return [[NSError alloc] initWithDomain:kValueErrorDomain code:kValueErrorCode userInfo:userInfo];
}

@end
