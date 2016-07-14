
#import "NSNull+Serialization.h"

@implementation NSNull (Serialization)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    return @"(null)";
}

@end
