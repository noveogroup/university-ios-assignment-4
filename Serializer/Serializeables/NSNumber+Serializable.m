#import "NSNumber+Serializable.h"


@implementation NSNumber (Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	// CR: think about using self.stringValue.
	return self.description;
}

@end