

#import "NSValue+Serializable.h"
#import <CoreGraphics/CGGeometry.h>
#import "ErrorConstants.h"

@implementation NSValue (Serializable)

- (NSString *)serializeWithError:(NSError *__autoreleasing *)error
{
    if (strcmp([self objCType], @encode(CGRect)) == 0)
    {
        CGRect rect;
        [self getValue:&rect];
        return [NSString stringWithFormat:@"{[CGRect]: origin:(%g, %g), size:(%g, %g)}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
    }
    else
    {
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey: @"Unsupported contents of NSValue (CGRect needed)"};
        *error = [[NSError alloc] initWithDomain:errorDomain code:unsupportedContentsOfNSValue userInfo:userInfo];
        return @"[Error]";
    }
}

@end
