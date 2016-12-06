#import "NSNumber+Serialisator.h"

@implementation NSNumber (Serialisator)

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error
{
    return [NSString stringWithFormat:@"%@", self];
}

@end
