
#import "NSDictionary+Serialization.h"

@implementation NSDictionary (Serialization)

- (void)serializeToString:(NSMutableString *)string error:(NSError *__autoreleasing *)error
{
    [string appendString:@"{ "];
    
    for (id key in self) {
        
        if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]]) {
            
            [string appendString:[NSString stringWithFormat:@"%@: ", key]];
            
            if ([self[key] conformsToProtocol:@protocol(Serializing)]) {
                
                [self[key] serializeToString:string error:error];
                
                if (*error) {
                    return;
                }
            }
            else {
                
                NSString *description = [NSString stringWithFormat:@"Found object of class %@, which does not conform Serializing protocol", [self[key] class]];
                *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidValueObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(description, nil)}];
                return;
            }
            
            [string appendString:@", "];
            
        } else {
            
            *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorInvalidKeyObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Key object of dictionary is not a NSString or NSNumber", nil)}];
            return;
        }
    }
    
    if ([[string substringFromIndex:[string length]-2] isEqualToString:@", "]) {
        [string deleteCharactersInRange:NSMakeRange([string length]-2, 2)];
    }
    
    [string appendString:@" }"];
}

@end
