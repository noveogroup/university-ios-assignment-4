
#import "NSNull+Serialization.h"

@implementation NSNull (Serialization)

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error
{
    [string appendString:[NSString stringWithFormat:@"(null)"]];
}

@end
