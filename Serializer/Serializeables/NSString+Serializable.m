#import "NSString+Serializable.h"


@implementation NSString (Serializable)
- (NSString *)serializeWithError:(NSError **)error
{
	// CR: JSON string should be in quotes.
	return [NSString stringWithFormat:@"\"%@\"", self];
}
@end