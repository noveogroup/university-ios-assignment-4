//
//  main.m
//  Serializer
//
//  Created by Vik on 23.02.16.
//  Copyright © 2016 Viktor Erfilov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VESerializer.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        VESerializer *serializer = [[VESerializer alloc] init];
        NSError *error = nil;
        
        NSValue *value1 = [NSValue valueWithCGRect:CGRectMake(10, 10, 100, 200)];
        NSValue *value2 = [NSValue valueWithCGRect:CGRectMake(350.3, 100.1, 100.5, 200)];

        NSNull *null = [[NSNull alloc] init];
        NSNumber *intNumber = @35;
        NSNumber *floatNumber = @45.3;
        NSString *string = @"string";
        NSArray *array1 = @[intNumber, null];
        NSArray *array2 = @[floatNumber, array1, value1, null];
        NSDictionary *dict1 = @{@"key1" : array2};
        NSSet *set1 = [NSSet setWithObjects:array2, value1, nil];
        NSSet *set2 = [NSSet setWithObjects:@5, @3.4, @[@1, @2, @3], null, nil];
        NSSet *set3 = [NSSet setWithObjects:string, @3.4, @[@1, @2, @3], null, nil];
        NSDictionary *dict2 = @{@"key2" : dict1, @"key3" : set1};
        
        NSDictionary *test = @{@"someKey1" : array1, @"someKey2" : set1, @4 : dict1, intNumber : dict2, @"someKey3" : @[set2, value2]};
        
        //dictionary contains incorrect object
        NSDictionary *dirtyDict1 = @{array1 : @[set1, array1]};
        NSDictionary *dirtyDict2 = @{@"key" : @[set3, @3]};
        
        
        
        //testing with errors
        
        //1
        NSLog(@"%@", [serializer serializeDictionary:string withError:&error]);
        NSLog(@"%@\n\n", error);

        //2
        error = nil;
        NSLog(@"%@", [serializer serializeDictionary:dirtyDict1 withError:&error]);
        NSLog(@"%@\n\n", error);

        //3
        error = nil;
        NSLog(@"%@", [serializer serializeDictionary:dirtyDict2 withError:&error]);
        NSLog(@"%@\n\n", error);
        
        
        //testing with correct data
        error = nil;
        NSLog(@"%@", [serializer serializeDictionary:test withError:&error]);
        if (error) {
            NSLog(@"%@", error);
        }

        
    }
    return 0;
}
