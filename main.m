//
//  main.m
//  4lab
//
//  Created by Сонечка on 26.07.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

#import "Serializer.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        NSError *error = nil;
        
        NSNull *n = [[NSNull alloc] init];
        NSNumber *c1 = [[NSNumber alloc] initWithChar:'w'];
        NSNumber *c2 = [[NSNumber alloc] initWithInt:12];
        NSNumber *c3 = [[NSNumber alloc] initWithBool:YES];
        NSNumber *c4 = [[NSNumber alloc] initWithDouble:3.34];
        NSNumber *c5 = [[NSNumber alloc] initWithBool:NO];
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys: n, @"0", c1, @"1", c2, @"2", c3, @"3", c4, @"4", nil];
        
        NSSet *set = [[NSSet alloc] initWithObjects: [[NSNumber alloc] initWithFloat:56456], [[NSArray alloc]initWithObjects: c1, c2, c3, nil], [[NSNull alloc] init], nil];
        CGRect rect = CGRectMake(10, 20, 50, 60);
        NSValue *value;
        value = [NSValue valueWithCGRect:rect];

        NSDictionary *insideDictionary = [NSDictionary alloc];
        insideDictionary = [NSDictionary dictionaryWithObjectsAndKeys: n, @"0", c1, @"1", c2, @"2", c3, @"3", c4, @"4", c5, @"6", dictionary, @"8", set, @"9", value, @"11", nil];
        
        NSMutableSet *wrongInputType = [[NSMutableSet alloc] init];
        
        NSDictionary *wrongTypeOfObject = [[NSDictionary alloc] initWithObjectsAndKeys:insideDictionary, @"1", @"the strings are forbidden", @"5", nil];
        
//        NSDictionary *wrongTypeOfKey = [[NSDictionary alloc] initWithObjectsAndKeys:insideDictionary, @"1", dictionary, c1, nil];
        
        NSLog(@"%@", [Serializer serialize: insideDictionary error: &error]);
        
        if(error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
            NSLog(@"%@", [error localizedFailureReason]);
            NSLog(@"%@", [error localizedRecoverySuggestion]);
            error = nil;
        }
        
        NSLog(@"%@", [Serializer serialize: wrongInputType error: &error]);
        
        if(error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
            NSLog(@"%@", [error localizedFailureReason]);
            NSLog(@"%@", [error localizedRecoverySuggestion]);
            error = nil;
        }
        
//        NSLog(@"%@", [Serializer serialize: wrongTypeOfKey error: &error]);
//        
//        if(error != nil)
//        {
//            NSLog(@"%@", [error localizedDescription]);
//            NSLog(@"%@", [error localizedFailureReason]);
//            NSLog(@"%@", [error localizedRecoverySuggestion]);
//            error = nil;
//        }

        NSLog(@"%@", [Serializer serialize: wrongTypeOfObject error: &error]);
        
        if(error != nil)
        {
            NSLog(@"%@", [error localizedDescription]);
            NSLog(@"%@", [error localizedFailureReason]);
            NSLog(@"%@", [error localizedRecoverySuggestion]);
            error = nil;
        }


        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
