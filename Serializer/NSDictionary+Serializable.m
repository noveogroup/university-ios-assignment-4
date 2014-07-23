#import "NSDictionary+Serializable.h"

@implementation NSDictionary (Serializable)

- (NSString *)serialize
{
	NSMutableString *result = [[NSMutableString alloc] init];

	[result appendString:@"dictionary: {"];

	for (id key in self)
	{
		if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
		{
			id value = [self objectForKey:key];

			if ([value respondsToSelector:@selector(serialize)])
			{
				[result appendFormat:@"%@ : %@", key, [value serialize]];
			}
		}
		else
		{
			return nil;
		}
	}

	[result appendString:@"}\n"];

	return result;
}

@end