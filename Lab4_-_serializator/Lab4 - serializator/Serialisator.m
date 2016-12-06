#import "Serialisator.h"
#import "Serialisable.h"
#import "NSDictionary+Serialisator.h"

@implementation Serialisator

+ (NSString *)serialise:(id)dict error:(NSError **)error
{

    if([dict isKindOfClass:[NSDictionary class]]) {
        NSString *str = [dict serialiseWithErrorLink:error];

        if(*error) {
            return nil;
        }
        return str;
    }

    NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"It is not a dictionary, but %@", [dict class]]};
    *error = [NSError errorWithDomain:SerialisableErrorDomain code:SERIALISE_ERROR_NOT_DICTIONARY userInfo:userInfo];
    return nil;
}

@end