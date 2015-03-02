

#import "NSSet+Serializable.h"
#import "ErrorConstants.h"

@implementation NSSet (Serializable)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    NSMutableString *result = [@"\n{[NSSet]: " mutableCopy];
    
    if([self count] == 0)
    {
        [result appendString:@"Set is empty}"];
        return result;
    }
    
    for(id obj in self)
    {
        if ([obj respondsToSelector:@selector(serializeWithError:)])
        {
            [result appendString:[obj serializeWithError:error]];
            [result appendString:@"; "];
        }
        else
        {
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Unsupported object: [%@]", [obj class]]};
            *error = [[NSError alloc] initWithDomain:errorDomain code:unsupportedObject userInfo:userInfo];
            return @"[Error]";
        }
    }
    [result appendString:@"}"];
    return result;
}


@end
