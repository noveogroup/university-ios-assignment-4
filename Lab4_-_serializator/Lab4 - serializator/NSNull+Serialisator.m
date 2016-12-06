#import "NSNull+Serializator.h"

@implementation NSNull (Serialisator)

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error
{
    return @"Null";
}

@end
