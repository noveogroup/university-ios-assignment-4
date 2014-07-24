#import "CheckingSerializer.h"

#import "Constants.h"

@implementation CheckingSerializer

- (NSString *)serialize:(id)object WithError: (NSError **)error
{
	if ([object isKindOfClass:[NSDictionary class]])
	{
		return [super serialize:object WithError:error];
	}
	else
	{
		*error = [[NSError alloc] initWithDomain:MyOwnDomain code:UnsupportedParameterType userInfo:nil];
		return nil;
	}
}

@end