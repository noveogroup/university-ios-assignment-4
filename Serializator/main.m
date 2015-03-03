//
//  main.m
//  Serializator
//
//  Created by Иван Букшев on 3/1/15.
//  Copyright (c) 2015 Иван Букшев. All rights reserved.
//

#import "Header.h"
#import "Serializator.h"

int main(int argc, char *argv[])
{
    @autoreleasepool
    {
        NSError *error = nil;
        
        // Create test data.
        NSNull *null = [[NSNull alloc] init];
        NSNumber *number1 = [NSNumber numberWithInt:68];
        NSNumber *number2 = [NSNumber numberWithInt:-618];
        NSString *string = [NSString stringWithFormat:@"Hello, World!"];
        NSValue *value = [NSValue valueWithCGRect:CGRectMake(0.f, 2.f, 4.f, 8.f)];
        
        // Create two containers and fill.
        NSMutableSet *mutSet = [[NSSet setWithObjects:null, [NSNumber numberWithInt:10], nil] mutableCopy];
        NSMutableArray *mutArray = [[NSMutableArray alloc] initWithObjects:value, number1, number2, nil];
        
        // Create container with uncorrect data.
        NSMutableArray *mutArrayWithError = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:666], string, nil];
        
        // Create dictionary to serialize and fill it.
        NSMutableDictionary *mutDictionary = [[NSMutableDictionary alloc] init];
        [mutDictionary setObject:mutArray forKey:@"first"];
        [mutDictionary setObject:mutSet forKey:@"second"];
        
        // Create serializator.
        Serializator *serializator = [[Serializator alloc] init];
        
        // Print correct serialization result.
        NSLog(@"Result:\n%@", [serializator serialize:mutDictionary error:&error]);
        NSLog(@"Serializator Error Code: %ld", (long)error.code);
        NSLog(@"--------------------------------------------------------------------------");
        
        // Add array with error to dictionary and print serialization result.
        [mutDictionary setObject:mutArrayWithError forKey:@"third"];
        NSLog(@"Result:\n%@", [serializator serialize:mutDictionary error:&error]);
        NSLog(@"Serializator Error Code: %ld", (long)error.code);
        NSLog(@"--------------------------------------------------------------------------");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}