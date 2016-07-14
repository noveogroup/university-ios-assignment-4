//
//  main.m
//  Serializer
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Serializer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;
        CGRect rect = {1,2,3,4};
        NSSize size = {5,6};
        NSSet *set = [NSSet setWithArray:@[@"In", @"the", @"set", @134, @[@2,@3]]];
        NSValue *val = [NSValue valueWithRect:rect];
        NSValue *wrongValue = [NSValue valueWithSize:size];
        
        NSDictionary *dict = @{@1:@[@112, @345],
                               @2:val,
                               @"The third":set,
                               @"Empty":[NSNull null]};
        NSLog(@"\n%@", [dict serializeWithError:&error]);
        
        NSLog(@"Errors:");
        
        dict = @{@"Wrong!!!":@[[[NSDate alloc]init],@34]};
        NSLog(@"\n%@", [dict serializeWithError:&error]);
        if (error) {
            NSLog(@"Code: %i", (int)error.code);
            NSLog(@"Domain: %@", error.domain);
            NSLog(@"UserInfo: %@", error.userInfo);
        }
        
        dict = @{val:@"Wrong!!!!"};
        NSLog(@"\n%@", [dict serializeWithError:&error]);
        if (error) {
            NSLog(@"Code: %i", (int)error.code);
            NSLog(@"Domain: %@", error.domain);
            NSLog(@"UserInfo: %@", error.userInfo);
        }
        
        dict = @{@1:wrongValue};
        NSLog(@"\n%@", [dict serializeWithError:&error]);
        if (error) {
            NSLog(@"Code: %i", (int)error.code);
            NSLog(@"Domain: %@", error.domain);
            NSLog(@"UserInfo: %@", error.userInfo);
        }
    }
    return 0;
}
