
#import <Foundation/Foundation.h>
#import "Serialisation.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSArray *tests = @[
                           @{},
                           @{@"a": @1, @"b": [NSSet set], @"c": @[]},
                           @{@"hello": @2, @"world": @8, @1: @[@1, @2, @{@"a": @1, @"b": @2}, [NSSet setWithObjects:@1, @{@"c": @2, @"d": @3}, @7, nil], [NSNull null]], @10: [NSValue valueWithRect:CGRectMake(0, 2, 4, 6)]},
                           @"string",  // 1 error
                           @{@1: @2, @2: @"string", @3: @4},  // 2 error
                           @{@1: @2, [NSSet set]: @3, @3: @4},  // 3 error
                           @{@1: @[[[NSURL alloc] initWithString:@"www.apple.com"]]} // 2 error in array
                           ];
        
        for (id test in tests) {
            
            NSError *error = nil;
            NSString *result = [Serialisation stringFromDictionary:test error:&error];
            
            if (error) NSLog(@"%@", error);
            NSLog(@"%@", result);
            NSLog(@"---------------");
        }
    }
    return 0;
}








