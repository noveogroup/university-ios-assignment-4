
#import "NSDictionary+Serialization.h"

@implementation NSDictionary (Serialization)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    
    for (id key in self) {
        
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            
            if ([self[key] conformsToProtocol:@protocol(Serializing)]) {
                
                [array addObject:[NSString stringWithFormat:@"%@: %@", key, [self[key] serializeWithError:error]]];
                
                if (*error) {
                    return nil;
                }
            }
            else {
                
                NSString *description = [NSString stringWithFormat:@"Found object of class %@, which does not conform Serializing protocol", [self[key] class]];
                *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
                return nil;
            }
        }
        else {
            
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidKeyObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Key object of dictionary is not a NSString or NSNumber", nil)}];
            return nil;
        }
    }
    
    return [NSString stringWithFormat:@"{%@}", [array componentsJoinedByString:@", "]];
}

@end
