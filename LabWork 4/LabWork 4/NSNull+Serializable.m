

#import "NSNull+Serializable.h"

@implementation NSNull (Serializable)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    return @"NSNull";
}

@end
