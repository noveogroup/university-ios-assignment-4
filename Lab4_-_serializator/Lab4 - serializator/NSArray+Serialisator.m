#import "NSArray+Serialisator.h"

@implementation NSArray (Serialisator)

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error
{
    NSMutableArray *arr = [NSMutableArray array];

    for (id item in self){
        if ([item conformsToProtocol:@protocol(Serialisable)]){
            NSString *tempStr = [item serialiseWithErrorLink:error];
            if (*error){
                return nil;
            }
            [arr addObject:tempStr];
        } else {
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type of value (%@)", [item class]]};
            *error = [[NSError alloc] initWithDomain:SerialisableErrorDomain code:SERIALISE_ERROR_INCORRECT_TYPE userInfo:userInfo];
            return nil;
        }
    }
    return [NSString stringWithFormat:@"[%@]", [arr componentsJoinedByString:@", "]];
}

@end
