#import "Serializer.h"

#import "Constants.h"
#import "Serializable.h"


@implementation Serializer

- (NSString *)serialize:(id<Serializable>)object withError:(NSError **)error
{
	if ([object conformsToProtocol:@protocol(Serializable)])
	{
		return [object serializeWithError:error];
	}
	else
	{
		if (*error != NULL)
		{
			*error = [[NSError alloc] initWithDomain:myOwnDomain code:serializationNotSupported userInfo:nil];
		}

		return nil;
	}
}

@end