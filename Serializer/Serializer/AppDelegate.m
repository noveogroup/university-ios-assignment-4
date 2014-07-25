//
//  AppDelegate.m
//  Serializer
//
//  Created by Admin on 23/07/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "AppDelegate.h"
#import "Serializer.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UITableViewController alloc]init];
    [self.window makeKeyAndVisible];
    
    Serializer *serializer = [[Serializer alloc] init];
    
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    [dictionary setValue:[[NSDictionary alloc] init] forKey:@"NSDictionary"];
    [dictionary setValue:[[NSArray alloc] init] forKey:@"NSArray"];
    [dictionary setValue:[[NSSet alloc] init] forKey:@"NSSet"];
    [dictionary setValue:[[NSNumber alloc] init] forKey:@"NSNumber"];
    [dictionary setValue:[[NSNull alloc] init] forKey:@"NSNull"];
    // TODO: add test element for NSValue
    
    NSLog(@"Serializer test:\n");
    
    NSError *error = nil;
    NSLog(@"%@", [serializer serialize:dictionary error:&error]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
