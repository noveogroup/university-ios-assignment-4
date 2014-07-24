#import "NSValue+Serializable.h"
#import "Serializer.h"

int main(int argc, char * argv[])
{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];

	NSLog(@"%@", [[[Serializer alloc] init] serialize:dictionary WithError:nil]);

	[dictionary setValue:@"one" forKey:@"1"];

	NSLog(@"%@", dictionary);

	NSLog(@"%@", [[[Serializer alloc] init] serialize:dictionary WithError:nil]);

	NSError *__autoreleasing error = nil;

	NSValue *myValue = [NSValue valueWithCGRect:CGRectMake(2.5, 2.5, 5.0, 7.0)];

	NSArray *myArray = [NSArray arrayWithObjects:@(3), @(2), @(1), myValue, [NSNull null], nil];

	NSArray *myKeysArray = [NSArray arrayWithObjects:@"Key 3", @"Key 2", @"Key 1", @"Key myValue", @"Key NullValue", nil];

	NSDictionary *myDictionary = [NSDictionary dictionaryWithObjects:myArray forKeys:myKeysArray];

	NSString *serializedObject = [[[Serializer alloc] init] serialize:myDictionary WithError:&error];

	if (serializedObject && &error)
	{
		NSLog(@"Object has been serialized: \n%@", serializedObject);
	}
	else
	{
		NSLog(@"Serialize error has been occured!\nError code:%d\nError Domain:%@\n",[error code], [error domain]);
	}

	return 0;
}
