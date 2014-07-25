#import "Serializer.h"

#import "Constants.h"
#import "Serializable.h"


@implementation Serializer

- (NSString *)serialize:(id<Serializable>)object withError:(NSError **)error
{
	return [object serializeWithError:error];
}

@end