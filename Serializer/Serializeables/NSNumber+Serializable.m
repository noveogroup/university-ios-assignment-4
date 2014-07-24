#import "NSNumber+Serializable.h"


@implementation NSNumber (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	return self.description;
}

@end