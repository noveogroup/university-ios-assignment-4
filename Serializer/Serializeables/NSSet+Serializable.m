#import "NSSet+Serializable.h"
#import "Serializer.h"


@implementation NSSet (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	NSMutableString *result = [[NSMutableString alloc] init];
	Serializer *serializer = [[Serializer alloc] init];

	[result appendString:@"set: ("];

	// CR: define element as id<Serializable>.
	for (id element in self)
	{
		NSString *serializedElement = [serializer serialize:element withError:error];

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

	[result appendString:@")\n"];

	return result;
}

@end