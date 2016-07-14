
#import "NSSet+Serialization.h"

@implementation NSSet (Serialization)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[self count]];
    
    for (id elem in self) {
        
        if ([elem conformsToProtocol:@protocol(Serializing)]) {
            
            [array addObject:[elem serializeWithError:error]];
            
            if (*error) {
                return nil;
            }
        }
        else {
            
            NSString *description = [NSString stringWithFormat:@"Found object of class %@, which does not conform Serializing protocol", [elem class]];
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
            return nil;
        }
    }
    
    return [NSString stringWithFormat:@"<%@>", [array componentsJoinedByString:@", "]];
}

@end
