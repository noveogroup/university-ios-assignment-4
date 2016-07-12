//
//  NSString+Serializer.m
//  Serializer
//

#import "NSString+Serializer.h"

@implementation NSString (Serializer)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    *error = nil;
    return self;
}

@end
