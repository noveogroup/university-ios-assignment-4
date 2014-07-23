#import "NSNull+Serializable.h"


@implementation NSNull (Serializable)

- (NSString *)serialize
{
	return self.description;
}

@end