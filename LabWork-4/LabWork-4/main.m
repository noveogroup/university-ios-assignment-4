#import <Foundation/Foundation.h>
#import "Serializer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;
        CGRect testRect = CGRectMake(1.1, 2.2, 3.3, 4.4);
        NSDictionary *testDictionary = @{@"CGRect": [NSValue valueWithRect: testRect],
                                         @"isAlive": @1, @"age": @25, @"height_cm": @167.6, @"address": @{@"streetAddress": @21, @"postalCode": @100213100},
                                         @"phoneNumbers": @[@{@"type": @1, @"number": @2125551234}, @{@"type": @2, @"number": @6465554567}],
                                         @"children": @[], @"spouse": [NSNull null]};
        NSString *serializedDictionary = [Serializer serializeDictionary:testDictionary error:&error];
        NSLog(@"%@", serializedDictionary);
    }
    return 0;
}