//
//  main.m
//  university-ios-assignment-4
//
//  Created by admin on 12/07/16.
//  Copyright © 2016 tanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Serializer.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSArray *array = @[@5, @4, @3];
        NSArray *stringArray = @[@"a", @"b", @"c"];
        NSSet *set = [[NSSet alloc] initWithArray:array];
        CGRect rect = CGRectMake(0,0,100,100);
                CGPoint point = CGPointMake(0,0);
        NSDictionary *dictionary = @{
                @"test": @"dfg",
                @1: @{
                        @2: @"Ddfg",
                        @3: @[array,@2,@3],
                        @"dfgk": @"kjdfg"
                },
                @2: @"sdjfn",
                @"set": set,
                @4: [NSNull null],
                @"rect": [NSValue valueWithCGRect:rect],
//                @"point": [NSValue valueWithCGPoint:point],
                @5: stringArray,
                array: @"DFG"
        };
        
        NSError *error;
        NSString *string = [Serializer serializerByDictionary:dictionary error:&error];
        if(error) {
            NSLog(@"%@", error);
        } else{
            NSLog(@"%@", string);
        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
