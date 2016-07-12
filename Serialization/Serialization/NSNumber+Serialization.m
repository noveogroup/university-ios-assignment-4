
#import "NSNumber+Serialization.h"

@implementation NSNumber (Serialization)

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error
{
    [string appendString:[NSString stringWithFormat:@"%@", self]];
}

@end
