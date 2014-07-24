#import "NSDictionary+Serializable.h"
#import "Serializer.h"
#import "Constants.h"

@implementation NSDictionary (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	NSMutableString *result = [[NSMutableString alloc] init];
	Serializer *serializer = [[Serializer alloc] init];

	[result appendString:@"dictionary: {"];

	for (id key in self)
	{
		if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
		{
			NSString *serializedValue = [serializer serialize:self[key] WithError:error];

			if (serializedValue != nil)
			{
				[result appendFormat:@"%@: %@,\n", key, serializedValue];
			}
			else
			{
				return nil;
			}
		}
		else
		{
			if (error != nil)
			{
				*error = [[NSError alloc] initWithDomain:MyOwnDomain code:UnsupportedKeyType userInfo:nil];
			}

			return nil;
		}
	}

	if (self.count != 0)
	{
		[result replaceCharactersInRange:NSMakeRange([result length] - 2, 2) withString:@""];
	}

	[result appendString:@"}\n"];

	return result;
}

@end