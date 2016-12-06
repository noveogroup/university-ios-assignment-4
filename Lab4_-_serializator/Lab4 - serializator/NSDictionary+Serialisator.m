#import "NSDictionary+Serialisator.h"

@implementation NSDictionary (Serialisator)

- (NSString *)serialiseWithErrorLink:(NSError *__autoreleasing *)error
{
    NSMutableArray *arr = [NSMutableArray array];
    for(id key in self) {
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            id item = self[key];
            if([item conformsToProtocol:@protocol(Serialisable)]){
                NSString *tempStr = [item serialiseWithErrorLink:error];
                if (*error){
                    return nil;
                }
                [arr addObject:[NSString stringWithFormat:@"\t%@: %@", key, tempStr]];
            } else {
                NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Incorrect type of value (%@)", [self[key] class]]};
                *error = [[NSError alloc] initWithDomain:SerialisableErrorDomain code:SERIALISE_ERROR_INCORRECT_TYPE userInfo:userInfo];
            }
        } else {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"There is error in key (%@)", key]};
            *error = [[NSError alloc] initWithDomain:SerialisableErrorDomain code:SERIALISE_ERROR_INCORRECT_KEY userInfo:userInfo];
        }
    }

    return [NSString stringWithFormat:@"{\n%@\n}", [arr componentsJoinedByString:@",\n"]];
}
@end
