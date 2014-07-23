#import "NSSet+Serializable.h"


@implementation NSSet (Serializable)

- (NSString *)serialize
{
	NSMutableString *result = [[NSMutableString alloc] init];

	[result appendString:@"set: ("];

	for (id key in self)
	{
		if ([key respondsToSelector: @selector(serialize)])
		{
			[result appendFormat:@"%@,", [key serialize]];
		}
	}

	[result appendString:@")\n"];

	return result;
}

@end