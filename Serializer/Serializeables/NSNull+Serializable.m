#import "NSNull+Serializable.h"


@implementation NSNull (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	return self.description;
}

@end