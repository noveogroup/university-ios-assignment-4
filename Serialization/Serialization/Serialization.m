
#import "Serialization.h"
#import "NSDictionary+Serialization.h"

@implementation Serialization

+ (NSString *)stringFromDictionary:(id)dict error:(NSError **)error
{
    if (*error) {
        return nil;
    }
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        NSMutableString *string = [[NSMutableString alloc] init];
        
        [dict serializeToString:string error:error];
        
        if (*error) {
            return nil;
        }
    
        return [NSString stringWithString:string];
    }
    else {
        
        *error = [[NSError alloc] initWithDomain:SerialisationErrorDomain code:SerialisationErrorNonDictionaryRootObject userInfo:@{NSLocalizedDescriptionKey: NSLocalizedString(@"Root object is not a NSDictionary object", nil)}];
    }
    
    return nil;
}

@end












