

#import "NSDictionary+Serializable.h"
#import "ErrorConstants.h"

@implementation NSDictionary (Serializable)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableString *result = [@"\n{[NSDictionary]: " mutableCopy];
    
    if([self count] == 0)
    {
        [result appendString:@"Dictionary is empty}"];
        return result;
    }
    
    for(id key in self)
    {
        if([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
        {
            if ([self[key] respondsToSelector:@selector(serializeWithError:)])
            {
                [result appendString:[self[key] serializeWithError:error]];
                [result appendString:@"; "];
            }
            else
            {
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Unsupported object: [%@]", [self[key] class]]};
                *error = [[NSError alloc] initWithDomain:errorDomain code:unsupportedObject userInfo:userInfo];
                return @"[Error]";
            }
        }
        else
        {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Unsupported key on dictionaty: [%@]", [key class]]};
            *error = [[NSError alloc] initWithDomain:errorDomain code:unsupportedKeyType userInfo:userInfo];
            return @"[Error]";
        }
        
        
    }
    [result appendString:@"}"];
    return result;
}


@end
