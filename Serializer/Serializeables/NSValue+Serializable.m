#import "NSValue+Serializable.h"

@implementation NSValue(Serializable)

- (NSString *)serializeWithError:(NSError **)error
{
	NSString *description = [self description];
	// CR: use this method to check internal value type: [self objCType].
	// CR: you should not use "description" for anything but debug purposes.
	if ([description rangeOfString:@"NSRect"].location != NSNotFound) {
		// CR: Current style expects from you this: [self CGRectValue].
		CGRect rect = self.CGRectValue;

		return [NSString stringWithFormat:@"CGRect: [(%f, %f), (%f, %f)]", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height];
	}
	else
	{
		return nil;
	}
}

@end