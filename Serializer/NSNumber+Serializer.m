//
//  NSNumber+Serializer.m
//  Serializer
//

#import "NSNumber+Serializer.h"

@implementation NSNumber (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing*)error
{
    *error = nil;
    NSString *result = [NSString stringWithFormat:@"%@", self];
    return result;
}

@end