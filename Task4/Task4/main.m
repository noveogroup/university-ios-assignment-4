//
//  main.m
//  Task4
//
//  Created by Sergey Plotnikov on 13.07.16.
//
//

#import <Foundation/Foundation.h>
#import "Serializer.h"
#import "NSValue+Serializable.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSError *error = nil;
        NSValue *value = [NSValue valueWithCGRect:CGRectMake(1, 1, 5, 5)];
        NSMutableArray *mutableArray = [@[@(1), @(2), @(YES)] mutableCopy];
        NSSet *set = [NSSet setWithArray:@[@"ABC", @"DEF", @(1)]];
        NSArray *array = @[mutableArray, value, set, [NSNull null], @(1)];
        NSArray *keys = @[@"Key MutableArray", @"Key Value", @"Key Set", @"Key Null", @"Key 1"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:array forKeys:keys];
        NSLog(@"%@", [Serializer serializeContainer:dictionary error:&error]);
    }
    return 0;
}
