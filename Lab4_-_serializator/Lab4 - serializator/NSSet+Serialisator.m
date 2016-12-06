#import "NSSet+Serialisator.h"
#import "NSArray+Serialisator.h"

@implementation NSSet (Serialisator)

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error
{
    NSArray *arr = [self allObjects];
    return [arr serialiseWithErrorLink:error];
}

@end
