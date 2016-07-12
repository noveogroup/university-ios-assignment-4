
#import "NSSet+Serialization.h"

@implementation NSSet (Serialization)

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error
{
    [string appendString:@"Set{ "];
    
    for (id elem in self) {
        
        if ([elem conformsToProtocol:@protocol(Serializing)]) {
            
            [elem serializeToString:string error:error];
            
            if (*error) {
                return;
            }
        }
        else {
            
            NSString *description = [NSString stringWithFormat:@"Found object of class %@, which does not conform Serializing protocol", [elem class]];
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
            return;
        }
        
        [string appendString:@", "];
    }
    
    if ([[string substringFromIndex:[string length]-2] isEqualToString:@", "]) {
        [string deleteCharactersInRange:NSMakeRange([string length]-2, 2)];
    }
    
    [string appendString:@" }"];
}

@end
