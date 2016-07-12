
#import "NSValue+Serialization.h"

@implementation NSValue (Serialization)

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error
{
    CGRect rect;
    [(NSValue *)self getValue:&rect];
    [string appendString:[NSString stringWithFormat:@"CGRect(%g, %g, %g, %g)", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height]];
}

@end
