#import "NSNull+Serializable.h"
#import "Constants.h"


@implementation NSNull (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	return nullRepresentationString;
}

@end