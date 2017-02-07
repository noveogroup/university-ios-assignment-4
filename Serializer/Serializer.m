#import "Serializer.h"


@implementation Serializer

+ (NSString *)serialize:(id<Serializable>)object withError:(NSError **)error
{
	return [object serializeWithError:error];
}

@end