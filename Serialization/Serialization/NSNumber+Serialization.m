
#import "NSNumber+Serialization.h"

@implementation NSNumber (Serialization)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    return [NSString stringWithFormat:@"%@", self];
}

@end
