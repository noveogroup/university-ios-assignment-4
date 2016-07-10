//
//  main.m
//  university-ios-assignment-4
//
//  Created by Admin on 10.07.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Serializer.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool{
        NSArray *array = @[@5, @4, @3];
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
                @"rect": [NSValue value:&rect withObjCType:@encode(CGRect)]
        };

        NSError *error;
        NSString *string = [Serializer serializerByDictionary:dictionary error:&error];
        if(error) {
            NSLog(@"%@", error);
        } else{
            NSLog(@"%@", string);
        }
    }
    return 0;
}
