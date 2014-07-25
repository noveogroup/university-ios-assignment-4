#import "NSDictionary+Serializable.h"
#import "Serializer.h"
#import "Constants.h"

@implementation NSDictionary (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	NSMutableString *result = [[NSMutableString alloc] initWithFormat:@"dictionary: {"];

	for (id<Serializable> key in self)
	{
		if ([key isKindOfClass:[NSString class]] || [key isKindOfClass:[NSNumber class]])
		{
			NSString *serializedKey = [Serializer serialize:key withError:error];

			if (serializedKey != nil)
			{
				NSString *serializedValue = [Serializer serialize:self[key] withError:error];

				if (serializedValue != nil)
				{
					[result appendFormat:@"%@: %@,\n", serializedKey, serializedValue];
				}
				else
				{
					return nil;
				}
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
				*error = [[NSError alloc] initWithDomain:myOwnDomain code:unsupportedKeyType userInfo:nil];
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