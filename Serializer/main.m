#import "NSValue+Serializable.h"

int main(int argc, char * argv[])
{
   /* @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }*/

	[NSNumber numberWithInt:'a'];

	NSLog(@"%@", [[NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)] serializeWithError:NULL]);

	return 0;
}
