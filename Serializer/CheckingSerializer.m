#import "CheckingSerializer.h"

#import "Constants.h"

@implementation CheckingSerializer

+ (NSString *)serialize:(id <Serializable>)object withError: (NSError **)error
{
	if ([object isKindOfClass:[NSDictionary class]])
	{
		return [Serializer serialize:object withError:error];
	}
	else
	{
		if (error != NULL)
		{
			*error = [[NSError alloc] initWithDomain:myOwnDomain code:unsupportedParameterType userInfo:nil];
		}

		return nil;
	}
}

@end