#import "NSString+Serializable.h"


@implementation NSString (Serializable)
- (NSString *)serializeWithError:(NSError **)error
{
	return [NSString stringWithFormat:@"\"%@\"", self];
}
@end