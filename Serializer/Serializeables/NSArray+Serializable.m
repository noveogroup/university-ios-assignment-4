#import "NSArray+Serializable.h"
#import "Serializer.h"


@implementation NSArray (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	NSMutableString *result = [[NSMutableString alloc] init];
	Serializer *serializer = [[Serializer alloc] init];

	[result appendString:@"["];

	for (id element in self)
	{
		NSString *serializedElement = [serializer serialize:element WithError:error];

		if (serializedElement != nil)
		{
			[result appendFormat:@"%@,", serializedElement];
		}
		else
		{
			return nil;
		}
	}

	if (self.count != 0)
	{
		[result replaceCharactersInRange:NSMakeRange([result length] - 1, 1) withString:@""];
	}

	[result appendString:@"]\n"];

	return result;
}

@end