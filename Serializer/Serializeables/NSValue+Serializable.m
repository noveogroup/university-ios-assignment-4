#import "NSValue+Serializable.h"

@implementation NSValue(Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	if (strcmp([self objCType], @encode(CGRect)) == 0)
	{
		CGRect rect = [self CGRectValue];

		return [NSString stringWithFormat:@"CGRect: [(%f, %f), (%f, %f)]", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
	}
	else
	{
		return nil;
	}
}

@end