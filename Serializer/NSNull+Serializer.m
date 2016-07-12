//
//  NSNull+Serializer.m
//  Serializer
//

#import "NSNull+Serializer.h"

@implementation NSNull (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    return @"null";
}

@end
