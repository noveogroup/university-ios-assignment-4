#import "NSNumber+Serializable.h"


@implementation NSNumber (Serializable)

- (NSString *)serialize
{
	return self.description;
}

@end