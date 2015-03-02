

#import "Serializer.h"
#import "Serializable.h"
#import "ErrorConstants.h"

@implementation Serializer

+ (NSString *)serialize:(id)dictionary WithError:(NSError *__autoreleasing *)error
{
    NSString *result;
    if([dictionary isKindOfClass:[NSDictionary class]])
    {
        result = [dictionary serializeWithError:error];
        if(*error !=nil)
            return nil;
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Input parametr is not NSDictionary"};
        *error = [[NSError alloc] initWithDomain:errorDomain code:unsupportedInputParametr userInfo:userInfo];
        return nil;
    }
    
    return result;
}

@end
