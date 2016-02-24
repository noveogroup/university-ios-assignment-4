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
        
        CGRect rect = CGRectMake(10, 10, 150, 200);
        NSValue *value = [NSValue valueWithCGRect:rect];
        NSNull *null = [[NSNull alloc] init];
        NSNumber *intNumber = @35;
        NSNumber *floatNumber = @45.3;
        NSString *string = @"string";
        NSArray *array1 = @[value, intNumber, value, null];
        NSArray *array2 = @[floatNumber, array1];
        NSDictionary *dict1 = @{@"key1" : array2};
        NSDictionary *dict2 = @{@"key2" : dict1};
        NSDictionary *dictonary = @{@5 : dict2};
        NSSet *set = [NSSet setWithObjects:array2, value, nil];
        
        
        //dictionary contains incorrect object
        NSDictionary *dirtyDict1 = @{value : @[set, array1]};
        NSDictionary *dirtyDict2 = @{@"key" : @[string, set]};

        
        
        
        
    }
    return 0;
}
