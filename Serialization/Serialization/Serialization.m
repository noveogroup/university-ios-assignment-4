
#import "Serialization.h"
#import "NSDictionary+Serialization.h"

@implementation Serialization

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error
{
    if (*error) {
        return nil;
    }
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
    
        return [dict serializeWithError:error];
    }
    else {
        
        *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorNonDictionaryRootObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Root object is not a NSDictionary object", nil)}];
    }
    
    return nil;
}

@end












