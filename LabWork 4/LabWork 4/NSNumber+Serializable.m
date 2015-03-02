

#import "NSNumber+Serializable.h"

@implementation NSNumber (Serializable)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    return [self stringValue];
}

@end
