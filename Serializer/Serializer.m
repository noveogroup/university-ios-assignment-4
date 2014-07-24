#import "Serializer.h"

#import "Constants.h"
#import "Serializeable.h"


@implementation Serializer

- (NSString *)serialize:(id)object WithError:(NSError **)error
{
	if ([object conformsToProtocol:@protocol(Serializeable)])
	{
		return [object serializeWithError:NULL];
	}
	else
	{
		if (*error != NULL)
		{
			*error = [[NSError alloc] initWithDomain:MyOwnDomain code:SerializationNotSupported userInfo:nil];
		}

		return nil;
	}
}

@end