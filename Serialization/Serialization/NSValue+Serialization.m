
#import "NSValue+Serialization.h"

@implementation NSValue (Serialization)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    CGRect rect = [self CGRectValue];
    return [NSString stringWithFormat:@"CGRect(%g, %g, %g, %g)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
}

@end
