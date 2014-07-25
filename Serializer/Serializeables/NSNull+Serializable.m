#import "NSNull+Serializable.h"


@implementation NSNull (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	// CR: you should not use "description" for anything but debug purposes.
	return self.description;
}

@end