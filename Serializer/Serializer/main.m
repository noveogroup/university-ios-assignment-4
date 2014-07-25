//
//  main.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "NSNumber+serializable.h"
#import "NSNull+serializable.h"
#import "NSValue+serializable.h"
#import "NSSet+serializable.h"
#import "NSArray+serializable.h"
#import "NSDictionary+serializable.h"
#import "Serializer.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        NSError* error = nil;
        NSNull* nul = [[NSNull alloc]init];
        NSNumber* num = [NSNumber numberWithInt:5];
        NSValue* value1 = [NSValue valueWithCGRect:CGRectMake(10.f, 20.f, 30.f, 40.f)];
        NSValue* value2 = [NSValue valueWithCGRect:CGRectMake(50.f, 60.f, 70.f, 80.f)];
        NSMutableSet* set = [[NSSet setWithObjects:nul, num, nil] mutableCopy];
        NSMutableArray* array = [[NSArray arrayWithObjects:set, nil] mutableCopy];
        [array addObject:[NSNumber numberWithInt:7]];
        [array addObject:value2];
        [array addObject:value1];
        [array addObject:[NSNumber numberWithInt:123]];
        NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
        [dict setObject:array forKey:@"das"];
        NSMutableDictionary* dict2 = [[NSMutableDictionary alloc]init];
        [dict2 setObject:dict forKey:@"ololo"];
        [dict2 setObject:array forKey:@"trololo"];
        
        
        Serializer* serializer = [[Serializer alloc]init];
        NSLog(@"\n%@", [serializer serializeDictionary:dict2 error:&error]);
        NSLog(@"serializerErrorCode %ld", (long)error.code);        
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
